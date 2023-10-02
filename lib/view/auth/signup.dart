import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/firebase_auth.dart';
import 'package:notes_app/view/auth/login.dart';
import 'package:notes_app/view/home.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  bool isPasswordvisible = true;

  void toggleVisibility() {
    setState(() {
      isPasswordvisible = !isPasswordvisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 8, 43, 72),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Image.asset('Asset/register1.png'),
            margin: EdgeInsets.only(top: 12.0),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    topLeft: Radius.circular(16.0),
                  )),
              child: Container(
                margin: EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0),
                child: Column(
                  children: [
                    const Text(
                      'Create new Account',
                      style: TextStyle(
                        color: Color.fromARGB(255, 13, 51, 83),
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Expanded(
                      child: ListView(
                        children: [
                          Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    fillColor: Colors.grey.shade300,
                                    filled: true,
                                    prefixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.email,
                                        color: Colors.blue.shade900,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter an email';
                                    }
                                    if (!RegExp(
                                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                        .hasMatch(value)) {
                                      return 'Enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 30.0),
                                TextFormField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    fillColor: Colors.grey.shade300,
                                    filled: true,
                                    prefixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.person,
                                        color: Colors.blue.shade900,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty ||
                                        !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                      return 'Enter your name';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                SizedBox(height: 30.0),
                                TextFormField(
                                  obscureText: isPasswordvisible,
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    fillColor: Colors.grey.shade300,
                                    filled: true,
                                    prefixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.lock,
                                        color: Colors.blue.shade900,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          toggleVisibility();
                                        });
                                      },
                                      icon: isPasswordvisible
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    if (!RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&*]).{8,}$')
                                        .hasMatch(value)) {
                                      return 'Password must be 8 characters with upper, lower, number, and special char';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 30.0),
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _formkey.currentState!.validate();
                                      Auth.instance.signup(nameController.text, emailController.text, passwordController.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 8, 43, 72),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      minimumSize: Size.fromHeight(50.0),
                                    ),
                                    child: const Text(
                                      'REGISTER',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text('--OR LOGIN WITH --'),
                                SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    Auth.instance
                                        .signInwithGoogle()
                                        .then((value) => Get.off(HomePage()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromARGB(255, 8, 43, 72),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    minimumSize: Size.fromHeight(50.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        'Asset/googlenew.png',
                                        height: 50.0,
                                        width: 50.0,
                                      ),
                                      const Text(
                                        'Continue with Google',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text(
                                      'Already have an account ?',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black87),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Get.off(LoginPage());
                                      },
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Color.fromARGB(
                                                255, 12, 48, 77)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
