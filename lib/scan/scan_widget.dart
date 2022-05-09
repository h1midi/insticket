import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../admin/admin_widget.dart';
import '../backend/backend.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_util.dart';
import '../flutter_main/flutter_main_widgets.dart';

class ScanWidget extends StatefulWidget {
  const ScanWidget({
    Key key,
    this.scanned,
  }) : super(key: key);

  final String scanned;

  @override
  _ScanWidgetState createState() => _ScanWidgetState();
}

class _ScanWidgetState extends State<ScanWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
          'Scanned Code',
          style: flutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: flutterTheme.of(context).primaryBackground,
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
        child: StreamBuilder<List<TicketsRecord>>(
          stream: queryTicketsRecord(
            queryBuilder: (ticketsRecord) => ticketsRecord.where('code',
                isEqualTo: valueOrDefault<String>(
                  widget.scanned,
                  'invalid',
                )),
            singleRecord: true,
          ),
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
            List<TicketsRecord> containerTicketsRecordList = snapshot.data;
            // Return an empty Container when the document does not exist.
            if (snapshot.data.isEmpty) {
              return Container(
                child: Center(
                  child: Text(
                    'Invalid Ticket ',
                    style: flutterTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: flutterTheme.of(context).warning,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                  ),
                ),
              );
            }
            final containerTicketsRecord = containerTicketsRecordList.isNotEmpty
                ? containerTicketsRecordList.first
                : null;
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Text(
                        'Ticket : ${containerTicketsRecord.code}',
                        style: flutterTheme.of(context).title2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Game : ',
                                style:
                                    flutterTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: flutterTheme
                                              .of(context)
                                              .secondaryText,
                                        ),
                              ),
                              StreamBuilder<GamesRecord>(
                                stream: GamesRecord.getDocument(
                                    containerTicketsRecord.game),
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
                                  final textGamesRecord = snapshot.data;
                                  return Text(
                                    textGamesRecord.versus,
                                    style: flutterTheme
                                        .of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: flutterTheme
                                              .of(context)
                                              .secondaryText,
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: flutterTheme.of(context).secondaryText,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Date : ',
                                style:
                                    flutterTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: flutterTheme
                                              .of(context)
                                              .secondaryText,
                                        ),
                              ),
                              StreamBuilder<GamesRecord>(
                                stream: GamesRecord.getDocument(
                                    containerTicketsRecord.game),
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
                                  final textGamesRecord = snapshot.data;
                                  return Text(
                                    dateTimeFormat(
                                        'd/M/y', textGamesRecord.date),
                                    style: flutterTheme
                                        .of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: flutterTheme
                                              .of(context)
                                              .secondaryText,
                                        ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: flutterTheme.of(context).secondaryText,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<UsersRecord>(
                            stream: UsersRecord.getDocument(
                                containerTicketsRecord.user),
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
                              final textUsersRecord = snapshot.data;
                              return Text(
                                'Name : ${textUsersRecord.displayName}',
                                style:
                                    flutterTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: flutterTheme
                                              .of(context)
                                              .secondaryText,
                                        ),
                              );
                            },
                          ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: flutterTheme.of(context).secondaryText,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Purchased on  : ${dateTimeFormat('d/M h:mm a', containerTicketsRecord.purchasedOn)}',
                            style: flutterTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: flutterTheme.of(context).secondaryText,
                                ),
                          ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: flutterTheme.of(context).secondaryText,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Cover seat : ',
                                style:
                                    flutterTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: flutterTheme
                                              .of(context)
                                              .secondaryText,
                                        ),
                              ),
                              if (containerTicketsRecord.isCovered ?? true)
                                Text(
                                  'yes',
                                  style: flutterTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: flutterTheme
                                            .of(context)
                                            .secondaryText,
                                      ),
                                ),
                              if (!(containerTicketsRecord.isCovered) ?? true)
                                Text(
                                  'no',
                                  style: flutterTheme
                                      .of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: flutterTheme
                                            .of(context)
                                            .secondaryText,
                                      ),
                                ),
                            ],
                          ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: flutterTheme.of(context).secondaryText,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (containerTicketsRecord.isValid)
                            Center(
                              child: Text(
                                'Valid Ticket',
                                style: flutterTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color:
                                          flutterTheme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                              ),
                            ),
                          if (!containerTicketsRecord.isValid)
                            Center(
                              child: Text(
                                'Used Ticket ',
                                style: flutterTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: flutterTheme.of(context).warning,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                              ),
                            ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: flutterTheme.of(context).secondaryText,
                          ),
                        ],
                      ),
                    ),
                    if (containerTicketsRecord.isValid)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                final ticketsUpdateData =
                                    createTicketsRecordData(
                                  isValid: false,
                                );
                                await containerTicketsRecord.reference
                                    .update(ticketsUpdateData);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminWidget(),
                                  ),
                                );
                              },
                              text: 'Ok',
                              options: FFButtonOptions(
                                width: 200,
                                height: 50,
                                color: flutterTheme.of(context).primaryColor,
                                textStyle:
                                    flutterTheme.of(context).title2.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF212121),
                                        ),
                                elevation: 1,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: 10,
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
