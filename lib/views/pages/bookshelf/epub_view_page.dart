part of '../pages.dart';

class EpubViewPage extends StatefulWidget {
  final String idBook;
  final String url;
  const EpubViewPage({required this.idBook, required this.url, Key? key})
      : super(key: key);

  @override
  _EpubViewPageState createState() => _EpubViewPageState();
}

class _EpubViewPageState extends State<EpubViewPage> {
  bool loading = true;
  String loadingProgressIndicator = '0';
  Dio dio = Dio();
  String filePath = '';

  @override
  void initState() {
    download();
    super.initState();
  }

  download() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await downloadFile();
    } else {
      loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Scaffold(
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(loadingProgressIndicator),
            (loadingProgressIndicator == '100')
                ? ElevatedButton(
                    onPressed: () async {
                      Directory appDocDir =
                          await getApplicationDocumentsDirectory();
                      log('$appDocDir');

                      // String iosBookPath = '${appDocDir.path}/chair.epub';
                      // print(iosBookPath);
                      // String androidBookPath = 'file:///android_asset/3.epub';
                      EpubViewer.setConfig(
                          themeColor: Theme.of(context).primaryColor,
                          identifier: "iosBook",
                          scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
                          allowSharing: true,
                          enableTts: true,
                          nightMode: false);

                      // get current locator
                      EpubViewer.locatorStream.listen((locator) {
                        log('LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
                      });

                      EpubViewer.open(
                        filePath,
                        lastLocation: EpubLocator.fromJson({
                          "bookId": widget.idBook,
                          "href": "/OEBPS/ch06.xhtml",
                          "created": 1539934158390,
                          "locations": {
                            "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
                          }
                        }),
                      );
                    },
                    child: const Text('open Epub'))
                : const SizedBox()
          ],
        )),
      ),
    );
  }

  Future downloadFile() async {
    if (await Permission.storage.isGranted) {
      await Permission.storage.request();
      await startDownload();
    } else {
      await startDownload();
    }
  }

  startDownload() async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = appDocDir!.path + '/' + (widget.url.split('/').last);

    File file = File(path);

    if (File(file.path).existsSync()) {
      await file.delete();
    }

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        widget.url,
        path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          loadingProgressIndicator =
              (receivedBytes / totalBytes * 100).toStringAsFixed(0);
          log(loadingProgressIndicator);
          setState(() {});
          //Check if download is complete and close the alert dialog
          if (receivedBytes == totalBytes) {
            loading = false;
            setState(() {
              filePath = path;
            });
          }
        },
      );
    } else {
      loading = false;
      setState(() {
        filePath = path;
      });
    }
  }
}
