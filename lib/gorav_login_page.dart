import 'package:flutter/material.dart';
import 'widgets/custom_input.dart';

class GoravLoginPage extends StatefulWidget {
  @override
  _GoravLoginPage createState() => _GoravLoginPage();
}

class _GoravLoginPage extends State<GoravLoginPage> {
  bool otpSent = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  void handleButtonPress() {
    if (!otpSent) {
      print("Phone number: ${phoneController.text}");
      setState(() {
        otpSent = true;
      });
    } else {
      print("OTP: ${otpController.text}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0.7, -0.7),
              radius: 1.6,
              colors: [
                Color.fromRGBO(217, 62, 158, 1),
                Color.fromRGBO(85, 27, 155, 1)
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('assets/bya_logo.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 30),
                    child: Input(
                      labelText: 'Phone number',
                      icon: Icons.phone_iphone_outlined,
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                    ),
                  ),
                  if (otpSent)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Input(
                        labelText: 'OTP',
                        icon: Icons.key,
                        keyboardType: TextInputType.phone,
                        controller: otpController,
                      ),
                    ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 30),
                    child: OutlinedButton(
                      onPressed: handleButtonPress,
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.white, width: 2.0),
                          foregroundColor: Colors.white),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                        child: Text(
                          'Get OTP',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
