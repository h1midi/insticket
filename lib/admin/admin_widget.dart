import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../add_game_ht/add_game_ht_widget.dart';
import '../add_team/add_team_widget.dart';
import '../backend/backend.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_util.dart';
import '../flutter_main/flutter_main_widgets.dart';
import '../main.dart';
import '../scan/scan_widget.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({
    Key key,
    this.scanned,
  }) : super(key: key);

  final String scanned;

  @override
  _AdminWidgetState createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  PagingController<DocumentSnapshot, GamesRecord> _pagingController =
      PagingController(firstPageKey: null);
  List<StreamSubscription> _streamSubscriptions = [];

  var scannedQr = '';
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((nextPageMarker) {
      queryGamesRecordPage(
        queryBuilder: (gamesRecord) =>
            gamesRecord.orderBy('date', descending: true),
        nextPageMarker: nextPageMarker,
        pageSize: 5,
        isStream: true,
      ).then((page) {
        _pagingController.appendPage(
          page.data,
          page.nextPageMarker,
        );
        final streamSubscription = page.dataStream?.listen((data) {
          final itemIndexes = _pagingController.itemList
              .asMap()
              .map((k, v) => MapEntry(v.reference.id, k));
          data.forEach((item) {
            final index = itemIndexes[item.reference.id];
            if (index != null) {
              _pagingController.itemList.replaceRange(index, index + 1, [item]);
            }
          });
          setState(() {});
        });
        _streamSubscriptions.add(streamSubscription);
      });
    });
  }

  ScrollController controller = ScrollController();
  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    super.dispose();
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
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NavBarPage(initialPage: 'Profile'),
              ),
            );
          },
        ),
        title: Text(
          'Admin',
          style: FlutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterTheme.of(context).primaryBackground,
      body: SingleChildScrollView(
        controller: controller,
        child: Center(
          child: SizedBox(
            width:
                MediaQuery.of(context).size.width < 800 ? double.infinity : 800,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddGameHtWidget(),
                          ),
                        );
                      },
                      text: 'Add a new game',
                      icon: Icon(
                        Icons.sports_soccer_outlined,
                        size: 15,
                      ),
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
                        borderRadius: 12,
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
                            builder: (context) => AddTeamWidget(),
                          ),
                        );
                      },
                      text: 'Add a new team',
                      icon: Icon(
                        Icons.flag_outlined,
                        size: 15,
                      ),
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
                        borderRadius: 12,
                      ),
                    ),
                  ),
                  !kIsWeb
                      ? FFButtonWidget(
                          onPressed: () async {
                            scannedQr = await FlutterBarcodeScanner.scanBarcode(
                              '#00C853', // scanning line color
                              'Cancel', // cancel button text
                              true, // whether to show the flash icon
                              ScanMode.QR,
                            );

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScanWidget(
                                  scanned: scannedQr,
                                ),
                              ),
                            );

                            setState(() {});
                          },
                          text: 'Scan QR code',
                          icon: Icon(
                            Icons.qr_code_scanner_outlined,
                            size: 15,
                          ),
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
                            borderRadius: 12,
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
                    child: Text(
                      'Ticket sale statistics',
                      style: FlutterTheme.of(context).title2,
                    ),
                  ),
                  StreamBuilder<List<GamesRecord>>(
                      stream: queryGamesRecord(
                        queryBuilder: (gamesRecord) => gamesRecord,
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
                        List<GamesRecord> listViewGamesRecordList =
                            snapshot.data;
                        return ListView.builder(
                          controller: controller,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewGamesRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewGamesRecord =
                                listViewGamesRecordList[listViewIndex];
                            return kIsWeb
                                ? StatWidgetWeb(
                                    listViewGamesRecord: listViewGamesRecord)
                                : StatWidget(
                                    listViewGamesRecord: listViewGamesRecord);
                          },
                        );
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatWidgetWeb extends StatelessWidget {
  const StatWidgetWeb({
    Key key,
    @required this.listViewGamesRecord,
  }) : super(key: key);

  final GamesRecord listViewGamesRecord;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: FlutterTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 48,
              color: Color(0x0B000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterTheme.of(context).secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: width > height
                          ? AlignmentDirectional(-0.6, 0)
                          : AlignmentDirectional(-0.6, 0.3),
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0.4, 0),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFC8E6C9),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Image.network(
                                listViewGamesRecord.atImageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: width > height
                              ? AlignmentDirectional(-0.6, 0)
                              : AlignmentDirectional(-0.6, 0.3),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFF81C784),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 10),
                              child: Image.network(
                                listViewGamesRecord.htImageUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${listViewGamesRecord.homeTeam} vs ${listViewGamesRecord.awayTeam}',
                      style: FlutterTheme.of(context).bodyText1,
                    ),
                    Text(
                      'covered seats\n${listViewGamesRecord.coveredNumCurrent.toString()} / ${listViewGamesRecord.coveredNum.toString()}',
                      style: FlutterTheme.of(context).bodyText2,
                    ),
                    Text(
                      'normal seats\n${listViewGamesRecord.normalNumCurrent.toString()} / ${listViewGamesRecord.normalNum.toString()}',
                      style: FlutterTheme.of(context).bodyText2,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: FlutterTheme.of(context).secondaryText,
                          size: 12,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            dateTimeFormat(
                                'M / d h:mm a', listViewGamesRecord.date),
                            style: FlutterTheme.of(context).bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total revenue ",
                      style: FlutterTheme.of(context).bodyText1,
                    ),
                    Text(
                      '${listViewGamesRecord.totalRevenue.toString()} \$',
                      style: FlutterTheme.of(context).bodyText2.override(
                            fontSize: 36,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: FlutterTheme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StatWidget extends StatelessWidget {
  const StatWidget({
    Key key,
    @required this.listViewGamesRecord,
  }) : super(key: key);

  final GamesRecord listViewGamesRecord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: FlutterTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 48,
              color: Color(0x0B000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterTheme.of(context).secondaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Stack(
                  alignment: AlignmentDirectional(-0.6, 0),
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.4, -0.3),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFFC8E6C9),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Image.network(
                            listViewGamesRecord.atImageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-0.4, 0.3),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xFF81C784),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                          child: Image.network(
                            listViewGamesRecord.htImageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 15, 0, 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${listViewGamesRecord.homeTeam} vs ${listViewGamesRecord.awayTeam}',
                      style: FlutterTheme.of(context).bodyText1,
                    ),
                    Text(
                      'covered seats\n${listViewGamesRecord.coveredNumCurrent.toString()} / ${listViewGamesRecord.coveredNum.toString()}',
                      style: FlutterTheme.of(context).bodyText2,
                    ),
                    Text(
                      'normal seats\n${listViewGamesRecord.normalNumCurrent.toString()} / ${listViewGamesRecord.normalNum.toString()}',
                      style: FlutterTheme.of(context).bodyText2,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: FlutterTheme.of(context).secondaryText,
                          size: 12,
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                          child: Text(
                            dateTimeFormat(
                                'M / d h:mm a', listViewGamesRecord.date),
                            style: FlutterTheme.of(context).bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total revenue",
                      style: FlutterTheme.of(context).bodyText1,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${listViewGamesRecord.totalRevenue.toString()} \$',
                      style: FlutterTheme.of(context).bodyText1.override(
                            fontSize: 26,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: FlutterTheme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
