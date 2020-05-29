import 'package:flutter/material.dart';
import 'package:flutter_course/signIn.dart';
import 'package:flutter_course/loginPage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text("ChoreTracker App"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "Hi, " + name,
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: const Color(0xff283472),
              ),
              accountEmail: Text(
                email,
                style: TextStyle(color: Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.white,
              ),
            ),
            ListTile(
              title: Text("View Calendar"),
              trailing: Icon(Icons.calendar_today),
              onTap: () => Navigator.of(context).pushNamed("/Calendar"),
            ),
            ListTile(
              title: Text("Add Chores"),
              trailing: Icon(Icons.add),
              onTap: () => Navigator.of(context).pushNamed("/ManageChores"),
            ),
            ListTile(
              title: Text("Manage Group"),
              trailing: Icon(Icons.group),
              onTap: () => Navigator.of(context).pushNamed("/ManageChores"),
            ),
            ListTile(
              title: Text("Settings"),
              trailing: Icon(Icons.settings),
              onTap: () => Navigator.of(context).pushNamed("/ManageChores"),
            ),
            SizedBox(height: 120),
            Container(
              margin: const EdgeInsets.all(40.0),
              child: MaterialButton(
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }), ModalRoute.withName('/'));
                },
                color: Color(0xff283472),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Sign Out',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bgapps.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            // Each button on home page is wrapped in container to add padding
            Container(
              margin: const EdgeInsets.fromLTRB(40, 40, 40, 20),
              child: RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.grey)),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(Icons.calendar_today,
                              // image: AssetImage("assets/broom.png"),
                              size: 100.0,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "View Calendar",
                        ),
                      ),
                    ],
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/Calendar')),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 10, 40, 10),
              child: RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.grey)),
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.check_box,
                            // image: AssetImage("assets/broom.png"),
                            size: 100.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "Manage Chores",
                        ),
                      ),
                    ],
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed('/ManageChores')),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(40, 20, 40, 20),
              child: RaisedButton(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey)),
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.group,
                        // image: AssetImage("assets/broom.png"),
                        size: 100.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Text(
                        "Manage Group",
                      ),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddChores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Current Chores"),
      ),
    );
  }
}
