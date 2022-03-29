part of '../pages.dart';

class TransactionMidtransPage extends StatefulWidget {
  final String url;
  const TransactionMidtransPage({required this.url, Key? key})
      : super(key: key);

  @override
  State<TransactionMidtransPage> createState() =>
      _TransactionMidtransPageState();
}

class _TransactionMidtransPageState extends State<TransactionMidtransPage> {
  final GlobalKey webViewKey = GlobalKey();
  final urlController = TextEditingController();

  String url = '';
  double progress = 0;

  late PullToRefreshController pullToRefreshController;
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

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isAndroid) {
      AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
    }

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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Scaffold(
        body: Stack(children: [
          SafeArea(
            child: InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
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
          )
        ]),
      ),
    );
  }
}
