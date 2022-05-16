import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }
}

class ChangeTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Theme'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton.icon(
                  icon: Icon(Icons.dark_mode, color: Colors.green),
                  label: Text(
                    'Dark Mode',
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () => _themeChanger.setTheme(ThemeData.dark())),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextButton.icon(
                  icon: Icon(Icons.light_mode, color: Colors.green),
                  label: Text(
                    'Light Theme',
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () => _themeChanger.setTheme(ThemeData.light())),
            ),
          ],
        ),
      ),
    );
  }
}
