import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_main/custom_functions.dart' as functions;
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_util.dart';
import '../flutter_main/flutter_main_widgets.dart';
import '../main.dart';

//FR
class GameDetailsWidget extends StatefulWidget {
  const GameDetailsWidget({
    Key key,
    this.gameDetails,
  }) : super(key: key);

  final GamesRecord gameDetails;

  @override
  _GameDetailsWidgetState createState() => _GameDetailsWidgetState();
}

class _GameDetailsWidgetState extends State<GameDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int countOccurrencesUsingLoop(
      List<DocumentReference<Object>> list, DocumentReference<Object> element) {
    if (list == null || list.isEmpty) {
      return 0;
    }

    int count = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i] == element) {
        count++;
      }
    }

    return count;
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
          'Acheter des billets',
          style: FlutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                //HomeImg
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
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
                                      child: CachedNetworkImage(
                                        imageUrl: widget.gameDetails.htImageUrl,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Image.asset(
                                                'assets/images/team-logo.png'),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                //HomeName
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        widget.gameDetails.homeTeam,
                                        textAlign: TextAlign.center,
                                        style:
                                            FlutterTheme.of(context).bodyText1,
                                      ),
                                    ),
                                  ),
                                ),
                                //Date
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5, 0, 5, 0),
                                  child: Text(
                                    dateTimeFormat(
                                        'MMMEd', widget.gameDetails.date),
                                    textAlign: TextAlign.center,
                                    style: FlutterTheme.of(context).bodyText2,
                                  ),
                                ),
                                //Time
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 5, 0),
                                      child: Icon(
                                        Icons.access_time_outlined,
                                        color: FlutterTheme.of(context)
                                            .secondaryText,
                                        size: 12,
                                      ),
                                    ),
                                    Text(
                                      dateTimeFormat(
                                          'jm', widget.gameDetails.date),
                                      style: FlutterTheme.of(context).bodyText2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //VS
                          Expanded(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: FlutterTheme.of(context)
                                              .secondaryColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Align(
                                          alignment: AlignmentDirectional(0, 0),
                                          child: Text(
                                            'vs',
                                            textAlign: TextAlign.center,
                                            style: FlutterTheme.of(context)
                                                .bodyText1,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(10),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //AwayImg
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
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
                                      child: CachedNetworkImage(
                                        imageUrl: widget.gameDetails.atImageUrl,
                                        placeholder: (context, url) =>
                                            new CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            new Image.asset(
                                                'assets/images/team-logo.png'),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                //AwayName
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 3.0, right: 3.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        widget.gameDetails.awayTeam,
                                        textAlign: TextAlign.center,
                                        style:
                                            FlutterTheme.of(context).bodyText1,
                                      ),
                                    ),
                                  ),
                                ),
                                //Stadium
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 5, 0),
                                      child: Icon(
                                        Icons.place_outlined,
                                        color: FlutterTheme.of(context)
                                            .secondaryText,
                                        size: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      child: Center(
                                        child: Text(
                                          widget.gameDetails.stadium,
                                          style: FlutterTheme.of(context)
                                              .bodyText2,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //tITLE
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                    child: Text(
                      widget.gameDetails.title,
                      style: FlutterTheme.of(context).title2,
                    ),
                  ),
                  //dESCRIPTION
                  Container(
                    height: 120,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                      child: Text(
                        widget.gameDetails.desc,
                        style: FlutterTheme.of(context).bodyText1,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width > 590 ? 550 : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Acheter des billets',
                          style: FlutterTheme.of(context).title2,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if ((widget.gameDetails.coveredNumCurrent) <
                              (widget.gameDetails.coveredNum))
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                              child: FFButtonWidget(
                                onPressed: countOccurrencesUsingLoop(
                                          widget.gameDetails.boughtBy.asList(),
                                          currentUserReference,
                                        ) <
                                        4
                                    ? () async {
                                        final ticketsCreateData =
                                            createTicketsRecordData(
                                          code: functions.generateCode(),
                                          user: currentUserReference,
                                          game: widget.gameDetails.reference,
                                          purchasedOn: getCurrentTimestamp,
                                          isValid: true,
                                          isCovered: true,
                                        );
                                        await TicketsRecord.collection
                                            .doc()
                                            .set(ticketsCreateData);

                                        final gamesUpdateData = {
                                          'bought_by': FieldValue.arrayUnion(
                                              [currentUserReference]),
                                          'total_revenue': FieldValue.increment(
                                              widget.gameDetails.normalPrice),
                                          'covered_num_current':
                                              FieldValue.increment(1),
                                        };
                                        await widget.gameDetails.reference
                                            .update(gamesUpdateData);
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NavBarPage(
                                                initialPage: 'MyTickets'),
                                          ),
                                        );
                                      }
                                    : () {},
                                text:
                                    'Places couverts : ${widget.gameDetails.coveredPrice.toString()} \$',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 50,
                                  color: FlutterTheme.of(context).primaryColor,
                                  textStyle: FlutterTheme.of(context)
                                      .bodyText1
                                      .override(
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
                          if ((widget.gameDetails.normalNumCurrent) <
                              (widget.gameDetails.normalNum))
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final ticketsCreateData =
                                      createTicketsRecordData(
                                    code: functions.generateCode(),
                                    user: currentUserReference,
                                    game: widget.gameDetails.reference,
                                    purchasedOn: getCurrentTimestamp,
                                    isValid: true,
                                    isCovered: false,
                                  );
                                  await TicketsRecord.collection
                                      .doc()
                                      .set(ticketsCreateData);

                                  final gamesUpdateData = {
                                    'bought_by': FieldValue.arrayUnion(
                                        [currentUserReference]),
                                    'total_revenue': FieldValue.increment(
                                        widget.gameDetails.normalPrice),
                                    'normal_num_current':
                                        FieldValue.increment(1),
                                  };
                                  await widget.gameDetails.reference
                                      .update(gamesUpdateData);
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NavBarPage(initialPage: 'MyTickets'),
                                    ),
                                  );
                                },
                                text:
                                    'Places normal : ${widget.gameDetails.normalPrice.toString()} \$',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 50,
                                  color: FlutterTheme.of(context).primaryColor,
                                  textStyle: FlutterTheme.of(context)
                                      .bodyText1
                                      .override(
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
                          if ((widget.gameDetails.coveredNum) ==
                              (widget.gameDetails.coveredNumCurrent))
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: FFButtonWidget(
                                onPressed: () {},
                                text:
                                    'Les billets pour les places couvertes sont épuisés',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 50,
                                  color: Color.fromARGB(255, 88, 88, 88),
                                  textStyle: FlutterTheme.of(context)
                                      .bodyText1
                                      .override(
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
                          if ((widget.gameDetails.normalNum) ==
                              (widget.gameDetails.normalNumCurrent))
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                              child: FFButtonWidget(
                                onPressed: () {},
                                text:
                                    'Les billets pour les places normal sont épuisés',
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 50,
                                  color: Color.fromARGB(255, 88, 88, 88),
                                  textStyle: FlutterTheme.of(context)
                                      .bodyText1
                                      .override(
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
                        ],
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
  }
}
