// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppDrawarWidget extends StatefulWidget {
 final GlobalKey<ScaffoldState> navigationDrawarkey;
  const AppDrawarWidget({
    Key? key,
    required this.navigationDrawarkey,
  }) : super(key: key);

  @override
  State<AppDrawarWidget> createState() => _AppDrawarWidgetState();
}

class _AppDrawarWidgetState extends State<AppDrawarWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.navigationDrawarkey,
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Page 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.train,
              ),
              title: const Text('Page 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
