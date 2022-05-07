import 'package:flutter/material.dart';

import '../auth/auth_util.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_widgets.dart';
import '../main.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({Key key}) : super(key: key);

  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  TextEditingController emailController;
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: flutterTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leading: flutterIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: flutterTheme.of(context).primaryText,
            size: 32,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Sign In',
          style: flutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: flutterTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: width < height
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color:
                                  flutterTheme.of(context).secondaryBackground,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                                Text(
                                  'INSTICKET',
                                  style: flutterTheme.of(context).title1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: TextFormField(
                                  controller: emailController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email Adress',
                                    hintText: 'Enter Your Email Adress',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFEEEEEE),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Color(0xFF9E9E9E),
                                      size: 24,
                                    ),
                                  ),
                                  style: flutterTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF9E9E9E),
                                      ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: !passwordVisibility,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter Your Password',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFEEEEEE),
                                    prefixIcon: Icon(
                                      Icons.lock_outlined,
                                      color: Color(0xFF9E9E9E),
                                      size: 24,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => passwordVisibility =
                                            !passwordVisibility,
                                      ),
                                      child: Icon(
                                        passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Color(0xFF757575),
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  style: flutterTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF9E9E9E),
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                                child: InkWell(
                                  onTap: () async {
                                    if (emailController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Email required!',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    await resetPassword(
                                      email: emailController.text,
                                      context: context,
                                    );
                                  },
                                  child: Text(
                                    'Forget your password ?',
                                    style: flutterTheme
                                        .of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: flutterTheme
                                              .of(context)
                                              .primaryColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  final user = await signInWithEmail(
                                    context,
                                    emailController.text,
                                    passwordController.text,
                                  );
                                  if (user == null) {
                                    return;
                                  }

                                  await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NavBarPage(initialPage: 'HomePage'),
                                    ),
                                    (r) => false,
                                  );
                                },
                                text: 'Sign In',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 50,
                                  color: flutterTheme.of(context).primaryColor,
                                  textStyle: flutterTheme
                                      .of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              width: (width / 3) - (0.1 * (width / 3)),
                              decoration: BoxDecoration(
                                color: flutterTheme
                                    .of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/logo.png',
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.fill,
                                        ),
                                        Text(
                                          'INSTICKET',
                                          style:
                                              flutterTheme.of(context).title1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors ',
                                            maxLines: 8,
                                            softWrap: true,
                                            style:
                                                flutterTheme.of(context).title2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 100.0, right: 100.0),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: TextFormField(
                                  controller: emailController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Email Adress',
                                    hintText: 'Enter Your Email Adress',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFEEEEEE),
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Color(0xFF9E9E9E),
                                      size: 24,
                                    ),
                                  ),
                                  style: flutterTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: !passwordVisibility,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    hintText: 'Enter Your Password',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFEEEEEE),
                                    prefixIcon: Icon(
                                      Icons.lock_outlined,
                                      color: Color(0xFF9E9E9E),
                                      size: 24,
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () => setState(
                                        () => passwordVisibility =
                                            !passwordVisibility,
                                      ),
                                      child: Icon(
                                        passwordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Color(0xFF757575),
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  style: flutterTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                                child: InkWell(
                                  onTap: () async {
                                    if (emailController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Email required!',
                                          ),
                                        ),
                                      );
                                      return;
                                    }
                                    await resetPassword(
                                      email: emailController.text,
                                      context: context,
                                    );
                                  },
                                  child: Text(
                                    'Forget your password ?',
                                    style: flutterTheme
                                        .of(context)
                                        .bodyText2
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: flutterTheme
                                              .of(context)
                                              .primaryColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  final user = await signInWithEmail(
                                    context,
                                    emailController.text,
                                    passwordController.text,
                                  );
                                  if (user == null) {
                                    return;
                                  }

                                  await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NavBarPage(initialPage: 'HomePage'),
                                    ),
                                    (r) => false,
                                  );
                                },
                                text: 'Sign In',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 50,
                                  color: flutterTheme.of(context).primaryColor,
                                  textStyle: flutterTheme
                                      .of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
