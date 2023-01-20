import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function() function;
  final String title;
  final Color color;
  const CustomElevatedButton(
      {Key? key, required this.function, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: function,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          fixedSize: Size(MediaQuery.of(context).size.width * 0.5, 50),
          backgroundColor:color,
          // padding: const EdgeInsets.all(15),
        ),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ));
  }
}
