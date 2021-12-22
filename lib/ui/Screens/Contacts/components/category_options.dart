import 'package:flutter/material.dart';



import '../../../constants.dart';

class CategoryOptions extends StatefulWidget {
  const CategoryOptions({
    Key key,
  }) : super(key: key);

  @override
  _CategoryOptionsState createState() => _CategoryOptionsState();
}

class _CategoryOptionsState extends State<CategoryOptions> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      color: kBluePrimaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        //itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                // child: Image.asset(
                //   "assets/images/profile_pics/${categoryList[index].imagePath}.png",
                //   width: selectedIndex == index ? 62 : 60,
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
