import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:rescue_code/profilePage.dart';
import 'package:rescue_code/style/theme.dart' as Theme;
import 'package:shared_preferences/shared_preferences.dart';

import 'doctorChat.dart';
import 'style/delayedAnimation.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;

    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height >= 775.0
          ? MediaQuery.of(context).size.height
          : 775.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            begin: const FractionalOffset(0.0, 0.0),
            colors: [
              Theme.Colors.loginGradientStart,
              Theme.Colors.loginGradientEnd
            ],
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 20,
              height: 100,
            ),
            AvatarGlow(
              endRadius: 90,
              duration: Duration(seconds: 2),
              glowColor: Colors.white24,
              repeat: true,
              repeatPauseDuration: Duration(seconds: 2),
              startDelay: Duration(seconds: 1),
              child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Icon(
                      Icons.healing,
                      size: 50,
                      color: Colors.redAccent,
                    ),
                    radius: 50.0,
                  )),
            ),
            DelayedAnimation(
              child: Text(
                "Hi There",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 35.0, color: color),
              ),
              delay: delayedAmount + 1000,
            ),
            DelayedAnimation(
              child: Text(
                "I'm Rescue Code",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 35.0, color: color),
              ),
              delay: delayedAmount + 2000,
            ),
            SizedBox(
              height: 30.0,
            ),
            DelayedAnimation(
              child: Text(
                "I aim to scrimp time",
                style: TextStyle(
                  fontSize: 20.0,
                  color: color,
                ),
              ),
              delay: delayedAmount + 3000,
            ),
            DelayedAnimation(
              child: Text(
                "needed for rescuing humans",
                style: TextStyle(fontSize: 20.0, color: color),
              ),
              delay: delayedAmount + 3000,
            ),
            SizedBox(
              height: 100.0,
            ),
            DelayedAnimation(
              child: GestureDetector(
                onTapDown: _onTapDown,
                onTapUp: _onTapUp,
                child: Transform.scale(
                  scale: _scale,
                  child: _animatedButtonUI,
                ),
              ),
              delay: delayedAmount + 4000,
            ),
            SizedBox(
              height: 50.0,
            ),
<<<<<<< HEAD
            DelayedAnimation(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          fontFamily: "customFont",
                          color: color),
                    ),
                    // Icon(
                    //   Icons.copyright,
                    //   color: Colors.white,
                    //   size: 20,
                    // )
                  ],
                ),
              ),
              delay: delayedAmount + 1000,
            ),
=======
            // DelayedAnimation(
            //   child: Center(
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Text(
            //           "PLEBITS LLC 2019",
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 14.0,
            //               fontFamily: "customFont",
            //               color: color),
            //         ),
            //         Icon(
            //           Icons.copyright,
            //           color: Colors.white,
            //           size: 20,
            //         )
            //       ],
            //     ),
            //   ),
            //   delay: delayedAmount + 1000,
            // ),
>>>>>>> f9e41f86a123246516d574a49f31c97cb217c75c
          ],
        ),
      ),
    ));
  }

  Widget get _animatedButtonUI => GestureDetector(
        onTap: () async {
          SharedPreferences _prefs = await SharedPreferences.getInstance();

          var uid = _prefs.getString("uid");
          var type = _prefs.getString("type");

          if (uid != null && uid != '') {
            if (type == "doctor") {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => DoctorChat()));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(uid: uid)));
            }
          } else {
            Navigator.pushNamed(context, "boarding");
          }
        },
        child: Container(
          height: 60,
          width: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.white,
          ),
          child: Center(
            child: Text(
              'Take me in!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
