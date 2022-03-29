part of '../widgets.dart';

class CategoryPackageTypePage extends StatelessWidget {
  final String namePackage;
  const CategoryPackageTypePage({required this.namePackage, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 112,
      padding: const EdgeInsets.only(left: 14, top: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: const LinearGradient(
              colors: [Color(0xFFB860E3), Color(0xFF72408A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)),
      child: Text(
        namePackage,
        style: TextStyle(
            fontFamily: textMain,
            height: 1,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: whiteColor),
      ),
    );
  }
}
