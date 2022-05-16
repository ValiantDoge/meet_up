import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/load_logo.png'),
            CircularProgressIndicator(
              strokeWidth: 3,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
