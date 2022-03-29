part of '../pages.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailForgetTextEditingController =
      TextEditingController();
  TextEditingController passwordForgetTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passTextEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final showDialogFormKey = GlobalKey<FormState>();

  bool isLoaded = false;
  bool _isObscure = true;
  // bool _isObscureFroget = true;
  // bool _isObscureConrimFroget = true;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        navigationPop(context);
        return false;
      },
      child: Scaffold(
        body: Stack(children: [
          //Background
          Container(color: mainColor),
          SafeArea(child: Container(color: backgroundPhoneColor)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Container(
                  height: 300,
                  margin: const EdgeInsets.only(top: 120, bottom: 28),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/LOGOBahana.png'))),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              color: backgroundPhoneColor,
              height: 300,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    //Input Email
                    TextFormField(
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontFamily: textMain, height: 1),
                      decoration: InputDecoration(
                          fillColor: whiteColor,
                          isDense: true,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontFamily: textMain,
                            fontSize: 14,
                            height: 1,
                            color: grayColor,
                          )),
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : 'Email anda salah';
                      },
                    ),
                    const SizedBox(height: 16),

                    //Input Password
                    TextFormField(
                      controller: passTextEditingController,
                      style: TextStyle(fontFamily: textMain, height: 1),
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          isDense: true,
                          fillColor: whiteColor,
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              !_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintStyle: TextStyle(
                              fontFamily: textMain,
                              fontSize: 14,
                              color: grayColor,
                              height: 1)),
                      validator: (val) {
                        return val!.isEmpty || val.length < 6
                            ? 'Periksa Kembali Password Anda'
                            : null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        //Button Login
                        GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoaded = true;
                              });
                              AuthenticationResult authenticationServices =
                                  await AuthenticationServices.signIn(
                                          email:
                                              emailTextEditingController.text,
                                          password:
                                              passTextEditingController.text)
                                      .catchError((e) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(e),
                                        actions: [
                                          TextButton(
                                            child: const Text('Coba lagi'),
                                            onPressed: () {},
                                          ),
                                        ],
                                      );
                                    });
                              });

                              if (authenticationServices.statusCode == 200) {
                                setState(() {
                                  isLoaded = false;
                                });
                                context
                                    .read<PagesBloc>()
                                    .add(const GoToMainPage());
                              } else {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Terjadi Kesalahan'),
                                        content: Text(authenticationServices
                                            .massage
                                            .toString()),
                                        actions: [
                                          TextButton(
                                            child: const Text('Mengerti'),
                                            onPressed: () {
                                              setState(() {
                                                isLoaded = false;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              }
                            }
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width / 2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: textMain,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor),
                            ),
                          ),
                        ),

                        // const Spacer(flex: 1),
                        // GestureDetector(
                        //   onTap: () {
                        //     navigation(context,
                        //         fromEvent: GoToSignInPage(),
                        //         toEvent: GoToSignUpPage());
                        //   },
                        //   child: Center(
                        //     child: Text('Daftar',
                        //         style: TextStyle(
                        //             fontFamily: textMain,
                        //             fontSize: 14,
                        //             fontWeight: FontWeight.bold,
                        //             color: mainColor)),
                        //   ),
                        // ),
                        // const Spacer(flex: 1),

                        //Button Lupa Password
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return showDialogForgetPassword();
                                });
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 70,
                            child: Text(
                              'Lupa Password',
                              style: TextStyle(
                                  fontFamily: textMain,
                                  fontSize: 14,
                                  color: grayColor),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Button Login by Google
                        // Container(
                        //   height: 45,
                        //   width: 45,
                        //   padding: const EdgeInsets.all(5),
                        //   decoration: BoxDecoration(
                        //     color: whiteColor,
                        //     shape: BoxShape.circle,
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.grey.withOpacity(0.5),
                        //         spreadRadius: 1,
                        //         blurRadius: 4,
                        //         offset: const Offset(2, 2),
                        //       ),
                        //     ],
                        //   ),
                        //   child: Image.asset(
                        //     'assets/icons/logo-google.png',
                        //   ),
                        // ),

                        //Button Daftar
                        GestureDetector(
                          onTap: () {
                            navigation(context,
                                fromEvent: GoToSignInPage(),
                                toEvent: GoToSignUpPage());
                          },
                          child: Center(
                            child: Text('Daftar',
                                style: TextStyle(
                                    fontFamily: textMain,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor)),
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          navigation(context,
                              fromEvent: GoToSignInPage(),
                              toEvent: const GoToVerificationEmailPage());
                        },
                        child: Text(
                          'Verifikasi email >',
                          style: TextStyle(
                              fontFamily: textMain,
                              fontSize: 14,
                              color: grayColor),
                        ))
                  ],
                ),
              ),
            ),
          ),

          //Header
          SafeArea(
            child: HeaderBackArrowandTitlePage('Login', onTap: () {
              navigationPop(context);
            }),
          ),

          //Loading
          (isLoaded)
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration:
                      BoxDecoration(color: Colors.white.withOpacity(0.9)),
                  child: const Center(child: CircularProgressIndicator()))
              : Container(),
        ]),
      ),
    );
  }

  Widget showDialogForgetPassword() => AlertDialog(
          title: const Text('Lupa Password'),
          content: TextField(
            onChanged: (value) {
              // setState(() {
              //   //  valueText = value;
              // });
            },
            controller: emailForgetTextEditingController,
            decoration: const InputDecoration(hintText: 'Masukan email anda'),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    // isLoaded = true;
                    Navigator.pop(context);
                  });

                  AuthenticationResult authenticationResult =
                      await AuthenticationServices.forgetPassword(
                          emailForgetTextEditingController.text,
                          passwordForgetTextEditingController.text);
                  if (authenticationResult.statusCode == 200) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          // return showDialogChangePassword();
                          return AlertDialog(
                            title: const Text('Cek Email'),
                            content:
                                Text(authenticationResult.massage.toString()),
                            actions: [
                              TextButton(
                                child: const Text('Mengerti'),
                                onPressed: () {
                                  setState(() {
                                    isLoaded = false;
                                  });
                                  emailForgetTextEditingController.text = '';
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                    setState(() {});
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Terjadi Kesalahan'),
                            content:
                                Text(authenticationResult.massage.toString()),
                            actions: [
                              TextButton(
                                child: const Text('Mengerti'),
                                onPressed: () {
                                  setState(() {
                                    isLoaded = false;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  }
                },
                child: const Text('Lanjut'))
          ]);

  // Widget showDialogChangePassword() => AlertDialog(
  //         title: const Text('Lupa Password'),
  //         content: SizedBox(
  //           height: 160,
  //           child: Form(
  //             key: showDialogFormKey,
  //             child: Column(
  //               children: [
  //                 TextFormField(
  //                   obscureText: _isObscureFroget,
  //                   onChanged: (value) {
  //                     // setState(() {
  //                     //   //  valueText = value;
  //                     // });
  //                   },
  //                   controller: passwordForgetTextEditingController,
  //                   decoration: const InputDecoration(
  //                       hintText: 'Masukan password baru anda'),
  //                   validator: (val) {
  //                     return val!.isEmpty || val.length < 6
  //                         ? 'Periksa Kembali Password Anda'
  //                         : null;
  //                   },
  //                 ),
  //                 const SizedBox(height: 18),
  //                 TextFormField(
  //                   obscureText: _isObscureConrimFroget,
  //                   onChanged: (value) {
  //                     // setState(() {
  //                     //   //  valueText = value;
  //                     // });
  //                   },
  //                   decoration: const InputDecoration(
  //                     hintText: 'Konfirmasi password baru anda',
  //                   ),
  //                   validator: (val) {
  //                     return val != passwordForgetTextEditingController.text
  //                         ? 'Periksa Kembali Password Anda'
  //                         : null;
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //               onPressed: () async {
  //                 if (showDialogFormKey.currentState!.validate()) {
  //                   AuthenticationResult authenticationResult =
  //                       await AuthenticationServices.forgetPassword(
  //                           emailForgetTextEditingController.text,
  //                           passwordForgetTextEditingController.text);
  //                   if (authenticationResult.statusCode == 200) {
  //                     setState(() {
  //                       emailForgetTextEditingController.text = '';
  //                       passwordForgetTextEditingController.text = '';
  //                       Navigator.pop(context);
  //                       showDialog(
  //                           context: context,
  //                           builder: (context) {
  //                             return AlertDialog(
  //                               title: const Text('Berhasil'),
  //                               content: Text(
  //                                   authenticationResult.massage.toString()),
  //                               actions: [
  //                                 TextButton(
  //                                   child: const Text('Mengerti'),
  //                                   onPressed: () {
  //                                     setState(() {
  //                                       isLoaded = false;
  //                                     });
  //                                     Navigator.of(context).pop();
  //                                   },
  //                                 ),
  //                               ],
  //                             );
  //                           });
  //                     });
  //                   } else {
  //                     showDialog(
  //                         context: context,
  //                         builder: (context) {
  //                           return AlertDialog(
  //                             title: const Text('Terjadi Kesalahan'),
  //                             content:
  //                                 Text(authenticationResult.massage.toString()),
  //                             actions: [
  //                               TextButton(
  //                                 child: const Text('Mengerti'),
  //                                 onPressed: () {
  //                                   setState(() {
  //                                     isLoaded = false;
  //                                   });
  //                                   Navigator.of(context).pop();
  //                                 },
  //                               ),
  //                             ],
  //                           );
  //                         });
  //                   }
  //                 }
  //               },
  //               child: const Text('Ubah'))
  //         ]);

}
