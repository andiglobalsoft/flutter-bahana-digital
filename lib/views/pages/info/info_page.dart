part of '../pages.dart';

class InfoEventPage extends StatelessWidget {
  const InfoEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        //header
        SafeArea(
          child: HeaderBackArrowandTitlePage('Info',
              onTap: () => navigationPop(context)),
        ),

        //Content
      ]),
    );
  }
}