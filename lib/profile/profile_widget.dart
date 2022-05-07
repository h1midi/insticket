import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../admin/admin_widget.dart';
import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_widgets.dart';
import '../main/main_widget.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  TextEditingController usernameController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: flutterTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: flutterTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: flutterTheme.of(context).primaryText,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: flutterTheme.of(context).primaryBackground,
      drawer: Drawer(
        elevation: 16,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(1, 0),
                  child: InkWell(
                    onTap: () async {
                      if (scaffoldKey.currentState.isDrawerOpen ||
                          scaffoldKey.currentState.isEndDrawerOpen) {
                        Navigator.pop(context);
                      }
                    },
                    child: Icon(
                      Icons.close_outlined,
                      color: Colors.black,
                      size: 32,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello World',
                      textAlign: TextAlign.center,
                      style: flutterTheme.of(context).bodyText1,
                    ),
                    Divider(),
                    Text(
                      'Hello World',
                      style: flutterTheme.of(context).bodyText1,
                    ),
                    Divider(),
                    Text(
                      'Hello World',
                      style: flutterTheme.of(context).bodyText1,
                    ),
                    Divider(),
                  ],
                ),
                FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: 'Button',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 40,
                    color: Color(0xFFD50000),
                    textStyle: flutterTheme.of(context).subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                    borderRadius: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
          child: StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument(currentUserReference),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: SpinKitFadingGrid(
                      color: Color(0xFF00C853),
                      size: 50,
                    ),
                  ),
                );
              }
              final columnUsersRecord = snapshot.data;
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: InkWell(
                      onTap: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'You can\'t change your email',
                              style: flutterTheme.of(context).bodyText1,
                            ),
                            duration: Duration(milliseconds: 2000),
                            backgroundColor:
                                flutterTheme.of(context).secondaryBackground,
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: flutterTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 5, 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.mail_outlined,
                                color: flutterTheme.of(context).primaryText,
                                size: 24,
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  columnUsersRecord.email,
                                  style: flutterTheme.of(context).bodyText1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                    child: TextFormField(
                      controller: usernameController ??= TextEditingController(
                        text: columnUsersRecord.displayName,
                      ),
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        hintText: 'Enter Your Username',
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
                      style: flutterTheme.of(context).bodyText1.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF9E9E9E),
                          ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: FFButtonWidget(
                      onPressed: () async {
                        final usersUpdateData = createUsersRecordData(
                          displayName: usernameController?.text ?? '',
                        );
                        await columnUsersRecord.reference
                            .update(usersUpdateData);
                        await showDialog(
                          context: context,
                          builder: (alertDialogContext) {
                            return AlertDialog(
                              title: Text('Done !'),
                              content: Text(
                                  'Your username has been successfully updated'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(alertDialogContext),
                                  child: Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      text: 'Update Username',
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
                  if (currentUserDocument?.isAdmin ?? true)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: AuthUserStreamWidget(
                        child: FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminWidget(),
                              ),
                            );
                          },
                          text: 'Admin Dashboard',
                          options: FFButtonOptions(
                            width: double.infinity,
                            height: 50,
                            color: flutterTheme.of(context).primaryColor,
                            textStyle:
                                flutterTheme.of(context).subtitle2.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                    ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 10,
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await signOut();
                        await Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainWidget(),
                          ),
                          (r) => false,
                        );
                      },
                      text: 'log out',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 50,
                        color: Color(0xFFD50000),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
