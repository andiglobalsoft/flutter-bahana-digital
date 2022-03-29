part of '../pages.dart';

class NoConnectionPage extends StatelessWidget {
  const NoConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: 200,
                  width: 200,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Image.asset('assets/images/no connection.png')),
              const Text('Cek koneksi anda'),
            ],
          ),
        ),
      ),
    );
  }
}
