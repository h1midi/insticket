import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../backend/backend.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_util.dart';

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
          'Ticket Details',
          style: flutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: flutterTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width < 500
                  ? double.infinity
                  : 500,
              height: double.infinity,
              decoration: BoxDecoration(
                color: flutterTheme.of(context).secondaryBackground,
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
                          'Ticket : ${widget.ticketDetails.code}',
                          style: flutterTheme.of(context).title2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Purchased on  : ${dateTimeFormat('d/M h:mm a', widget.ticketDetails.purchasedOn)}',
                              style: flutterTheme
                                  .of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Poppins',
                                    color:
                                        flutterTheme.of(context).secondaryText,
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
                                if (widget.ticketDetails.isCovered ?? true)
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
                                if (!(widget.ticketDetails.isCovered) ?? true)
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
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Price : ',
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
                                Text(
                                  ' \$',
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
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                          child: Text(
                            'Scan QR Code',
                            style: flutterTheme.of(context).title2,
                          ),
                        ),
                      ),
                      Padding(
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
                              child: Image.network(
                                'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=${widget.ticketDetails.code}',
                                width: 180,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
