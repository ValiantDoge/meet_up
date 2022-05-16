import 'package:flutter/material.dart';
import 'package:meet_up/models/user.dart';
import 'package:meet_up/screens/authenticate/authenticate.dart';
import 'package:meet_up/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'authenticate/authenticate.dart';
import 'loading.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ChatUser?>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
