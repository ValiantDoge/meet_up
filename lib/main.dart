import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meet_up/models/user.dart';
import 'package:meet_up/screens/loading.dart';
import 'package:meet_up/screens/wrapper.dart';
import 'package:meet_up/services/auth.dart';
import 'package:meet_up/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ChatUser?>.value(
      catchError: (_, __) => null,
      initialData: null,
      value: AuthService().user,
      child: ChangeNotifierProvider<ThemeChanger>(
        create: (_) => ThemeChanger(ThemeData.dark()),
        child: MaterialAppWithTheme(),
      ),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      home: Loadingscr(),
      theme: theme.getTheme(),
    );
  }
}
