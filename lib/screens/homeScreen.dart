import 'package:delivery_app/const.dart';
import 'package:delivery_app/models/foodmodel.dart';
import 'package:delivery_app/screens/detailScreen.dart';
import 'package:delivery_app/widget/sideBar.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FoodModel> foodList = FoodModel.list;
  PageController pageController = PageController(viewportFraction: 0.7);
  var paddingLeft = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
            children:[
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: _buildRightSection(),
              ),
              // SideBar(),
    ]
    ),
      ),
    );
  }

  Widget _buildMenu(String menu,int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          paddingLeft = index * 120.0;
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 20),
        width: 120,
        child: Center(
          child: Text(
            menu,
          style: TextStyle(
            fontSize: 18
          ),
          ),
        ),
      ),
    );
  }

  Widget _buildRightSection() {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          _customAppbar(),
          Expanded(
            child: ListView(
              children: [
                Container(
                  height: 290,
                  child: PageView.builder(
                    physics: BouncingScrollPhysics(),
                      controller: pageController,
                      itemCount: foodList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context)=> DetailScreen(foodList[index])
                            ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(right: 40),
                            child: Stack(children: [
                              _buildBackground(index),
                              Align(
                                alignment: Alignment.topRight,
                                child: Transform.rotate(
                                  angle: math.pi / 3,
                                  child: Image(
                                    width: 150,
                                    image: AssetImage(
                                        'assets/images/${foodList[index].imgPath}'),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 20,
                                child: Container(
                                  decoration: BoxDecoration(
                                   color: AppColors.redColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    )
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16
                                  ),
                                  child: Text(
                                      '\$${foodList[index].price.toInt()}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                            ]
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                    padding: EdgeInsets.only(left: 13),
                ),
                Container(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    'Popular',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                ),
                _buildPopularList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildBackground(int index) {
    return Container(
      margin: EdgeInsets.only(top: 50, bottom: 20, right: 40),
      decoration: BoxDecoration(
        color: AppColors.greenColor,
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar(
                initialRating: 3,
                filledIcon: Icons.star,
                emptyIcon: Icons.star,
                halfFilledIcon: Icons.star_half,
                isHalfAllowed: true,
                filledColor: Colors.yellow,
                emptyColor: Colors.white54,
                halfFilledColor: Colors.amberAccent,
                size: 15,
                onRatingChanged: (rating) {
                  print(rating);
                },
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '(120 Reviews)',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 25,
            left: 10),
            child: Text(
              '${foodList[index].name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularList() {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: foodList.length,
        padding: EdgeInsets.only(
          left: 32,
          bottom: 16,
          top: 20,
        ),
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  Image(
                    width: 80,
                    image:
                        AssetImage('assets/images/${foodList[index].imgPath}'),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${foodList[index].name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                          children: [
                        Text(
                          '\$${foodList[index].price.toInt()}',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.redColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 13),
                        Text(
                          '${foodList[index].weight.toInt()}gm Weight',
                          style: TextStyle(fontSize: 12),
                        ),
                      ]),
                    ],
                  )
                ],
              ));
        });
  }
}

Widget _customAppbar() {
  return Container(
    padding: EdgeInsets.all(16),
    child: Row(
      children: <Widget>[
        RichText(
          text: TextSpan(
              text: 'Hello,\n',
              style: TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: 'Hyesu Jo',
                  style: TextStyle(
                      color: AppColors.greenColor,
                      fontWeight: FontWeight.bold,
                      height: 1.5),
                )
              ]),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.greenLightColor,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Row(children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                  ),
                ),
              ),
              Icon(
                Icons.search,
                size: 16,
              ),
            ]),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: Icon(
              Icons.shop,
              size: 17,
            ),
          ),
        )
      ],
    ),

  );
}


//           Container(
//           color: AppColors.greenColor,
//             height: MediaQuery.of(context).size.height,
//             width: 60,
//             padding: EdgeInsets.only(top: 25),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: 45,
//                   height: 45,
//                   margin: EdgeInsets.only(
//                     top: 12
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(12)
//                     ),
//                     image: DecorationImage(image:
//                     ExactAssetImage(
//                       'assets/images/profile.jpg'
//                     ),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 45,
//                   height: 45,
//                   margin: EdgeInsets.only(bottom: 16),
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(
//                           Radius.circular(12)
//                       ),
//                      color: Colors.white
//                   ),
//                   child: Center(
//                     child: Icon(Icons.more_vert),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 20,
//             child: Align(
//               child: Transform.rotate(
//                 angle: -math.pi /2,
//                 alignment: Alignment.topLeft,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children:<Widget>[
//                     Row(
//                       children: <Widget>[
//                         _buildMenu('Vegetables', 0),
//                         _buildMenu('Chicken', 1),
//                         _buildMenu('Beef', 2),
//                         _buildMenu('Thai', 3),
//                       ],
//                     ),
//                     AnimatedContainer(
//                       duration: Duration(milliseconds: 250),
//                       margin: EdgeInsets.only(left: paddingLeft),
//                       width: 150,
//                       height: 70,
//                       child:  Stack(
//                         children: [
//                           Align(
//                             alignment: Alignment.bottomCenter,
//                             child: ClipPath(
//                               clipper: AppClipper(),
//                               child: Container(
//                                 width: 150,
//                                 height: 60,
//                                 color: AppColors.greenColor,
//                               ),
//                             ),
//                           ),
//                           Align(
//                       alignment: Alignment.topCenter,
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 5.0,
//                               top: 5),
//                               child: Transform.rotate(
//                                 angle: math.pi/ -2,
//                                   child: Icon(Icons.arrow_back_ios,
//                                   size: 20,
//                                   ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]
//                 ),
//               ),
//             ),
//           ),
