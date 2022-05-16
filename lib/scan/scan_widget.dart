import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../admin/admin_widget.dart';
import '../backend/backend.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_util.dart';
import '../flutter_main/flutter_main_widgets.dart';

// FR

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
          'Code scanné',
          style: FlutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterTheme.of(context).primaryBackground,
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
                    'Billet invalide',
                    style: FlutterTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: FlutterTheme.of(context).warning,
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
                        'Billet : ${containerTicketsRecord.code}',
                        style: FlutterTheme.of(context).title2,
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
                                'Match : ',
                                style:
                                    FlutterTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterTheme.of(context)
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
                                    style: FlutterTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterTheme.of(context)
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
                            color: FlutterTheme.of(context).secondaryText,
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
                                    FlutterTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterTheme.of(context)
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
                                    style: FlutterTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Poppins',
                                          color: FlutterTheme.of(context)
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
                            color: FlutterTheme.of(context).secondaryText,
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
                                'Nom : ${textUsersRecord.displayName}',
                                style:
                                    FlutterTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterTheme.of(context)
                                              .secondaryText,
                                        ),
                              );
                            },
                          ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: FlutterTheme.of(context).secondaryText,
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
                            'Acheté le  : ${dateTimeFormat('d/M h:mm a', containerTicketsRecord.purchasedOn)}',
                            style: FlutterTheme.of(context).bodyText1.override(
                                  fontFamily: 'Poppins',
                                  color: FlutterTheme.of(context).secondaryText,
                                ),
                          ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: FlutterTheme.of(context).secondaryText,
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
                                'Places couverts : ',
                                style:
                                    FlutterTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterTheme.of(context)
                                              .secondaryText,
                                        ),
                              ),
                              if (containerTicketsRecord.isCovered ?? true)
                                Text(
                                  'oui',
                                  style: FlutterTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                              if (!(containerTicketsRecord.isCovered) ?? true)
                                Text(
                                  'non',
                                  style: FlutterTheme.of(context)
                                      .bodyText1
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: FlutterTheme.of(context)
                                            .secondaryText,
                                      ),
                                ),
                            ],
                          ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: FlutterTheme.of(context).secondaryText,
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
                                'Billet valide',
                                style: FlutterTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color:
                                          FlutterTheme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                              ),
                            ),
                          if (!containerTicketsRecord.isValid)
                            Center(
                              child: Text(
                                'Billet utilisé ',
                                style: FlutterTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: FlutterTheme.of(context).warning,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                              ),
                            ),
                          Divider(
                            height: 20,
                            thickness: 1,
                            color: FlutterTheme.of(context).secondaryText,
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
                                color: FlutterTheme.of(context).primaryColor,
                                textStyle:
                                    FlutterTheme.of(context).title2.override(
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
