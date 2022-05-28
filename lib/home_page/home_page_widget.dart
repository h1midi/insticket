import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:text_search/text_search.dart';

import '../backend/backend.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_util.dart';
import '../flutter_main/flutter_main_widgets.dart';
import '../game_details/game_details_widget.dart';

//FR
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({
    Key key,
    this.gameDetails,
  }) : super(key: key);

  final GamesRecord gameDetails;

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  ScrollController controller = ScrollController();
  List<GamesRecord> simpleSearchResults = [];
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isfocusd;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    isfocusd = false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double imgSize;
    if (width < height &&
        ((width / 600).round() == 1) &&
        ((width / 3 - 170) > 60)) {
      imgSize = width / 3 - 190;
    } else if (width < height &&
        ((width / 600).round() == 2) &&
        ((width / 6 - 170) > 60)) {
      imgSize = width / 6 - 170;
    } else if (width > height &&
        ((width / 730).round() == 1) &&
        ((width / 3 - 190) > 45)) {
      imgSize = width / 3 - 190;
    } else if (width > height &&
        ((width / 730).round() == 2) &&
        ((width / 6 - 150) > 45)) {
      imgSize = width / 6 - 150;
    } else if (width > height) {
      imgSize = 45;
    } else {
      imgSize = 60;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: FlutterTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: width < height
              ? Icon(
                  Icons.menu,
                  color: FlutterTheme.of(context).primaryText,
                  size: 32,
                )
              : Container(),
          onPressed: () async {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Text(
          'Accueil',
          style: FlutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterTheme.of(context).primaryBackground,
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterTheme.of(context).secondaryBackground,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Color(0x39000000),
                      offset: Offset(0, 1),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 4),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: AlignmentDirectional(0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                            child: TextFormField(
                              onTap: () => setState(() {
                                isfocusd = true;
                              }),
                              controller: textController,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelStyle:
                                    FlutterTheme.of(context).bodyText1.override(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0xFF57636C),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0x00000000),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                prefixIcon: Icon(
                                  Icons.search_sharp,
                                  color: FlutterTheme.of(context).secondaryText,
                                  size: 24,
                                ),
                              ),
                              style: FlutterTheme.of(context).bodyText1,
                            ),
                          ),
                        ),
                        isfocusd
                            ? FlutterIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 40,
                                icon: Icon(
                                  Icons.close_outlined,
                                  color: FlutterTheme.of(context).primaryText,
                                  size: 20,
                                ),
                                onPressed: () async {
                                  setState(() => FFAppState().fullList = true);
                                },
                              )
                            : Container(),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                isfocusd = false;
                              });
                              await queryGamesRecordOnce()
                                  .then(
                                    (records) => simpleSearchResults =
                                        TextSearch(
                                      records
                                          .map(
                                            (record) => TextSearchItem(record, [
                                              record.awayTeam,
                                              record.homeTeam,
                                              record.stadium
                                            ]),
                                          )
                                          .toList(),
                                    )
                                            .search(textController.text)
                                            .map((r) => r.object)
                                            .toList(),
                                  )
                                  .onError((_, __) => simpleSearchResults = [])
                                  .whenComplete(() => setState(() {}));

                              setState(() => FFAppState().fullList = false);
                            },
                            text: 'Search',
                            options: FFButtonOptions(
                              width: 100,
                              height: 40,
                              color: FlutterTheme.of(context).primaryColor,
                              textStyle:
                                  FlutterTheme.of(context).bodyText1.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                              elevation: 2,
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
                ),
              ),
            ),
            FFAppState().fullList
                ? StreamBuilder<List<GamesRecord>>(
                    stream: queryGamesRecord(
                      queryBuilder: (gamesRecord) => gamesRecord
                          .where('date', isGreaterThan: getCurrentTimestamp)
                          .orderBy('date'),
                    ),
                    builder: (context, snapshot) {
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
                      List<GamesRecord> listViewGamesRecordList = snapshot.data;
                      return width < height
                          ? ListView.builder(
                              controller: controller,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: listViewGamesRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewGamesRecord =
                                    listViewGamesRecordList[listViewIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 20, 20),
                                  child: InkWell(
                                    onTap: () async {
                                      FFAppState().fullList = true;
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GameDetailsWidget(
                                            gameDetails: listViewGamesRecord,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: FlutterTheme.of(context)
                                            .secondaryBackground,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: FlutterTheme.of(context)
                                                  .secondaryColor,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight: Radius.circular(0),
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(0),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 20, 0, 10),
                                                    child: Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFC8E6C9),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10,
                                                                    10, 10, 10),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              listViewGamesRecord
                                                                  .htImageUrl,
                                                          placeholder: (context,
                                                                  url) =>
                                                              new CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              new Image.asset(
                                                                  'assets/images/team-logo.png'),
                                                          width: imgSize + 40,
                                                          height: imgSize + 40,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0,
                                                            right: 3.0),
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        listViewGamesRecord
                                                            .homeTeam,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5, 5, 5, 5),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    'billets disponibles',
                                                    textAlign: TextAlign.center,
                                                    style: FlutterTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color:
                                                              FlutterTheme.of(
                                                                      context)
                                                                  .primaryColor,
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                5, 0, 5, 0),
                                                    child: Text(
                                                      dateTimeFormat(
                                                          'MMMEd',
                                                          listViewGamesRecord
                                                              .date),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterTheme.of(
                                                              context)
                                                          .bodyText1,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 5, 0),
                                                        child: Icon(
                                                          Icons
                                                              .access_time_outlined,
                                                          color: FlutterTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        dateTimeFormat(
                                                            'jm',
                                                            listViewGamesRecord
                                                                .date),
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .bodyText2,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color: FlutterTheme.of(context)
                                                  .secondaryColor,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, 0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 20, 0, 10),
                                                    child: Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFC8E6C9),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(10,
                                                                    10, 10, 10),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              listViewGamesRecord
                                                                  .atImageUrl,
                                                          placeholder: (context,
                                                                  url) =>
                                                              new CircularProgressIndicator(),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              new Image.asset(
                                                                  'assets/images/team-logo.png'),
                                                          width: imgSize + 40,
                                                          height: imgSize + 40,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 3.0,
                                                            right: 3.0),
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        listViewGamesRecord
                                                            .awayTeam,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: GridView.builder(
                                controller: controller,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: width < height
                                      ? (width / 600).round()
                                      : (width / 730).round(),
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 2.8,
                                ),
                                shrinkWrap: true,
                                itemCount: listViewGamesRecordList.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewGamesRecord =
                                      listViewGamesRecordList[listViewIndex];

                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 16),
                                    child: InkWell(
                                      onTap: () async {
                                        FFAppState().fullList = true;
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GameDetailsWidget(
                                              gameDetails: listViewGamesRecord,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 48,
                                              color: Color(0x0B000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      FlutterTheme.of(context)
                                                          .secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(0),
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(0),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 20,
                                                                    0, 10),
                                                        child: Container(
                                                          width: imgSize,
                                                          height: imgSize,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC8E6C9),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  listViewGamesRecord
                                                                      .htImageUrl,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  new CircularProgressIndicator(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  new Image
                                                                          .asset(
                                                                      'assets/images/team-logo.png'),
                                                              width:
                                                                  imgSize + 40,
                                                              height:
                                                                  imgSize + 40,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        listViewGamesRecord
                                                            .homeTeam,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 5, 5, 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'billets disponibles',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 0, 5, 0),
                                                      child: Text(
                                                        dateTimeFormat(
                                                            'MMMEd',
                                                            listViewGamesRecord
                                                                .date),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 5, 0),
                                                          child: Icon(
                                                            Icons
                                                                .access_time_outlined,
                                                            color: FlutterTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          dateTimeFormat(
                                                              'jm',
                                                              listViewGamesRecord
                                                                  .date),
                                                          style:
                                                              FlutterTheme.of(
                                                                      context)
                                                                  .bodyText2,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      FlutterTheme.of(context)
                                                          .secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 20,
                                                                    0, 10),
                                                        child: Container(
                                                          width: imgSize,
                                                          height: imgSize,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC8E6C9),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  listViewGamesRecord
                                                                      .atImageUrl,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  new CircularProgressIndicator(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  new Image
                                                                          .asset(
                                                                      'assets/images/team-logo.png'),
                                                              width:
                                                                  imgSize + 40,
                                                              height:
                                                                  imgSize + 40,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        listViewGamesRecord
                                                            .awayTeam,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  )
                : Builder(
                    builder: (context) {
                      final searchedGames = simpleSearchResults?.toList() ?? [];
                      return width < height
                          ? ListView.builder(
                              controller: controller,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: searchedGames.length,
                              itemBuilder: (context, searchedGamesIndex) {
                                final searchedGamesItem =
                                    searchedGames[searchedGamesIndex];
                                return Visibility(
                                  visible: (searchedGamesItem.date) >
                                      (getCurrentTimestamp),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 20, 20),
                                    child: InkWell(
                                      onTap: () async {
                                        FFAppState().fullList = true;
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GameDetailsWidget(
                                              gameDetails: searchedGamesItem,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          color: FlutterTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 48,
                                              color: Color(0x0B000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: FlutterTheme.of(context)
                                                    .secondaryColor,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(0),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 20, 0, 10),
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC8E6C9),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      10),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                searchedGamesItem
                                                                    .htImageUrl,
                                                            placeholder: (context,
                                                                    url) =>
                                                                new CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                new Image.asset(
                                                                    'assets/images/team-logo.png'),
                                                            width: imgSize + 40,
                                                            height:
                                                                imgSize + 40,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      searchedGamesItem
                                                          .homeTeam,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterTheme.of(
                                                              context)
                                                          .bodyText1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 5, 5, 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'tickets available ',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 0, 5, 0),
                                                      child: Text(
                                                        dateTimeFormat(
                                                            'MMMEd',
                                                            searchedGamesItem
                                                                .date),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 5, 0),
                                                          child: Icon(
                                                            Icons
                                                                .access_time_outlined,
                                                            color: FlutterTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          dateTimeFormat(
                                                              'jm',
                                                              searchedGamesItem
                                                                  .date),
                                                          style:
                                                              FlutterTheme.of(
                                                                      context)
                                                                  .bodyText2,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color: FlutterTheme.of(context)
                                                    .secondaryColor,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                  topLeft: Radius.circular(0),
                                                  topRight: Radius.circular(10),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 20, 0, 10),
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC8E6C9),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10,
                                                                      10,
                                                                      10,
                                                                      10),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl:
                                                                searchedGamesItem
                                                                    .htImageUrl,
                                                            placeholder: (context,
                                                                    url) =>
                                                                new CircularProgressIndicator(),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                new Image.asset(
                                                                    'assets/images/team-logo.png'),
                                                            width: imgSize + 40,
                                                            height:
                                                                imgSize + 40,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      searchedGamesItem
                                                          .awayTeam,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: FlutterTheme.of(
                                                              context)
                                                          .bodyText1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: GridView.builder(
                                controller: controller,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: width < height
                                      ? (width / 600).round()
                                      : (width / 730).round(),
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 2.8,
                                ),
                                shrinkWrap: true,
                                itemCount: searchedGames.length,
                                itemBuilder: (context, listViewIndex) {
                                  final listViewGamesRecord =
                                      searchedGames[listViewIndex];
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 20, 0, 16),
                                    child: InkWell(
                                      onTap: () async {
                                        FFAppState().fullList = true;
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GameDetailsWidget(
                                              gameDetails: listViewGamesRecord,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterTheme.of(context)
                                              .secondaryBackground,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 48,
                                              color: Color(0x0B000000),
                                              offset: Offset(0, 2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      FlutterTheme.of(context)
                                                          .secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(0),
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(0),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 20,
                                                                    0, 10),
                                                        child: Container(
                                                          width: imgSize,
                                                          height: imgSize,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC8E6C9),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  listViewGamesRecord
                                                                      .htImageUrl,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  new CircularProgressIndicator(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  new Image
                                                                          .asset(
                                                                      'assets/images/team-logo.png'),
                                                              width:
                                                                  imgSize + 40,
                                                              height:
                                                                  imgSize + 40,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        listViewGamesRecord
                                                            .homeTeam,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 5, 5, 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Text(
                                                      'billets disponibles',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style:
                                                          FlutterTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: FlutterTheme.of(
                                                                        context)
                                                                    .primaryColor,
                                                              ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5, 0, 5, 0),
                                                      child: Text(
                                                        dateTimeFormat(
                                                            'MMMEd',
                                                            listViewGamesRecord
                                                                .date),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 5, 0),
                                                          child: Icon(
                                                            Icons
                                                                .access_time_outlined,
                                                            color: FlutterTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 12,
                                                          ),
                                                        ),
                                                        Text(
                                                          dateTimeFormat(
                                                              'jm',
                                                              listViewGamesRecord
                                                                  .date),
                                                          style:
                                                              FlutterTheme.of(
                                                                      context)
                                                                  .bodyText2,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      FlutterTheme.of(context)
                                                          .secondaryColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(0),
                                                    bottomRight:
                                                        Radius.circular(10),
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(10),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 20,
                                                                    0, 10),
                                                        child: Container(
                                                          width: imgSize,
                                                          height: imgSize,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC8E6C9),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10,
                                                                        10,
                                                                        10,
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  listViewGamesRecord
                                                                      .atImageUrl,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  new CircularProgressIndicator(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  new Image
                                                                          .asset(
                                                                      'assets/images/team-logo.png'),
                                                              width:
                                                                  imgSize + 40,
                                                              height:
                                                                  imgSize + 40,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),

                                                            // FadeInImage
                                                            //     .assetNetwork(
                                                            //   placeholder:
                                                            //       'assets/images/team-logo.png',
                                                            //   image:
                                                            //       listViewGamesRecord
                                                            //           .atImageUrl,
                                                            //   width: imgSize + 40,
                                                            //   height: imgSize + 40,
                                                            //   fit: BoxFit.contain,
                                                            // ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        listViewGamesRecord
                                                            .awayTeam,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: FlutterTheme.of(
                                                                context)
                                                            .bodyText1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
