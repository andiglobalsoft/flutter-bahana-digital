part of '../pages.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  TextEditingController referalTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController numberPhoneTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  XFile? _image;
  bool isKilkButton = false;
  bool isLoaded = false;
  bool _isObscure = true;
  bool _isObscureConfimation = true;

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

          //filed
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 80),
              children: [
                Center(
                  child: SizedBox(
                    height: 118,
                    width: 118,
                    child: Stack(children: [
                      Container(
                        height: 118,
                        width: 118,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: (_image == null)
                                    ? const AssetImage(
                                        'assets/images/ImgDefaul.png')
                                    : FileImage(File(_image!.path))
                                        as ImageProvider,
                                fit: BoxFit.cover)),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () async {
                              if (_image == null) {
                                _image = (await getImage());
                              } else {
                                _image = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                color: (_image == null) ? mainColor : redColor,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                (_image == null)
                                    ? Icons.camera_alt_rounded
                                    : Icons.close,
                                color: whiteColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 42),
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nama Lengkap',
                            style: TextStyle(fontFamily: textMain)),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: nameTextEditingController,
                          style: TextStyle(fontFamily: textMain, height: 1),
                          decoration: InputDecoration(
                            fillColor: whiteColor,
                            isDense: true,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (val) {
                            return (val!.length >= 3)
                                ? null
                                : 'Silakan masukan Nama Lengkap';
                          },
                        ),
                        const SizedBox(height: 30),
                        Text('Nomor Telepon',
                            style: TextStyle(fontFamily: textMain)),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: numberPhoneTextEditingController,
                          style: TextStyle(fontFamily: textMain, height: 1),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            fillColor: whiteColor,
                            isDense: true,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (val) {
                            return (val!.length >= 10)
                                ? null
                                : 'Periksa kembali nomer telepon anda';
                          },
                        ),
                        const SizedBox(height: 30),
                        Text('Email', style: TextStyle(fontFamily: textMain)),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: emailTextEditingController,
                          style: TextStyle(fontFamily: textMain, height: 1),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            fillColor: whiteColor,
                            isDense: true,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : 'Cek kembali email anda';
                          },
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2 -
                                  24 -
                                  5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Password',
                                      style: TextStyle(fontFamily: textMain)),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    controller: passwordTextEditingController,
                                    style: TextStyle(
                                        fontFamily: textMain, height: 1),
                                    obscureText: _isObscure,
                                    decoration: InputDecoration(
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
                                      fillColor: whiteColor,
                                      isDense: true,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    validator: (val) {
                                      if (val!.isEmpty || val.length < 6) {
                                        isKilkButton = true;
                                        return 'Minimal Password 6 Digit';
                                      } else {
                                        isKilkButton = false;
                                        return null;
                                      }
                                    },
                                  ),
                                  (!isKilkButton)
                                      ? Text('Minimal Password 6 Digit',
                                          style: TextStyle(
                                              fontFamily: textMain,
                                              fontSize: 12))
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2 -
                                  24 -
                                  5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Konfirmasi Password'),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    style: TextStyle(
                                        fontFamily: textMain, height: 1),
                                    obscureText: _isObscureConfimation,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          !_isObscureConfimation
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscureConfimation =
                                                !_isObscureConfimation;
                                          });
                                        },
                                      ),
                                      fillColor: whiteColor,
                                      isDense: true,
                                      filled: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    validator: (val) {
                                      return (val ==
                                              passwordTextEditingController
                                                  .text)
                                          ? null
                                          : 'Password anda tidak sama';
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          onChanged: (value) {
                            // setState(() {
                            //   //  valueText = value;
                            // });
                          },
                          controller: referalTextEditingController,
                          decoration: const InputDecoration(
                              hintText: 'Masukan kode referal jika anda punya'),
                        ),
                        const SizedBox(height: 44),
                        Center(
                          child: ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(horizontal: 64)),
                                backgroundColor:
                                    MaterialStateProperty.all(mainColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)))),
                            child: Text('Daftar',
                                style: TextStyle(fontFamily: textMain)),
                            onPressed: () async {
                              setState(() {
                                isKilkButton = true;
                              });
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoaded = true;
                                });
                                AuthenticationResult authenticationServices =
                                    await AuthenticationServices.signUp(
                                        nameTextEditingController.text,
                                        emailTextEditingController.text,
                                        numberPhoneTextEditingController.text,
                                        passwordTextEditingController.text,
                                        File(_image?.path ?? ''),
                                        referalTextEditingController.text);
                                // SignInSignUpResult result =
                                //     await UserServices.signUp(
                                //         _nameTextEditingController.text,
                                //         _emailTextEditingController.text,
                                //         _numberPhoneTextEditingController.text,
                                //         _passwordTextEditingController.text);

                                if (authenticationServices.massage != null) {
                                  setState(() {
                                    isLoaded = false;
                                  });
                                }

                                if (authenticationServices.statusCode == 200) {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Berhasil Daftar'),
                                      content: Text(authenticationServices
                                          .massage
                                          .toString()),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () async {
                                            await AuthenticationServices
                                                .verification(
                                                    email:
                                                        emailTextEditingController
                                                            .text);

                                            Navigator.pop(context, 'Mengerti');
                                            context.read<PagesBloc>().add(
                                                GoToVerificationEmailPage(
                                                    fromSingUp: true,
                                                    email:
                                                        emailTextEditingController
                                                            .text));
                                          },
                                          child: const Text('Mengerti'),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Gagal Daftar'),
                                      content: Text(authenticationServices
                                          .massage
                                          .toString()),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              context, 'Mengerti'),
                                          child: const Text('Mengerti'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 20)
                      ],
                    ))
              ],
            ),
          ),

          SafeArea(
            child: HeaderBackArrowandTitlePage('Daftar', onTap: () {
              navigationPop(context);
            }),
          ),

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
}
