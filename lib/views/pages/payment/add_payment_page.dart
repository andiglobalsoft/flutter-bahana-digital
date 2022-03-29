part of '../pages.dart';

class AddPaymentPage extends StatefulWidget {
  final AddPaymentModel addPaymentModel;
  const AddPaymentPage({required this.addPaymentModel, Key? key})
      : super(key: key);

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  // bool isLoading = true;
  // final _key = UniqueKey();
  final GlobalKey webViewKey = GlobalKey();

  late InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();
  @override
  void initState() {
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    // if (Platform.isAndroid) {
    //   AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    // }
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController.reload();
        } else if (Platform.isIOS) {
          webViewController.loadUrl(
              urlRequest: URLRequest(url: await webViewController.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Konfirmasi'),
            content: const Text(
                'Apakah mau keluar dari menu transaksi?\nTransaksi anda sudah tersimpan,\n cek di menu Transaksi.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  navigation(context,
                      fromEvent: const GoToMainPage(bottomNavBarIndex: 2),
                      toEvent: GoToTransactionPage());
                },
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // WebViewController _webViewController;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: Stack(children: [
          SafeArea(
            // child: WebView(
            //   key: _key,
            //   initialUrl: widget.addPaymentModel.redirectUrl,
            //   javascriptMode: JavascriptMode.unrestricted,
            //   onWebViewCreated: (WebViewController webViewController) {
            //     _webViewController = webViewController;
            //   },
            //   onPageStarted: (url) {
            //     print('web url' + url);
            //   },
            //   onPageFinished: (finish) {
            //     setState(() {
            //       isLoading = false;
            //     });
            //   },
            // ),

            //https://tiny.cc/gj-deeplink-test
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(
                  url: Uri.parse(widget.addPaymentModel.redirectUrl)),
              initialOptions: options,
              pullToRefreshController: pullToRefreshController,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              androidOnPermissionRequest:
                  (controller, origin, resources) async {
                return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                final uri = navigationAction.request.url!;

                log('url ' + navigationAction.request.url.toString());
                if ((uri.toString())
                    .startsWith(apiHttp + 'payment_midtrans/finish.php')) {
                  return navigation(context,
                      fromEvent: const GoToMainPage(bottomNavBarIndex: 2),
                      toEvent: GoToTransactionPage());
                } else if ((uri.toString())
                    .startsWith('https://app.midtrans.com')) {
                  return null;
                }

                launch(uri.toString());

                // if ((uri.toString()).startsWith('gojek://')) {
                //   launch(uri.toString());
                //   // return NavigationActionPolicy.ALLOW;
                // } else if ((uri.toString())
                //     .startsWith('https://wsa.wallet.airpay.co.id/')) {
                //   launch(uri.toString());
                // }

                return NavigationActionPolicy.CANCEL;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onLoadStop: (controller, url) async {
                pullToRefreshController.endRefreshing();
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onLoadError: (controller, url, code, message) {
                pullToRefreshController.endRefreshing();
              },
              onProgressChanged: (controller, progress) {
                if (progress == 100) {
                  pullToRefreshController.endRefreshing();
                }
                setState(() {
                  this.progress = progress / 100;
                  urlController.text = url;
                });
              },
              onUpdateVisitedHistory: (controller, url, androidIsReload) {
                setState(() {
                  this.url = url.toString();
                  urlController.text = this.url;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                log(consoleMessage.toString());
              },
            ),
          ),
          progress < 1.0
              ? LinearProgressIndicator(value: progress)
              : Container(),
          // isLoading
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     : Stack(),
        ]),
      ),
    );
  }
}
