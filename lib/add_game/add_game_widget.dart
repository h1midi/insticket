import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../admin/admin_widget.dart';
import '../backend/backend.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_util.dart';
import '../flutter_main/flutter_main_widgets.dart';

//FR
class AddGameWidget extends StatefulWidget {
  const AddGameWidget({
    Key key,
    this.team,
    this.team2,
  }) : super(key: key);

  final TeamsRecord team;
  final TeamsRecord team2;

  @override
  _AddGameWidgetState createState() => _AddGameWidgetState();
}

class _AddGameWidgetState extends State<AddGameWidget> {
  DateTime datePicked;
  TextEditingController acsController;
  TextEditingController descController;
  TextEditingController titleController;
  TextEditingController stadiumController;
  TextEditingController ansController;
  TextEditingController pcsController;
  TextEditingController pnsController;
  ScrollController controller = ScrollController();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    acsController = TextEditingController();
    descController = TextEditingController();
    titleController = TextEditingController();
    stadiumController = TextEditingController();
    ansController = TextEditingController();
    pcsController = TextEditingController();
    pnsController = TextEditingController();
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Ajoutez un match',
          style: FlutterTheme.of(context).title1,
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: FlutterTheme.of(context).primaryBackground,
      body: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 30, 20, 0),
                child: Container(
                  width: double.infinity,
                  height: 120,
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
                    mainAxisSize: MainAxisSize.max,
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
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                    imageUrl: widget.team.imageUrl,
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
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 10),
                                child: Text(
                                  widget.team.name,
                                  style: FlutterTheme.of(context).bodyText1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
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
                                        style:
                                            FlutterTheme.of(context).bodyText1,
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
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                    imageUrl: widget.team2.imageUrl,
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
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 10, 0, 10),
                                child: Text(
                                  widget.team2.name,
                                  style: FlutterTheme.of(context).bodyText1,
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
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: TextFormField(
                        controller: titleController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Titre',
                          hintText: 'Tapez un titre',
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black),
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
                            Icons.text_fields_outlined,
                            color: Color(0xFF9E9E9E),
                            size: 24,
                          ),
                        ),
                        style: FlutterTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF9E9E9E),
                            ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Champs obligatoires';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: TextFormField(
                        controller: descController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Tapez une description',
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black),
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
                            Icons.text_fields_outlined,
                            color: Color(0xFF9E9E9E),
                            size: 24,
                          ),
                        ),
                        style: FlutterTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF9E9E9E),
                            ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Champs obligatoires';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: TextFormField(
                        controller: stadiumController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Stade',
                          hintText: 'Entrez le nom du stade',
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black),
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
                            Icons.place_outlined,
                            color: Color(0xFF9E9E9E),
                            size: 24,
                          ),
                        ),
                        style: FlutterTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF9E9E9E),
                            ),
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Champs obligatoires';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: TextFormField(
                        controller: acsController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Places couvertes disponibles',
                          hintText:
                              'Entrez le nombre de places couvertes disponibles',
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black),
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
                            Icons.event_seat_outlined,
                            color: Color(0xFF9E9E9E),
                            size: 24,
                          ),
                        ),
                        style: FlutterTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF9E9E9E),
                            ),
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Champs obligatoires';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: TextFormField(
                        controller: ansController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Places normal disponibles',
                          hintText:
                              'Entrez le nombre de places normal disponibles',
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black),
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
                            Icons.event_seat_outlined,
                            color: Color(0xFF9E9E9E),
                            size: 24,
                          ),
                        ),
                        style: FlutterTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF9E9E9E),
                            ),
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Champs obligatoires';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: TextFormField(
                        controller: pcsController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Prix d\'une place couverte',
                          hintText: 'Saisissez le prix d\'une place couverte',
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black),
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
                            Icons.local_atm,
                            color: Color(0xFF9E9E9E),
                            size: 24,
                          ),
                        ),
                        style: FlutterTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF9E9E9E),
                            ),
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Champs obligatoires';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: TextFormField(
                        controller: pnsController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Prix d\'une place normal',
                          hintText: 'Saisissez le prix d\'une place normal',
                          labelStyle: TextStyle(color: Colors.black),
                          hintStyle: TextStyle(color: Colors.black),
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
                            Icons.local_atm,
                            color: Color(0xFF9E9E9E),
                            size: 24,
                          ),
                        ),
                        style: FlutterTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF9E9E9E),
                            ),
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Champs obligatoires';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await DatePicker.showDateTimePicker(
                            context,
                            showTitleActions: true,
                            onConfirm: (date) {
                              setState(() => datePicked = date);
                            },
                            currentTime: getCurrentTimestamp,
                            minTime: getCurrentTimestamp,
                          );
                        },
                        text: 'Sélectionnez l\'heure et la date',
                        icon: Icon(
                          Icons.access_time,
                          size: 15,
                        ),
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 50,
                          color: FlutterTheme.of(context).primaryBackground,
                          textStyle: FlutterTheme.of(context)
                              .subtitle2
                              .override(
                                fontFamily: 'Poppins',
                                color: FlutterTheme.of(context).primaryColor,
                              ),
                          borderSide: BorderSide(
                            color: FlutterTheme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  if (!formKey.currentState.validate()) {
                    return;
                  }

                  if (datePicked == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Veuillez sélectionner l\'heure et la date',
                          style: FlutterTheme.of(context).bodyText1,
                        ),
                        duration: Duration(milliseconds: 3000),
                        backgroundColor:
                            FlutterTheme.of(context).secondaryBackground,
                      ),
                    );
                    return;
                  }

                  final gamesCreateData = createGamesRecordData(
                    date: datePicked,
                    title: titleController.text,
                    desc: descController.text,
                    stadium: stadiumController.text,
                    homeTeam: widget.team.name,
                    htImageUrl: widget.team.imageUrl,
                    awayTeam: widget.team2.name,
                    atImageUrl: widget.team2.imageUrl,
                    coveredNum: int.parse(acsController.text),
                    coveredPrice: int.parse(pcsController.text),
                    normalPrice: int.parse(pnsController.text),
                    normalNum: int.parse(ansController.text),
                    versus: '${widget.team.name} VS ${widget.team2.name}',
                  );
                  await GamesRecord.collection.doc().set(gamesCreateData);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminWidget(),
                    ),
                  );
                },
                text: 'Ajouter le macth',
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
            ],
          ),
        ),
      ),
    );
  }
}
