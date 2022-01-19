import 'package:flutter/material.dart';

class CustomTabbar extends StatelessWidget {
  const CustomTabbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 60,
      child: ClipPath(
        clipper: TicketClipper(),
        child: Container(
          color: Colors.green,
        ),
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double? borderRadius;
  final double? clipRadius;
  final double? smallClipRadius;
  final int numberOfSmallClips;

  const TicketClipper({
    this.borderRadius,
    this.clipRadius = 30,
    this.smallClipRadius = 1,
    this.numberOfSmallClips = 13,
  });

  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TicketClipper old) =>
      old.borderRadius != borderRadius ||
      old.clipRadius != clipRadius ||
      old.smallClipRadius != smallClipRadius ||
      old.numberOfSmallClips != numberOfSmallClips;
}
