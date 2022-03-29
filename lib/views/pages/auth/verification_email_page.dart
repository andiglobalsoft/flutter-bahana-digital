part of '../pages.dart';

class VerificationEmailPage extends StatefulWidget {
  final bool fromSingUp;
  final String? email;
  const VerificationEmailPage({this.fromSingUp = false, this.email, Key? key})
      : super(key: key);

  @override
  State<VerificationEmailPage> createState() => _VerificationEmailPageState();
}

class _VerificationEmailPageState extends State<VerificationEmailPage> {
  TextEditingController emailVerificationEditingController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isbuttonklik = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            //Background
            Container(color: mainColor),
            SafeArea(child: Container(color: whiteColor)),

            SafeArea(
                child: ListView(
              padding: const EdgeInsets.only(top: 100, left: 36, right: 36),
              children: [
                Image.asset('assets/images/Verifikasi.png'),
                const SizedBox(height: 30),
                (widget.fromSingUp)
                    ? Text('Verifikasi email akan di kirim ke ${widget.email}')
                    : Form(
                        key: formKey,
                        child: TextFormField(
                          controller: emailVerificationEditingController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Email",
                            hintText: "Email",
                          ),
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : 'Email anda salah';
                          },
                        ),
                      ),
                const SizedBox(height: 8),
                Text(
                    'Jika kamu belum menerima email verifikasi \nsilakan klik tombol di bawah ini',
                    style: TextStyle(
                        fontFamily: textMain,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                const SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () async {
                      if (widget.fromSingUp) {
                        setState(() {
                          isbuttonklik = false;
                        });

                        AuthenticationResult authenticationResult =
                            await AuthenticationServices.verification(
                                email: (widget.fromSingUp)
                                    ? widget.email ?? ''
                                    : emailVerificationEditingController.text);

                        showDialog(
                            context: context,
                            builder: (builder) {
                              return AlertDialog(
                                  content: Text(
                                      authenticationResult.massage.toString()));
                            });

                        Future.delayed(const Duration(seconds: 5), () {
                          setState(() {
                            isbuttonklik = true;
                          });
                        });
                      } else {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isbuttonklik = false;
                          });

                          AuthenticationResult authenticationResult =
                              await AuthenticationServices.verification(
                                  email: (widget.fromSingUp)
                                      ? widget.email ?? ''
                                      : emailVerificationEditingController
                                          .text);

                          showDialog(
                              context: context,
                              builder: (builder) {
                                return AlertDialog(
                                    content: Text(authenticationResult.massage
                                        .toString()));
                              });

                          Future.delayed(const Duration(seconds: 5), () {
                            setState(() {
                              isbuttonklik = true;
                            });
                          });
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: (isbuttonklik) ? mainColor : Colors.grey,
                    ),
                    child: const Text('Kirim Ulang')),
                (widget.fromSingUp)
                    ? ElevatedButton(
                        onPressed: () {
                          navigationPop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: (isbuttonklik) ? mainColor : Colors.grey,
                        ),
                        child: const Text('Login'))
                    : const SizedBox()
              ],
            )),

            //Header
            SafeArea(
              child: HeaderBackArrowandTitlePage('Verifikasi', onTap: () {
                navigationPop(context);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
