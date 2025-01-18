import 'package:bya/home_page.dart';
import 'package:bya/widgets/custom_input.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GoravRegisterPage extends StatefulWidget {
  @override
  _GoravRegisterPage createState() => _GoravRegisterPage();
}

class _GoravRegisterPage extends State<GoravRegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController spouseController = TextEditingController();
  final TextEditingController spouseDobController = TextEditingController();
  final TextEditingController kidController = TextEditingController();
  final TextEditingController kidDobController = TextEditingController();

  Future<void> registerMember() async {
    try {
      final collection = FirebaseFirestore.instance.collection('bomer');
      final snapshot = await collection.get();

      String name = nameController.text;
      String phone = phoneController.text;
      String dob = dobController.text;
      String spouseName = spouseController.text;
      String spouseDob = spouseDobController.text;
      String kidName = kidController.text;
      String kidDob = kidDobController.text;

      Map<String, dynamic> memberData = {
        'name': name,
        'phone': phone,
        'dob': dob,
        'spouse_name': spouseName,
        'spouse_dob': spouseDob,
        'kid_name': kidName,
        'kid_dob': kidDob,
      };

      print("Name: ${nameController.text}, Phone: ${phoneController.text}, DOB: ${dobController.text}, Spouse Name: ${spouseController.text}, Spouse DOB: ${spouseDobController.text}, Kid Name: ${kidController.text}, Kid DOB: ${kidDobController.text}");
      await FirebaseFirestore.instance.collection('members').add(memberData);
      print('Registered Member');
      Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print('Error: ${e}');
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
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                  child: SingleChildScrollView(
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
                      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Input(
                        labelText: 'Full Name',
                        icon: Icons.account_circle_outlined,
                        keyboardType: TextInputType.name,
                        controller: nameController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Input(
                        labelText: 'Phone number',
                        icon: Icons.phone_iphone_outlined,
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Input(
                        labelText: 'DOB (DD/MM/YYYY)',
                        icon: Icons.calendar_month_outlined,
                        keyboardType: TextInputType.datetime,
                        controller: dobController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Input(
                        labelText: 'Spouse Name',
                        icon: Icons.account_circle_outlined,
                        keyboardType: TextInputType.name,
                        controller: spouseController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Input(
                        labelText: 'Spouse DOB (DD/MM/YYYY)',
                        icon: Icons.calendar_month_outlined,
                        keyboardType: TextInputType.datetime,
                        controller: spouseDobController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Input(
                        labelText: 'kid Name',
                        icon: Icons.account_circle_outlined,
                        keyboardType: TextInputType.name,
                        controller: kidController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Input(
                        labelText: 'kid DOB (DD/MM/YYYY)',
                        icon: Icons.calendar_month_outlined,
                        keyboardType: TextInputType.datetime,
                        controller: kidDobController,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 30, bottom: 50),
                      child: OutlinedButton(
                        onPressed: registerMember,
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.white, width: 2.0),
                            foregroundColor: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          child: Text(
                            'Register',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
            ),
          ),
        ));
  }
}
