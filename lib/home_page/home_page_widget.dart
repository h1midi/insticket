import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_util.dart';
import '../flutter_main/flutter_main_widgets.dart';
import '../game_details/game_details_widget.dart';
import '../main/main_widget.dart';

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
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSwitched = true;
  ScrollController controller = ScrollController();
  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        setDarkModeSetting(context, ThemeMode.dark);
      });
    } else {
      setState(() {
        isSwitched = false;
        setDarkModeSetting(context, ThemeMode.light);
      });
    }
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
            Icons.menu,
            color: flutterTheme.of(context).primaryText,
            size: 32,
          ),
          onPressed: () async {
            scaffoldKey.currentState.openDrawer();
          },
        ),
        title: Text(
          'Home',
          style: flutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: flutterTheme.of(context).primaryBackground,
      drawer: Drawer(
        elevation: 16,
        child: SafeArea(
          child: Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            decoration: BoxDecoration(
              color: flutterTheme.of(context).primaryBackground,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional(1, 0),
                  child: InkWell(
                    onTap: () {
                      if (scaffoldKey.currentState.isDrawerOpen ||
                          scaffoldKey.currentState.isEndDrawerOpen) {
                        Navigator.pop(context);
                      }
                    },
                    child: Icon(
                      Icons.close_outlined,
                      color: Theme.of(context).brightness != Brightness.dark ??
                              true
                          ? Colors.black
                          : Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                Text(
                  'About',
                  style: flutterTheme.of(context).bodyText1,
                ),
                Divider(),
                Text(
                  'Contact us',
                  style: flutterTheme.of(context).bodyText1,
                ),
                Divider(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dark theme",
                        style: flutterTheme.of(context).bodyText1,
                      ),
                      Switch(
                        onChanged: toggleSwitch,
                        value: isSwitched,
                      )
                    ]),
              ],
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 20),
                child: Text(
                  'Upcoming Games',
                  style: flutterTheme.of(context).title2,
                ),
              ),
              StreamBuilder<List<GamesRecord>>(
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
                  double height = MediaQuery.of(context).size.height;
                  double width = MediaQuery.of(context).size.width;
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                              child: InkWell(
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GameDetailsWidget(
                                        gameDetails: listViewGamesRecord,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: flutterTheme
                                        .of(context)
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
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: flutterTheme
                                              .of(context)
                                              .secondaryColor,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(0),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Align(
                                              alignment:
                                                  AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 0, 10),
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFC8E6C9),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 10, 10, 10),
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
                                            ),
                                            Expanded(
                                              child: Text(
                                                listViewGamesRecord.homeTeam,
                                                style: flutterTheme
                                                    .of(context)
                                                    .bodyText1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5, 5, 5, 5),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'tickets available ',
                                                textAlign: TextAlign.center,
                                                style: flutterTheme
                                                    .of(context)
                                                    .bodyText1
                                                    .override(
                                                      fontFamily: 'Poppins',
                                                      color: flutterTheme
                                                          .of(context)
                                                          .primaryColor,
                                                    ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 0, 5, 0),
                                                child: Text(
                                                  dateTimeFormat('MMMEd',
                                                      listViewGamesRecord.date),
                                                  textAlign: TextAlign.center,
                                                  style: flutterTheme
                                                      .of(context)
                                                      .bodyText1,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 0, 5, 0),
                                                    child: Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      color: flutterTheme
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
                                                    style: flutterTheme
                                                        .of(context)
                                                        .bodyText2,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: flutterTheme
                                              .of(context)
                                              .secondaryColor,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(10),
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
                                                  AlignmentDirectional(0, 0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 20, 0, 10),
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFC8E6C9),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 10, 10, 10),
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
                                            ),
                                            Expanded(
                                              child: Text(
                                                listViewGamesRecord.awayTeam,
                                                style: flutterTheme
                                                    .of(context)
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
                            );
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: GridView.builder(
                            controller: controller,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: (width / 600).round(),
                                    crossAxisSpacing: 16,
                                    childAspectRatio: (width / 600) + 1.5 < 3
                                        ? (width / 600) + 1.5
                                        : 3),
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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GameDetailsWidget(
                                          gameDetails: listViewGamesRecord,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: flutterTheme
                                          .of(context)
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
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: flutterTheme
                                                  .of(context)
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
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listViewGamesRecord
                                                        .homeTeam,
                                                    style: flutterTheme
                                                        .of(context)
                                                        .bodyText1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 5, 5, 5),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  'tickets available ',
                                                  textAlign: TextAlign.center,
                                                  style: flutterTheme
                                                      .of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Poppins',
                                                        color: flutterTheme
                                                            .of(context)
                                                            .primaryColor,
                                                      ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(5, 0, 5, 0),
                                                  child: Text(
                                                    dateTimeFormat(
                                                        'MMMEd',
                                                        listViewGamesRecord
                                                            .date),
                                                    textAlign: TextAlign.center,
                                                    style: flutterTheme
                                                        .of(context)
                                                        .bodyText1,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 5, 0),
                                                      child: Icon(
                                                        Icons
                                                            .access_time_outlined,
                                                        color: flutterTheme
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
                                                      style: flutterTheme
                                                          .of(context)
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
                                              color: flutterTheme
                                                  .of(context)
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
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    listViewGamesRecord
                                                        .awayTeam,
                                                    style: flutterTheme
                                                        .of(context)
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
      ),
    );
  }
}
