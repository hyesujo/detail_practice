import 'package:delivery_app/const.dart';
import 'package:delivery_app/models/foodmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final FoodModel data;

  DetailScreen(
    this.data
);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _counter = 0;

  void increment() {
    setState(() {
      _counter ++;
    });
  }

  void decrement() {
    if(_counter  == 0 ) {
      _counter;
    } else
    setState(() {
      _counter --;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenColor,
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          _customAppBar(context),
          Container(
            height: 210,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: AssetImage(
                      'assets/images/bg.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Image(
                    image: AssetImage(
                      'assets/images/${widget.data.imgPath}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child:
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)
                )
            ),
            padding: EdgeInsets.all(
                28
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.data.name}',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text('\$${widget.data.price.toInt()}',
                      style: TextStyle(
                          fontSize: 28,
                          color: AppColors.redColor
                      ),
                    ),
                    SizedBox(width: 20),
                    _buildCounter(),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildInfo('Weight', '${widget.data.weight.toInt()}gm'),
                    _buildInfo('Calories', '${widget.data.calory.toInt()}ccal'),
                    _buildInfo('Weight', '${widget.data.protein.toInt()}gm'),
                  ],
                ),
                SizedBox(height: 16),
                Text('Items',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 8),
                Text('${widget.data.item}'
                ),
                SizedBox(width: 16),
                Expanded(
                    child: SizedBox()
                ),
                Row(
                    children: [
                      Expanded(
                        child: RaisedButton(
                          onPressed: () {},
                          padding: EdgeInsets.symmetric(vertical: 5),
                          color: AppColors.greenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(18),
                            ),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                                fontSize: 28
                            ),
                          ),
                        ),
                      ),
                    ]
                ),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
          ),
        ),
        Text('$val',
          style: TextStyle(
              fontSize: 16,
              color: AppColors.redColor
          ),
        ),
      ],
    );
  }

 Widget _buildCounter() {
    return Container(
                      decoration: BoxDecoration(
                          color: AppColors.greenColor,
                          borderRadius: BorderRadius.all(Radius.circular(12))
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Colors.black,
                              ),
                              onPressed: decrement,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text('$_counter',
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              onPressed: increment
                          ),
                        ],
                      ),
                    );
 }
}

  Widget _customAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: IconButton(
              icon: Icon(Icons.chevron_left,
                size: 28,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Icon(Icons.shop,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
