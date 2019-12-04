import 'package:flelvin/api.dart';
import 'package:flelvin/controls.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flelvin',
    home: SiteKey(),
    theme: ThemeData.dark(),
  ));
}

class SiteKey extends StatefulWidget {
  SiteKey({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SiteKeyState createState() => _SiteKeyState();
}

class _SiteKeyState extends State<SiteKey> {
  final String storageKey = "siteKey";
  final _keyController = TextEditingController();

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey(storageKey)) {
        var siteKey = prefs.get(storageKey).toString();
        _keyController.text = siteKey;
        if (siteKey.compareTo("") != 0) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Controls(api: Api(_keyController.text))),
          );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  void _saveAndContinue() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(storageKey, _keyController.text);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Controls(api: Api(_keyController.text))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unlock site'),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              controller: _keyController,
            ),
            RaisedButton(
              child: Text('Open site'),
              onPressed: () {
                _saveAndContinue();
              },
            ),
          ],
        ),
      )),
    );
  }
}
