import 'package:flutter/material.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_widgets.dart';
import '../on_boarding/on_boarding_widget.dart';

// FR

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key key}) : super(key: key);

  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController confirmPasswordController;
  bool confirmPasswordVisibility;
  TextEditingController emailController;
  TextEditingController usernameController;
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    confirmPasswordController = TextEditingController();
    confirmPasswordVisibility = false;
    emailController = TextEditingController();
    usernameController = TextEditingController();
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
        backgroundColor: FlutterTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterTheme.of(context).primaryText,
            size: 32,
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'S\'inscrire',
          style: FlutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: width < height
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Container(
                          width: 200,
                          height: 200,
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
                                style: FlutterTheme.of(context).title1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                            child: TextFormField(
                              controller: usernameController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Nom',
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: 'Entrez votre nom',
                                hintStyle: TextStyle(color: Colors.grey),
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
                                  Icons.person_outline,
                                  color: Color(0xFF9E9E9E),
                                  size: 24,
                                ),
                              ),
                              style:
                                  FlutterTheme.of(context).bodyText1.override(
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
                              controller: emailController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Adresse e-mail',
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: 'Entrez votre adresse e-mail',
                                hintStyle: TextStyle(color: Colors.grey),
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
                              style:
                                  FlutterTheme.of(context).bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: !passwordVisibility,
                              decoration: InputDecoration(
                                labelText: 'Mot de passe',
                                labelStyle: TextStyle(color: Colors.black),
                                hintText: 'Entrez votre mot de passe',
                                hintStyle: TextStyle(color: Colors.grey),
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
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    size: 22,
                                  ),
                                ),
                              ),
                              style:
                                  FlutterTheme.of(context).bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF9E9E9E),
                                      ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                            child: TextFormField(
                              controller: confirmPasswordController,
                              obscureText: !confirmPasswordVisibility,
                              decoration: InputDecoration(
                                labelText: 'Confirmez le mot de passe',
                                labelStyle: TextStyle(color: Colors.black),
                                hintText:
                                    'Entrez votre mot de passe une fois de plus',
                                hintStyle: TextStyle(color: Colors.grey),
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
                                    () => confirmPasswordVisibility =
                                        !confirmPasswordVisibility,
                                  ),
                                  child: Icon(
                                    confirmPasswordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: Color(0xFF757575),
                                    size: 22,
                                  ),
                                ),
                              ),
                              style:
                                  FlutterTheme.of(context).bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Les mots de passe ne correspondent pas !',
                                    ),
                                  ),
                                );
                                return;
                              }

                              final user = await createAccountWithEmail(
                                context,
                                emailController.text,
                                passwordController.text,
                              );
                              if (user == null) {
                                return;
                              }

                              final usersCreateData = createUsersRecordData(
                                displayName: usernameController.text,
                              );
                              await UsersRecord.collection
                                  .doc(user.uid)
                                  .update(usersCreateData);

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OnBoardingWidget(),
                                ),
                              );
                            },
                            text: 'S\'inscrire',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 50,
                              color: FlutterTheme.of(context).primaryColor,
                              textStyle:
                                  FlutterTheme.of(context).subtitle2.override(
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
                    ],
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          width: (width / 3) - (0.1 * (width / 3)),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/logo.png',
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.fill,
                                ),
                                Text(
                                  'INSTICKET',
                                  style: FlutterTheme.of(context).title1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 22.0),
                                  child: Text(
                                    'Une solution de vente de billet en temps réel et de controle d’accès au niveau des stades de football',
                                    softWrap: true,
                                    maxLines: 8,
                                    style: FlutterTheme.of(context).bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                  controller: usernameController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Nom',
                                    hintText: 'Entrez votre nom',
                                    labelStyle: TextStyle(color: Colors.black),
                                    hintStyle: TextStyle(color: Colors.grey),
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
                                      Icons.person_outline,
                                      color: Color(0xFF9E9E9E),
                                      size: 24,
                                    ),
                                  ),
                                  style: FlutterTheme.of(context)
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
                                  controller: emailController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Adresse e-mail',
                                    hintText: 'Entrez votre adresse e-mail',
                                    labelStyle: TextStyle(color: Colors.black),
                                    hintStyle: TextStyle(color: Colors.grey),
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
                                  style: FlutterTheme.of(context)
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
                                    labelText: 'Mot de passe',
                                    hintText: 'Entrez votre mot de passe',
                                    labelStyle: TextStyle(color: Colors.black),
                                    hintStyle: TextStyle(color: Colors.grey),
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
                                  style: FlutterTheme.of(context)
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
                                child: TextFormField(
                                  controller: confirmPasswordController,
                                  obscureText: !confirmPasswordVisibility,
                                  decoration: InputDecoration(
                                    labelText: 'Confirmez le mot de passe',
                                    hintText:
                                        'Entrez votre mot de passe une fois de plus',
                                    labelStyle: TextStyle(color: Colors.black),
                                    hintStyle: TextStyle(color: Colors.grey),
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
                                        () => confirmPasswordVisibility =
                                            !confirmPasswordVisibility,
                                      ),
                                      child: Icon(
                                        confirmPasswordVisibility
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Color(0xFF757575),
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  style: FlutterTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                ),
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  if (passwordController.text !=
                                      confirmPasswordController.text) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Les mots de passe ne correspondent pas !',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  final user = await createAccountWithEmail(
                                    context,
                                    emailController.text,
                                    passwordController.text,
                                  );
                                  if (user == null) {
                                    return;
                                  }

                                  final usersCreateData = createUsersRecordData(
                                    displayName: usernameController.text,
                                  );
                                  await UsersRecord.collection
                                      .doc(user.uid)
                                      .update(usersCreateData);

                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => OnBoardingWidget(),
                                    ),
                                  );
                                },
                                text: 'S\'inscrire',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 50,
                                  color: FlutterTheme.of(context).primaryColor,
                                  textStyle: FlutterTheme.of(context)
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
