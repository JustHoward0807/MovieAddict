import 'package:flutter/material.dart';

class CustomAnimatedBtnBar extends StatelessWidget {
  const CustomAnimatedBtnBar({
    Key key,
    this.selectedIndex = 0,
    this.animationDuration = const Duration(milliseconds: 270),
    @required this.items,
    @required this.onItemSelected,
    this.curve = Curves.linear,
  })  : assert(items.length >= 2 && items.length <= 5),
        super(key: key);

  final int selectedIndex;
  final Duration animationDuration;
  final List<BottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).secondaryHeaderColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.map((item) {
            var index = items.indexOf(item);
            return GestureDetector(
              onTap: () => onItemSelected(index),
              child: _ItemWidget(
                item: item,
                isSelected: index == selectedIndex,
                animationDuration: animationDuration,
                curve: curve,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final bool isSelected;
  final BottomNavBarItem item;
  final Duration animationDuration;
  final Curve curve;

  const _ItemWidget({
    @required this.item,
    @required this.isSelected,
    @required this.animationDuration,
    this.curve,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: isSelected ? 82 : MediaQuery.of(context).size.width / 8,
        height: 40,
        duration: animationDuration,
        curve: curve,
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: const [
            BoxShadow(
                color: Color(0xff000000),
                offset: Offset(1, 4),
                blurRadius: 4.0,
                spreadRadius: -1),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            width: isSelected ? 82 : MediaQuery.of(context).size.width / 8,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                item.icon,
                if (isSelected)
                  Expanded(
                    child: FittedBox(
                      child: DefaultTextStyle.merge(
                        textAlign: item.textAlign,
                        child: item.title,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBarItem {
  BottomNavBarItem({
    @required this.icon,
    @required this.title,
    this.activeColor = Colors.blue,
    this.textAlign,
    this.inactiveColor,
  });

  final Widget icon;
  final Widget title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;
}
