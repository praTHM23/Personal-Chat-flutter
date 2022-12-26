import 'package:chat_appv2/auth/methods.dart';
import 'package:flutter/material.dart';

import '../screens/homescreen.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

final TextEditingController _email = TextEditingController();
final TextEditingController _password = TextEditingController();
final TextEditingController _Name = TextEditingController();
bool isLoading = false;

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: isLoading
            ? Center(
                child: Container(
                  height: size.height / 20,
                  width: size.height / 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: size.width / 0.5,
                      child: IconButton(
                          icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    Container(
                      width: size.width / 1.1,
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      width: size.width / 1.1,
                      child: Text(
                        "Create Account to Contiue!",
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: field(
                            size, "Name", Icons.account_box, _Name, false),
                      ),
                    ),
                    Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(
                          size, "email", Icons.account_box, _email, false),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                      child: Container(
                        width: size.width,
                        alignment: Alignment.center,
                        child: field(
                            size, "password", Icons.lock, _password, true),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_Name.text.isNotEmpty &&
                            _email.text.isNotEmpty &&
                            _password.text.isNotEmpty) {
                          setState(() {
                            isLoading = true;
                          });

                          createAccount(_Name.text, _email.text, _password.text)
                              .then((user) {
                            if (user != null) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()));
                              print("Account Created Sucessfull");
                            } else {
                              print("Login Failed");
                              setState(() {
                                isLoading = false;
                              });
                            }
                          });
                        } else {
                          print("Please enter Fields");
                        }
                      },
                      child: Container(
                          height: size.height / 14,
                          width: size.width / 1.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    )
                  ],
                ),
              ));
  }
}

Widget field(Size size, String hintText, IconData icon,
    TextEditingController cont, bool obsecure) {
  return Container(
    height: size.height / 14,
    width: size.width / 1.1,
    child: TextField(
      obscureText: obsecure,
      controller: cont,
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    ),
  );
}
