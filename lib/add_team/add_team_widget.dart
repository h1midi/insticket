import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../admin/admin_widget.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_main/flutter_main_icon_button.dart';
import '../flutter_main/flutter_main_theme.dart';
import '../flutter_main/flutter_main_widgets.dart';
import '../flutter_main/upload_media.dart';

//FR
class AddTeamWidget extends StatefulWidget {
  const AddTeamWidget({Key key}) : super(key: key);

  @override
  _AddTeamWidgetState createState() => _AddTeamWidgetState();
}

class _AddTeamWidgetState extends State<AddTeamWidget> {
  String uploadedFileUrl;
  TextEditingController teamNameController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
    teamNameController = TextEditingController();
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
          'Ajouter une équipe',
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: TextFormField(
                        controller: teamNameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Nom de l\'équipe',
                          hintText: 'Entrez le nom de l\'équipe',
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
                            Icons.flag_outlined,
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
                            return 'saisie obligatoire';
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                      child: FFButtonWidget(
                        onPressed: () async {
                          final selectedMedia =
                              await selectMediaWithSourceBottomSheet(
                            context: context,
                            maxWidth: 150.00,
                            maxHeight: 150.00,
                            allowPhoto: true,
                          );
                          if (selectedMedia != null &&
                              selectedMedia.every((m) =>
                                  validateFileFormat(m.storagePath, context))) {
                            showUploadMessage(
                              context,
                              'Téléchargement du fichier...',
                              showLoading: true,
                            );
                            final downloadUrls = await Future.wait(
                                selectedMedia.map((m) async =>
                                    await uploadData(m.storagePath, m.bytes)));
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            if (downloadUrls != null) {
                              setState(
                                  () => uploadedFileUrl = downloadUrls.first);
                              showUploadMessage(
                                context,
                                'Succès!',
                              );
                            } else {
                              showUploadMessage(
                                context,
                                'Échec du téléchargement',
                              );
                              return;
                            }
                          }
                        },
                        text: 'Télécharger une image',
                        icon: Icon(
                          Icons.camera_alt_outlined,
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
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: Text(
                  'aperçu d\'image',
                  style: FlutterTheme.of(context).title2,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 150,
                  decoration: BoxDecoration(
                    color: FlutterTheme.of(context).secondaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(0),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFFC8E6C9),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                        child: CachedNetworkImage(
                          imageUrl: uploadedFileUrl,
                          placeholder: (context, url) =>
                              new CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              new Image.asset('assets/images/team-logo.png'),
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FFButtonWidget(
                onPressed: () async {
                  if (!formKey.currentState.validate()) {
                    return;
                  }

                  if (uploadedFileUrl == null || uploadedFileUrl.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Télécharger une image est requis',
                          style: FlutterTheme.of(context).bodyText1,
                        ),
                        duration: Duration(milliseconds: 3000),
                        backgroundColor:
                            FlutterTheme.of(context).secondaryBackground,
                      ),
                    );
                    return;
                  }

                  final teamsCreateData = createTeamsRecordData(
                    name: teamNameController.text,
                    imageUrl: uploadedFileUrl,
                  );
                  await TeamsRecord.collection.doc().set(teamsCreateData);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminWidget(),
                    ),
                  );
                },
                text: 'Ajouter l\'équipe',
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
