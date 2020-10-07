import 'package:after_layout/after_layout.dart';
import 'package:delivery_app/const.dart';
import 'package:delivery_app/widget/sidebarItem.dart';
import 'package:flutter/material.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with AfterLayoutMixin{

  int selectedIndex = 0;
  LabeledGlobalKey _walletKey = LabeledGlobalKey("walletKey");
  LabeledGlobalKey _restaurantKey = LabeledGlobalKey("restaurantKey");
  LabeledGlobalKey _myCartKey = LabeledGlobalKey("myCardKey");
  LabeledGlobalKey _myProfileKey = LabeledGlobalKey("myProfileKey");

  RenderBox renderBox;
  double startYPosition;

  void onTabTap(int index) {
    setState(() {
      selectedIndex = index;
      switch (selectedIndex) {
        case 0:
          renderBox = _walletKey.currentContext.findRenderObject();
          break;
        case 1:
          renderBox = _restaurantKey.currentContext.findRenderObject();
          break;
        case 2:
          renderBox = _myCartKey.currentContext.findRenderObject();
          break;
        case 3:
          renderBox = _myProfileKey.currentContext.findRenderObject();
          break;
      }

      startYPosition = renderBox.localToGlobal(Offset.zero).dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    color: AppColors.greenColor,
    height: MediaQuery.of(context).size.height,
    width: 60,
    padding: EdgeInsets.only(top: 25),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 45,
          height: 45,
          margin: EdgeInsets.only(
              top: 12
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(12)
            ),
            image: DecorationImage(image:
            ExactAssetImage(
                'assets/images/profile.jpg'
            ),
            ),
          ),
        ),
        Container(
          width: 45,
          height: 45,
          margin: EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(12)
              ),
              color: Colors.white
          ),
          child: Center(
            child: Icon(Icons.more_vert),
          ),
        ),
        Positioned(
          right: -25,
          top: 0,
          bottom: 0,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              SizedBox(
                height: 40,
              ),
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              SizedBox(
                height: 120,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SidebarItem(
                      key: _walletKey,
                      text: "Wallet",
                      onTabTap: () {
                        onTabTap(0);
                      },
                      isSelected: selectedIndex == 0,
                    ),
                    SidebarItem(
                      key: _restaurantKey,
                      text: "Restaurants",
                      onTabTap: () {
                        onTabTap(1);
                      },
                      isSelected: selectedIndex == 1,
                    ),
                    SidebarItem(
                      key: _myCartKey,
                      text: "My cart",
                      onTabTap: () {
                        onTabTap(2);
                      },
                      isSelected: selectedIndex == 2,
                    ),
                    SidebarItem(
                      key: _myProfileKey,
                      text: "My profile",
                      onTabTap: () {
                        onTabTap(3);
                      },
                      isSelected: selectedIndex == 3,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
      ],
    ),
      );
  }

  void afterFirstLayout(BuildContext context) {
    setState(() {
      renderBox = _walletKey.currentContext.findRenderObject();
      startYPosition = renderBox.localToGlobal(Offset.zero).dy;
    });
  }
}


class SidebarClipper extends CustomClipper<Path> {
  final double startYPosition, endYPosition;

  SidebarClipper(this.startYPosition, this.endYPosition);

  @override
  Path getClip(Size size) {
    Path path = Path();

    double width = size.width;
    double height = size.height;

    //up curve
    path.moveTo(width, 0);
    path.quadraticBezierTo(width / 3, 5, width / 3, 70);

    //custom curve
    path.lineTo(width / 3, startYPosition);
    path.quadraticBezierTo(width / 3 - 2, startYPosition + 15, width / 3 - 10, startYPosition + 25);
    path.quadraticBezierTo(0, startYPosition + 45, 0, startYPosition + 60);
    path.quadraticBezierTo(0, endYPosition - 45, width / 3 - 10, endYPosition - 25);
    path.quadraticBezierTo(width / 3 - 2, endYPosition - 15, width / 3, endYPosition);

    //down curve
    path.lineTo(width / 3, height - 70);
    path.quadraticBezierTo(width / 3, height - 5, width, height);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

