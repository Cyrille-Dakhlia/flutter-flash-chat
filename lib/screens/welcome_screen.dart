import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String routeId = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.grey.shade900, end: Colors.white)
        .animate(controller);

    controller.addListener(() => setState(() {}));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTitle(
                  animationStatus: controller.status,
                  animatedValue: controller.value,
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Opacity(
              opacity: controller.value,
              child: RoundedButton(
                label: 'Log In',
                color: Colors.lightBlueAccent,
                onPressed: () =>
                    Navigator.pushNamed(context, LoginScreen.routeId),
              ),
            ),
            Opacity(
              opacity: controller.value,
              child: RoundedButton(
                label: 'Register',
                color: Colors.blueAccent,
                onPressed: () =>
                    Navigator.pushNamed(context, RegistrationScreen.routeId),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedTitle extends StatelessWidget {
  AnimatedTitle({this.animationStatus, this.animatedValue});

  AnimationStatus animationStatus;
  double animatedValue;

  @override
  Widget build(BuildContext context) {
    return animationStatus == AnimationStatus.completed
        ? AnimatedTextKit(
            totalRepeatCount: 2,
            animatedTexts: [
              TypewriterAnimatedText(
                'Flash Chat',
                speed: Duration(milliseconds: 50),
                textStyle: kFlashChatTextStyle,
              ),
            ],
          )
        : Text(
            '${(animatedValue * 100).toInt()}%',
            style: kFlashChatTextStyle,
          );
  }
}
