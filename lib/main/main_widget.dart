import 'package:flutter/material.dart';

import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_widgets.dart';
import '../sign_in/sign_in_widget.dart';
import '../sign_up/sign_up_widget.dart';

//FR
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
      backgroundColor: FlutterTheme.of(context).primaryBackground,
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
                      style: FlutterTheme.of(context).title1,
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
                      text: 'S\'identifier',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50,
                        color: FlutterTheme.of(context).primaryBackground,
                        textStyle: FlutterTheme.of(context).subtitle2.override(
                              fontFamily: 'Poppins',
                              color: FlutterTheme.of(context).primaryColor,
                            ),
                        borderSide: BorderSide(
                          color: FlutterTheme.of(context).primaryColor,
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
                      text: 'S\'inscrire',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50,
                        color: FlutterTheme.of(context).primaryColor,
                        textStyle: FlutterTheme.of(context).subtitle2.override(
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
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: SizedBox(
              width: (width / 2),
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
                        maxLines: 8,
                        softWrap: true,
                        style: FlutterTheme.of(context).bodyText1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: (width / 2),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInWidget(),
                        ),
                      );
                    },
                    text: 'S\'identifier',
                    options: FFButtonOptions(
                      width: width / 2,
                      height: 50,
                      color: FlutterTheme.of(context).primaryBackground,
                      textStyle: FlutterTheme.of(context).subtitle2.override(
                            fontFamily: 'Poppins',
                            color: FlutterTheme.of(context).primaryColor,
                          ),
                      borderSide: BorderSide(
                        color: FlutterTheme.of(context).primaryColor,
                        width: 2,
                      ),
                      borderRadius: 10,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                  child: FFButtonWidget(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpWidget(),
                        ),
                      );
                    },
                    text: 'S\'inscrire',
                    options: FFButtonOptions(
                      width: width / 2,
                      height: 50,
                      color: FlutterTheme.of(context).primaryColor,
                      textStyle: FlutterTheme.of(context).subtitle2.override(
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
    );
  }
}
