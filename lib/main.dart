import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sewarumah/model/model_auth.dart';
import 'package:sewarumah/model/repo/auth.dart';
import 'package:sewarumah/network/api/auth/auth.dart';
import 'package:sewarumah/network/dio_client.dart';
import 'package:sewarumah/provider/ad_provider.dart';
import 'package:sewarumah/provider/transaction_provider.dart';
import 'package:sewarumah/screen/home/home_page.dart';
import 'package:sewarumah/screen/register.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AdProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => TransactionProvider(),
    )
  ], child: const loginpage()));
}

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  Widget build(Object context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SanFransisco',
        backgroundColor: const Color(0xFFF5F6F6),
        primaryColor: const Color(0xFF811B83),
        textTheme: TextTheme(
          headline1: const TextStyle(
            color: Color(0xFF100E34),
          ),
          bodyText1: TextStyle(
            color: const Color(0xFF100E34).withOpacity(0.5),
          ),
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFFFA5019)),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        body: const LoginScreen(),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Copyright © 2020 PT Wisma Property',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isVisible = false;
  String nama = "";

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    if (prefs.getString("token") != null) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      });
    }
  }

  void execLogin(String email, String password) async {
    Dio dio = Dio();
    DioClient dioClient = DioClient(dio);
    AuthApi authApi = AuthApi(dioClient: dioClient);
    AuthRepository repo = AuthRepository(authApi: authApi);
    try {
      ModelAuth logins = await repo.loginReq(email, password);
      String getName = await repo.meReq(logins.access_token);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", logins.access_token);
      prefs.setString("name", getName);
      print("name pref = " + prefs.getString("name")!);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (Route<dynamic> route) => false);
    } catch (e) {
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
    return SingleChildScrollView(
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
              height: 200,
              width: 400,
              alignment: Alignment.center,
              child: const Text(
                "Sign in",
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
            height: 140,
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
                  controller: emailcontroller,
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
                if (emailcontroller.text != "" &&
                    passwordController.text != "") {
                  execLogin(emailcontroller.text, passwordController.text);

                  login = true;
                } else {
                  //baris ini digunakan untuk menampilkan dialog ketika kolom user
                  //dan password kosong
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Login Failed"),
                          content: const Text(
                              "Email dan password tidak boleh kosong!!"),
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
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text(
                "Belum punya akun? Register!",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}
