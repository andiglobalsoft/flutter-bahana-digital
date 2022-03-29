part of '../widgets.dart';

class BackgroundProfileWidget extends StatelessWidget {
  const BackgroundProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 194,
      child: Stack(children: [
        Container(
          height: 194,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFF7C56EA),
            Color(0xFF9E88DD),
          ], begin: Alignment.topRight, end: Alignment.bottomCenter)),
        ),
        Positioned(
          left: -58,
          top: -48,
          child: Transform.rotate(
              angle: -4,
              child: Container(
                height: 252,
                width: 300,
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(18)),
              )),
        ),
        Positioned(
          top: 134,
          left: MediaQuery.of(context).size.width - 130,
          child: Container(
            height: 100,
            width: 82,
            decoration: BoxDecoration(
                color: backgroundPhoneColor,
                borderRadius: BorderRadius.circular(100)),
          ),
        ),
      ]),
    );
  }
}

class BottomHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(-1.4, -0.4);
    path_0.lineTo(-1.4, 134.6);
    path_0.lineTo(280, 134.6);
    path_0.quadraticBezierTo(311.061, 135.589, 312, 109.3);
    path_0.cubicTo(313, 81.3, 355.5, 84.8, 356.5, 107.3);
    path_0.quadraticBezierTo(357.737, 135.126, 382, 134.3);
    path_0.lineTo(413.5, 134.6);
    path_0.lineTo(413.5, 0.1);
    path_0.lineTo(-1.4, -0.4);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
