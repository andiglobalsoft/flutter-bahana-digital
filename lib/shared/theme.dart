part of 'shared.dart';

//Detect  device tablet
bool layarPhoneTablet = true;

//isLoaded State

//Color
Color mainColor = const Color(0xFF214F68);
Color backgroundPhoneColor = const Color(0xFFF4F4F4);
Color whiteColor = const Color(0xFFFDFDFD);
Color blackColor = const Color(0xFF2E2E2E);
Color purpleColor = const Color(0xFFB860E3);
Color purpleColorBtn = const Color(0xFF655989);
Color backgrounpurpleColor = const Color(0xFF9E88DD);
Color grayColor = const Color(0xFF676464);
Color redColor = const Color(0xFFE86060);

//Text
String textMain = 'OpenSans';
TextStyle textTitleNavBar =
    TextStyle(fontFamily: textMain, fontWeight: FontWeight.w600);
TextStyle textDiscount = TextStyle(
  fontFamily: textMain,
  color: whiteColor,
  fontSize: 8,
  fontWeight: FontWeight.w600,
);
TextStyle textItemCardProduct = TextStyle(
  fontFamily: textMain,
  color: whiteColor,
);
TextStyle textPrice = TextStyle(
  fontFamily: textMain,
  color: blackColor,
  fontWeight: FontWeight.w600,
);
TextStyle textTitleAppBar = TextStyle(
    fontFamily: textMain,
    fontSize: 20,
    color: whiteColor,
    fontWeight: FontWeight.bold);
TextStyle textProfil = TextStyle(
    fontFamily: textMain,
    fontSize: 12,
    color: whiteColor,
    fontWeight: FontWeight.bold);
TextStyle textPriceLineThrough = TextStyle(
    fontFamily: textMain,
    color: grayColor,
    fontSize: 12,
    decoration: TextDecoration.lineThrough);
TextStyle textGray = TextStyle(fontFamily: textMain, color: grayColor);
TextStyle textBold =
    TextStyle(fontFamily: textMain, fontWeight: FontWeight.bold);
