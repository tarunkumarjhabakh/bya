import 'package:bya/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'widgets/custom_input.dart';

class GoravLoginPage extends StatefulWidget {
  @override
  _GoravLoginPage createState() => _GoravLoginPage();
}

class _GoravLoginPage extends State<GoravLoginPage> {
  bool otpSent = false;
  String verificationID = '';
  bool isLoading = false;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  Future<void> sendOTP(String phoneNumber) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91$phoneNumber',
          timeout: Duration(seconds: 10),
          verificationCompleted: (PhoneAuthCredential credential) async {
            await FirebaseAuth.instance.signInWithCredential(credential);
            print('Number verified');
          },
          verificationFailed: (FirebaseAuthException e) {
            print('Verification Failed');
          },
          codeSent: (String verificationId, int? resendToken) {
            setState(() {
              otpSent = true;
              verificationID = verificationId;
              isLoading = false;
            });
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            setState(() {
              verificationID = verificationId;
            });
          });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  Future<bool> verifyOTP(String otp) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: otp);
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } catch (e) {
      return false;
    }
  }

  void handleButtonPress() async {
    if (!otpSent) {
      String phoneNumber = phoneController.text;
      print("Phone number: ${phoneNumber}");
      if (phoneNumber.isEmpty ||
          phoneNumber.length != 10 ||
          !RegExp(r'^\d{10}$').hasMatch(phoneNumber)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Enter a valid 10-digit phone number",
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            elevation: 0,
          ),
        );
        return;
      }
      await sendOTP(phoneNumber);
    } else {
      String otp = otpController.text;
      print("OTP: ${otp}");
      if (otp.isEmpty || otp.length != 6 || !RegExp(r'^\d{6}$').hasMatch(otp)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Enter valid OTP",
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
            backgroundColor: Colors.transparent,
            behavior: SnackBarBehavior.floating,
            duration: Duration(seconds: 2),
            elevation: 0,
          ),
        );
        return;
      }
      bool LoggedIn = await verifyOTP(otp);
      if (LoggedIn) {
        print('Logged In Successfully');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        print('Invalid OTP');
      }
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
                    child: isLoading
                        ? CircularProgressIndicator()
                        : OutlinedButton(
                            onPressed: handleButtonPress,
                            style: OutlinedButton.styleFrom(
                                side:
                                    BorderSide(color: Colors.white, width: 2.0),
                                foregroundColor: Colors.white),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                              child: Text(
                                otpSent ? 'Login' : 'Get OTP',
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
