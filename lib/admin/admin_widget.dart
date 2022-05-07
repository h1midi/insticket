import 'package:flutter/material.dart';
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
          style: flutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: flutterTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                      color: flutterTheme.of(context).primaryColor,
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
                      color: flutterTheme.of(context).primaryColor,
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
                ),
                FFButtonWidget(
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
                    color: flutterTheme.of(context).primaryColor,
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
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: Text(
                    'Ticket sale statistics',
                    style: flutterTheme.of(context).title2,
                  ),
                ),
                Expanded(
                  child: PagedListView<DocumentSnapshot<Object>, GamesRecord>(
                    pagingController: _pagingController,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    builderDelegate: PagedChildBuilderDelegate<GamesRecord>(
                      // Customize what your widget looks like when it's loading the first page.
                      firstPageProgressIndicatorBuilder: (_) => Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: SpinKitFadingGrid(
                            color: Color(0xFF00C853),
                            size: 50,
                          ),
                        ),
                      ),

                      itemBuilder: (context, _, listViewIndex) {
                        final listViewGamesRecord =
                            _pagingController.itemList[listViewIndex];
                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color:
                                  flutterTheme.of(context).secondaryBackground,
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
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color:
                                        flutterTheme.of(context).secondaryColor,
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
                                        alignment:
                                            AlignmentDirectional(-0.6, 0),
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.4, 0),
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Color(0xFFC8E6C9),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 10, 10, 10),
                                                child: Image.network(
                                                  listViewGamesRecord
                                                      .atImageUrl,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-0.4, 0),
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                color: Color(0xFF81C784),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 10, 10, 10),
                                                child: Image.network(
                                                  listViewGamesRecord
                                                      .htImageUrl,
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
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 15, 10, 15),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${listViewGamesRecord.homeTeam} vs ${listViewGamesRecord.awayTeam}',
                                          style: flutterTheme
                                              .of(context)
                                              .bodyText1,
                                        ),
                                        Text(
                                          '${listViewGamesRecord.coveredNumCurrent.toString()} purchased covered seats out of ${listViewGamesRecord.coveredNum.toString()} available',
                                          style: flutterTheme
                                              .of(context)
                                              .bodyText2,
                                        ),
                                        Text(
                                          '${listViewGamesRecord.normalNumCurrent.toString()} purchased normal seats out of ${listViewGamesRecord.normalNum.toString()} available',
                                          style: flutterTheme
                                              .of(context)
                                              .bodyText2,
                                        ),
                                        Text(
                                          'Total revenue : ${listViewGamesRecord.totalRevenue.toString()} \$',
                                          style: flutterTheme
                                              .of(context)
                                              .bodyText2,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color: flutterTheme
                                                  .of(context)
                                                  .secondaryText,
                                              size: 12,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 0, 0, 0),
                                              child: Text(
                                                dateTimeFormat('M/d h:mm a',
                                                    listViewGamesRecord.date),
                                                style: flutterTheme
                                                    .of(context)
                                                    .bodyText2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
