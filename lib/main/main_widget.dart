import 'package:flutter/material.dart';

import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_widgets.dart';
import '../sign_in/sign_in_widget.dart';
import '../sign_up/sign_up_widget.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({Key key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: flutterTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            child: width < height ? OnPhone() : OnPc(),
          ),
        ),
      ),
    );
  }
}

class OnPhone extends StatelessWidget {
  const OnPhone({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
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
                  color: flutterTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInWidget(),
                          ),
                        );
                      },
                      text: 'Sign In',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50,
                        color: flutterTheme.of(context).primaryBackground,
                        textStyle: flutterTheme.of(context).subtitle2.override(
                              fontFamily: 'Poppins',
                              color: flutterTheme.of(context).primaryColor,
                            ),
                        borderSide: BorderSide(
                          color: flutterTheme.of(context).primaryColor,
                          width: 2,
                        ),
                        borderRadius: 10,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpWidget(),
                          ),
                        );
                      },
                      text: 'Sign Up',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50,
                        color: flutterTheme.of(context).primaryColor,
                        textStyle: flutterTheme.of(context).subtitle2.override(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OnPc extends StatelessWidget {
  const OnPc({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
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
                    color: flutterTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Column(
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
                              style: flutterTheme.of(context).title1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors ',
                                maxLines: 8,
                                softWrap: true,
                                style: flutterTheme.of(context).title2,
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
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 100.0, right: 100.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInWidget(),
                            ),
                          );
                        },
                        text: 'Sign In',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 50,
                          color: flutterTheme.of(context).primaryBackground,
                          textStyle: flutterTheme
                              .of(context)
                              .subtitle2
                              .override(
                                fontFamily: 'Poppins',
                                color: flutterTheme.of(context).primaryColor,
                              ),
                          borderSide: BorderSide(
                            color: flutterTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpWidget(),
                            ),
                          );
                        },
                        text: 'Sign Up',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 50,
                          color: flutterTheme.of(context).primaryColor,
                          textStyle:
                              flutterTheme.of(context).subtitle2.override(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
