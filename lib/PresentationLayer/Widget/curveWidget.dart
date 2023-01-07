import 'package:flutter/material.dart';

class CurveWidget extends StatelessWidget {


  const CurveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorMainTheme = Theme.of(context).primaryColor;
    //clip path => create custom shape
    return ClipPath(clipper: CustomClipPath(),child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 64, 224, 208),
            Colors.blue,
          ],
        ),
      ),
      height: 120,
    ),);
  }
}
//To create a custom clipper,
// you need to create a class that extends CustomClipper<Path>
// and must override two methods.
class CustomClipPath extends CustomClipper<Path>
{
  @override
  Path getClip(Size size)
  {
    double w = size.width;
    double h = size.height;

    var path = Path();
    path.lineTo(0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;


  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper)
  {
    return false;
  }

}