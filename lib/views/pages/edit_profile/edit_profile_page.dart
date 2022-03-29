part of '../pages.dart';

class EditProfilePage extends StatefulWidget {
  final String nameUser;
  final String email;
  final String linkImage;
  final String noPhone;
  const EditProfilePage(
      {required this.nameUser,
      required this.email,
      required this.linkImage,
      required this.noPhone,
      Key? key})
      : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController noPhoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isLoaded = false;
  bool _isObscureConfimation = true;
  XFile? _image;

  @override
  Widget build(BuildContext context) {
    log(widget.linkImage);
    nameTextEditingController.text = widget.nameUser;
    noPhoneTextEditingController.text = widget.noPhone;
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

          SafeArea(
            child: ListView(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 100),
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
                            color: grayColor,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: (_image == null)
                                    ? NetworkImage(widget.linkImage)
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
                const SizedBox(height: 12),
                Center(child: Text(widget.email)),
                const SizedBox(height: 26),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _field(
                          titleFiled: 'Nama',
                          textEditingController: nameTextEditingController),
                      const SizedBox(height: 20),
                      _field(
                          titleFiled: 'Nomor Telepon',
                          textEditingController: noPhoneTextEditingController,
                          keyboardTypeNumber: true),
                      const SizedBox(height: 20),
                      _field(
                          titleFiled: 'Kata Sandi',
                          textEditingController: passwordTextEditingController,
                          isPassword: true),
                      const SizedBox(height: 20),
                      _field(
                          titleFiled: 'Konfirmasi Kata Sandi',
                          textEditingController: passwordTextEditingController,
                          isPassword: true,
                          isConfimationPassword: true),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                _isLoaded = true;
                              });
                              if (nameTextEditingController.text !=
                                      widget.nameUser ||
                                  noPhoneTextEditingController.text !=
                                      widget.noPhone ||
                                  noPhoneTextEditingController
                                      .text.isNotEmpty ||
                                  _image != null) {
                                AuthenticationResult authenticationResult =
                                    await AuthenticationServices.editProfile(
                                        idUser: idUser,
                                        noPhone:
                                            noPhoneTextEditingController.text,
                                        name: nameTextEditingController.text,
                                        password:
                                            passwordTextEditingController.text,
                                        imageProfile: File(_image?.path ?? ''));
                                if (authenticationResult.statusCode == 200) {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title:
                                          const Text('Data Berhasil di Ubah'),
                                      content: Text(authenticationResult.massage
                                          .toString()),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              _isLoaded = false;
                                            });
                                            Navigator.pop(context, 'Mengerti');
                                            navigationPop(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                setState(() {
                                  _isLoaded = false;
                                });
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Data Belum di Ubah'),
                                    content: const Text(
                                        'Belum ada data yang berubah'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _isLoaded = false;
                                          });
                                          Navigator.pop(context, 'Mengerti');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: mainColor,
                          ),
                          child: Text('Ubah',
                              style: TextStyle(
                                fontFamily: textMain,
                              ))),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //Header
          SafeArea(
            child: HeaderBackArrowandTitlePage('Ubah Data', onTap: () {
              navigationPop(context);
            }),
          ),
          //Loading
          (_isLoaded)
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

  Widget _field(
      {required String titleFiled,
      required TextEditingController textEditingController,
      bool keyboardTypeNumber = false,
      bool isPassword = false,
      bool isConfimationPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titleFiled,
            style:
                TextStyle(fontFamily: textMain, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextFormField(
          controller: (isConfimationPassword) ? null : textEditingController,
          keyboardType: (keyboardTypeNumber)
              ? TextInputType.number
              : TextInputType.multiline,
          style: TextStyle(fontFamily: textMain, height: 1),
          obscureText: (isPassword)
              ? (isConfimationPassword)
                  ? _isObscureConfimation
                  : _isObscure
              : false,
          decoration: InputDecoration(
              suffixIcon: (isPassword)
                  ? (isConfimationPassword)
                      ? IconButton(
                          icon: Icon(
                            !_isObscureConfimation
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscureConfimation = !_isObscureConfimation;
                            });
                          },
                        )
                      : IconButton(
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
                        )
                  : null,
              fillColor: whiteColor,
              isDense: true,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              hintStyle: TextStyle(
                fontFamily: textMain,
                fontSize: 14,
                height: 1,
                color: grayColor,
              )),
          validator: (val) {
            if (isPassword) {
              if (isConfimationPassword) {
                return (val == passwordTextEditingController.text)
                    ? null
                    : 'Password anda tidak sama';
              }
              return (val!.isNotEmpty && val.length < 6)
                  ? 'Kata Sandi haris lebih dari atau sama dengan 6'
                  : null;
            } else {
              return (val != '') ? null : 'Tidak boleh kosong';
            }
          },
        ),
      ],
    );
  }
}
