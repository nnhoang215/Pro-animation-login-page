import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_auth_animation/constants.dart';
import 'package:flutter_auth_animation/widgets/login_form.dart';
import 'package:flutter_auth_animation/widgets/sign_up_form.dart';
import 'package:flutter_auth_animation/widgets/social_button.dart';
import 'package:flutter_svg/svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> 
    with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false; 

  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation() {
    _animationController = 
      AnimationController(vsync: this, duration: defaultDuration);

    _animationTextRotate = Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
      ? _animationController.forward()
      : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Stack(
            children: [
              AnimatedPositioned(
                duration: defaultDuration,
                width: _size.width * 0.88,
                height: _size.height,
                left: _isShowSignUp ? -_size.width * 0.76 : 0,
                child: Container(
                  color: login_bg,
                  child: LoginForm(),
                )
              ),
              AnimatedPositioned(
                duration: defaultDuration,
                width: _size.width * 0.88,
                height: _size.height,
                left: _isShowSignUp ? _size.width * 0.12 : _size.width * 0.88,
                child: Container(
                  child: SignUpForm(),
                  color: signup_bg,
                )  
              ),
              AnimatedPositioned(
                duration: defaultDuration,
                top: _size.height * 0.1,
                left: 0,
                right: _isShowSignUp ? -_size.width * 0.06 - 35 : _size.width * 0.06 + 35,
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: AnimatedSwitcher(
                    duration: defaultDuration,
                    child: _isShowSignUp
                    ? SvgPicture.asset("assets/animation_logo.svg", color: signup_bg,)
                    : SvgPicture.asset("assets/animation_logo.svg", color: login_bg,),
                  ),
                )
              ),
              AnimatedPositioned(
                duration: defaultDuration,
                bottom: _size.height * 0.1, 
                width: _size.width,
                right: _isShowSignUp 
                  ? -_size.width * 0.06
                  : _size.width * 0.06,
                child: SocialButtons(),
              ),
              AnimatedPositioned(
                duration: defaultDuration,
                left: _isShowSignUp ? 0 : _size.width * 0.44 - 80,
                bottom: _isShowSignUp? _size.height * 0.5 - 80 : _size.height * 0.3,
                child: AnimatedDefaultTextStyle(
                  duration: defaultDuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _isShowSignUp ? 20 : 32,
                    fontWeight: FontWeight.bold,
                    color: _isShowSignUp ? Colors.white : Colors.white70,
                  ),
                  child: Transform.rotate(
                    angle: -_animationTextRotate.value * pi / 180,
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        if (_isShowSignUp) {
                          updateView();
                        } else {
                          print("Logging in");
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: defaultPadding * 0.75 ),
                        width: 160,
                        child: Text(
                          "Log In".toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                )
              ),
              //Sign Up 
              AnimatedPositioned(
                duration: defaultDuration,
                right: _isShowSignUp ? _size.width * 0.44 - 80 : 0,
                bottom: !_isShowSignUp? _size.height * 0.5 - 80 : _size.height * 0.3,
                child: AnimatedDefaultTextStyle(
                  duration: defaultDuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: !_isShowSignUp ? 20 : 32,
                    fontWeight: FontWeight.bold,
                    color: _isShowSignUp ? Colors.white : Colors.white70,
                  ),
                  child: Transform.rotate(
                    angle: (90 -_animationTextRotate.value) * pi / 180,
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        if (_isShowSignUp) {
                          print("vừa nhấn Sign Up");
                        } else {
                          updateView();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: defaultPadding * 0.75 ),
                        width: 160,
                        child: Text(
                          "Sign Up".toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                )
              ), 
            ],
          );
        }
      ),
    );
  }
}
