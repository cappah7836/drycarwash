
import 'package:cool_alert/cool_alert.dart';
import 'package:dio/dio.dart';
import 'package:drycarwash/Screens/DashboardScreen.dart';
import 'package:drycarwash/Screens/ForgotScreen.dart';
import 'package:drycarwash/Screens/RegisterScreen.dart';
import 'package:drycarwash/components/constants.dart';
import 'package:drycarwash/components/form_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true;
  String? uemail;
  String? upassword;

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final List<String> errors = [];
  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }


  var id, username, useremail, upass, uphone, uref,total_points;
  var response;

  CustomerLogin() async {
    var dioRequest = Dio();
    dioRequest.options.baseUrl = "http://116.90.122.234:7777/api/";
    var formData = FormData.fromMap({
      "email":email.text,
      "password":password.text,

    });


    response = await dioRequest.post("Sale/CustomerLogin", data: formData);
    if (response.statusCode == 200) {
      print(response.data);
      print(response.data["obj"]);

      var message = response.data['message'];

      if (message == "Login Successfully") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        setState(() {

          id = response.data["obj"]["customeR_ID"];
          username = response.data["obj"]["customeR_NAME"];
          uphone = response.data["obj"]["mobilE_NO"];
          useremail = response.data["obj"]["email"];
          uref = response.data["obj"]["referral"];
          upass = response.data["obj"]["customeR_PASSWORD"];
          total_points = response.data["obj"]["totaL_POINTS"];
          preferences.setInt("userid", id);
          preferences.setString("username", username);
          preferences.setString("phone", uphone);
          preferences.setString("email", useremail);
          preferences.setString("referenceno", uref);
          preferences.setString("password", upass);
          preferences.setInt("points", total_points);
          Navigator.pop(context);

        });

        final snackBar =
        SnackBar(content: Text('User successfully logged in'), backgroundColor: Colors.green);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));


      } else if(message == "email or password is incorrect!") {
        setState(() {
          Navigator.pop(context);
        });
        final snackBar = SnackBar(content: Text('Invalid email or password'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      else if (message == "customer's record not exist!") {
        setState(() {
          Navigator.pop(context);
        });
        final snackBar =
        SnackBar(content: Text('Wrong Credentials Information'), backgroundColor: Colors.amber);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
      else{
        final snackBar = SnackBar(
            content: Text('Server not responding!'), backgroundColor: Colors.red);
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      print("Error...");
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/car_logo.png',
                            scale: 1, width: 70, height: 70),
                        Image.asset('assets/images/drycarwashlogo.jpg',
                            scale: 1, width: 150, height: 80),
                              buildEmail(),
                              SizedBox(height: 10),
                              buildPassword(),
                              FormError(errors: errors),
                              buildForgotPasswordbtn(),
                              buildLoginBtn(),
                              buildRegisterBtn(),

                        Image.asset('assets/images/greenwaylogo.png',
                            scale: 1, width: 80, height: 80),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
          TextFormField(
            controller: email,
            onSaved: (newValue) => uemail = newValue!,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              } else if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kEmailNullError);
                return "";
              } else if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return "";
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,

            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.email, color: Color(0xff5D5D59)),
                hintText: 'Enter your Email',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                )),

          ),

      ],
    );
  }
  buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
            controller: password,
            obscureText: _isObscure,
            onSaved: (newValue) => upassword = newValue!,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              }
              return null;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPassNullError);
                return "";
              }
              return null;
            },
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
                suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }),
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: Color(0xff5D5D59)),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 18,
                )),
          ),

      ],
    );
  }
  buildForgotPasswordbtn() {
    return Container(

      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ForgotScreen()));
        },
        padding: EdgeInsets.only(right: 0),
        child: Text(
          'Forgot Password?',
          style: GoogleFonts.encodeSans(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
  buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: 100,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            setState(() {
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.loading,
                  text: "User Login",
                  barrierDismissible: false);
            });
            // If the form is valid, display a snackbar. In the real world,
            // you'd often call a server or save the information in a database.
            CustomerLogin();
          }

        },
        child: Text(
          'LOGIN',
          style: GoogleFonts.encodeSans(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  buildRegisterBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterScreen()));
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: 'New To App? ',
            style: GoogleFonts.encodeSans(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: 'Register',
            style: GoogleFonts.encodeSans(
                color: Color(0xff388E3C),
                fontSize: 13,
                fontWeight: FontWeight.bold))
      ])),
    );
  }

}
