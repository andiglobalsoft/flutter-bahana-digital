part of '../pages.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  bool isLoading = true;
  // final _key = UniqueKey();
  // List<String>? urlNavBlog;
  late InAppWebViewController _webViewController;

  @override
  void initState() {
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WebViewController _webViewController;
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 90),
            // child: WebView(
            //   key: _key,
            //   initialUrl: 'https://ebahana.com/category/serba-serbi/artikel/',
            //   javascriptMode: JavascriptMode.unrestricted,
            //   onWebViewCreated: (controller) {
            //     _webViewController = controller;
            //   },
            //   onPageFinished: (finish) {
            //     setState(
            //       () {
            //         isLoading = false;
            //       },
            //     );
            //   },
            // ),
            child: InAppWebView(
              // initialOptions: InAppWebViewGroupOptions(
              //     crossPlatform: InAppWebViewOptions(
              //   javaScriptEnabled: true,
              //   useShouldOverrideUrlLoading: true,
              //   useOnLoadResource: true,
              //   cacheEnabled: true,
              // )),
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      'https://ebahana.com/category/serba-serbi/artikel/')),
              onLoadStart: (controller, url) {
                setState(() {
                  setState(() {
                    isLoading = true;
                  });
                });
              },
              onWebViewCreated: (InAppWebViewController controller) {
                setState(() {
                  isLoading = true;
                });
                _webViewController = controller;
              },
              onLoadStop: (controller, url) {
                setState(() {
                  isLoading = false;
                });
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  isLoading = true;
                });
              },
              onConsoleMessage: (controller, consoleMessage) {
                setState(() {
                  isLoading = true;
                });
                // it will print: {message: {"bar":"bar_value","baz":"baz_value"}, messageLevel: 1}
              },
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),

          // Header App Bar
          const HeaderSearchChatandCartWidgets(),

          Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      _webViewController.goBack();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(right: 24, bottom: 80),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: mainColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 50,
                  //   width: 50,
                  //   margin: const EdgeInsets.only(right: 24, bottom: 80),
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: mainColor,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black.withOpacity(0.5),
                  //         spreadRadius: 5,
                  //         blurRadius: 7,
                  //         offset: const Offset(0, 3),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Icon(
                  //     Icons.arrow_forward_ios_rounded,
                  //     color: whiteColor,
                  //   ),
                  // )
                ],
              )),
        ],
      ),
    );
  }
}
