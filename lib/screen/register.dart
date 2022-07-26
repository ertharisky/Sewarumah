import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sewarumah/main.dart';
import 'package:sewarumah/model/repo/auth.dart';
import 'package:sewarumah/network/api/auth/auth.dart';
import 'package:sewarumah/network/dio_client.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isVisible = false;
  String nama = "";

  void execLogin(String email, String password, String name) async {
    Dio dio = Dio();
    DioClient dioClient = DioClient(dio);
    AuthApi authApi = AuthApi(dioClient: dioClient);
    AuthRepository repo = AuthRepository(authApi: authApi);
    try {
      AlertDialog alert = AlertDialog(
        content: Row(children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ]),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      await repo.registerReq(email, password, name);
      Navigator.pop(context);
      const snackBar = SnackBar(
        content: Text('Berhasil register!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const loginpage(),
          ),
          (Route<dynamic> route) => false);
    } catch (e) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Login Failed"),
              content: const Text("Email atau password tidak ditemukan!!"),
              actions: <Widget>[
                FlatButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 60,
              width: 200,
            ),
            Center(
              child: Container(
                width: 400,
                alignment: Alignment.center,
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
              width: 10,
            ),
            Container(
              width: 530,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        contentPadding: EdgeInsets.all(20)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nama",
                        contentPadding: EdgeInsets.all(20)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                      contentPadding: const EdgeInsets.all(20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    obscureText: _isObscure,
                  ),
                ],
              ),
            ),
            Container(
              width: 570,
              height: 70,
              padding: const EdgeInsets.only(top: 20),
              child: RaisedButton(
                color: Colors.white,
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.black),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () async {
                  bool login = false;
                  if (passwordController.text != "" &&
                      emailController.text != "") {
                    login = true;
                    execLogin(emailController.text, passwordController.text,
                        nameController.text);
                  } else {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Register Failed"),
                            content: const Text(
                                "Terjadi kesalahan ketika register!!"),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
                  }
                  if (login == false) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Register Failed"),
                            content: const Text(
                                "Email dan password tidak boleh kosong"),
                            actions: <Widget>[
                              FlatButton(
                                child: const Text("OK"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const loginpage(),
                    ),
                  );
                },
                child: const Text(
                  "Sudah punya akun? Sign In!",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
