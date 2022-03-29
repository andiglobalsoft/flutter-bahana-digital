part of '../widgets.dart';

class MenuButton extends StatelessWidget {
  final String titleMenu;
  final Icon icon;
  final Function onTap;
  const MenuButton(
      {required this.titleMenu,
      required this.icon,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const SizedBox(width: 22),
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
                color: mainColor, borderRadius: BorderRadius.circular(10)),
            child: icon,
          ),
          const SizedBox(width: 16),
          Text(titleMenu),
          const Spacer(flex: 4),
          Container(
            height: 20,
            width: 2,
            color: grayColor,
          )
        ]),
      ),
    );
  }
}
