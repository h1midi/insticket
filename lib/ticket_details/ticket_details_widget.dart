import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../backend/backend.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_util.dart';
import '../flutter_main/Utils.dart';
import '../flutter_main/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';

// FR

class TicketDetailsWidget extends StatefulWidget {
  const TicketDetailsWidget({
    Key key,
    this.ticketDetails,
  }) : super(key: key);

  final TicketsRecord ticketDetails;

  @override
  _TicketDetailsWidgetState createState() => _TicketDetailsWidgetState();
}

class _TicketDetailsWidgetState extends State<TicketDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey key;
  Uint8List bytes;
  bool isSaved = false;
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

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
          'Informations sur le billet',
          style: FlutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterTheme.of(context).primaryBackground,
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
        child: Center(
          child: Container(
            width:
                MediaQuery.of(context).size.width < 500 ? double.infinity : 500,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 40, 20, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Text(
                        'Billet : ${widget.ticketDetails.code}',
                        style: FlutterTheme.of(context).title2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Acheté le : ${dateTimeFormat('d/M h:mm a', widget.ticketDetails.purchasedOn)}',
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
                              if (widget.ticketDetails.isCovered ?? true)
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
                              if (!(widget.ticketDetails.isCovered) ?? true)
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Prix : ',
                                style:
                                    FlutterTheme.of(context).bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: FlutterTheme.of(context)
                                              .secondaryText,
                                        ),
                              ),
                              if (widget.ticketDetails.isCovered ?? true)
                                StreamBuilder<GamesRecord>(
                                  stream: GamesRecord.getDocument(
                                      widget.ticketDetails.game),
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
                                      textGamesRecord.coveredPrice.toString(),
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
                              if (!(widget.ticketDetails.isCovered) ?? true)
                                StreamBuilder<GamesRecord>(
                                  stream: GamesRecord.getDocument(
                                      widget.ticketDetails.game),
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
                                      textGamesRecord.normalPrice.toString(),
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
                              Text(
                                ' \$',
                                style:
                                    FlutterTheme.of(context).bodyText1.override(
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
                    !kIsWeb
                        ? Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final bytes = await Utils.capture(key);
                                  setState(() {
                                    this.bytes = bytes;
                                    isSaved = true;
                                  });
                                  Timer(Duration(seconds: 3), () {
                                    setState(() {
                                      isSaved = false;
                                    });
                                  });
                                  if (await _requestPermission(
                                      Permission.storage)) {
                                    Directory directory =
                                        await getExternalStorageDirectory();
                                    String newPath = "";
                                    List<String> paths =
                                        directory.path.split("/");
                                    for (int x = 1; x < paths.length; x++) {
                                      String folder = paths[x];
                                      if (folder != "Android") {
                                        newPath += "/" + folder;
                                      } else {
                                        break;
                                      }
                                    }
                                    newPath = newPath + "/Insticket";
                                    await Directory(newPath).create();
                                    directory = Directory(newPath);

                                    print(directory);

                                    final pathOfImage = await File(
                                            '${directory.path}/${DateTime.now().microsecondsSinceEpoch}.png')
                                        .create();
                                    await pathOfImage.writeAsBytes(bytes);
                                  } else {
                                    return false;
                                  }
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Téléchargez votre billet',
                                      style: FlutterTheme.of(context).title2,
                                    ),
                                    isSaved
                                        ? Icon(
                                            Icons.check,
                                            color: FlutterTheme.of(context)
                                                .primaryColor,
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                              child: Text(
                                "Code QR",
                                style: FlutterTheme.of(context).title2,
                              ),
                            ),
                          ),
                    WidgetToImage(
                      builder: (key) {
                        this.key = key;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: QrImage(
                                  data: widget.ticketDetails.code,
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
