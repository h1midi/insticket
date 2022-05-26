import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

import 'auth/auth_util.dart';
import 'auth/firebase_user_provider.dart';
import 'flutter_main/flutter_main_theme.dart';
import 'flutter_main/flutter_main_util.dart';
import 'flutter_main/internationalization.dart';
import 'index.dart';

// FR

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterTheme.initialize();

  FFAppState(); // Initialize FFAppState

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  ThemeMode _themeMode = FlutterTheme.themeMode;

  Stream<InsticketFirebaseUser> userStream;
  InsticketFirebaseUser initialUser;
  bool displaySplashImage = true;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    userStream = insticketFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
    Future.delayed(
      Duration(seconds: 1),
      () => setState(() => displaySplashImage = false),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setLocale(Locale value) => setState(() => _locale = value);
  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Insticket',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      home: initialUser == null || displaySplashImage
          ? Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: SpinKitFadingGrid(
                  color: Color(0xFF00C853),
                  size: 50,
                ),
              ),
            )
          : currentUser.loggedIn
              ? NavBarPage()
              : MainWidget(),
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key key, this.initialPage}) : super(key: key);

  final String initialPage;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPage = 'HomePage';

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPage ?? _currentPage;
  }

  @override
  Widget build(BuildContext context) {
    bool isSwitched = Theme.of(context).brightness == Brightness.dark;

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

    final tabs = {
      'HomePage': HomePageWidget(),
      'MyTickets': MyTicketsWidget(),
      'Profile': ProfileWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPage);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          width > height
              ? SideNavigationBar(
                  theme: SideNavigationBarTheme(
                      dividerTheme: SideNavigationBarDividerTheme(
                        showHeaderDivider: true,
                        showMainDivider: true,
                        showFooterDivider: false,
                        headerDividerColor:
                            FlutterTheme.of(context).primaryColor,
                        mainDividerColor: FlutterTheme.of(context).primaryColor,
                      ),
                      itemTheme: SideNavigationBarItemTheme(
                        selectedItemColor:
                            FlutterTheme.of(context).primaryColor,
                      ),
                      togglerTheme: SideNavigationBarTogglerTheme.standard()),
                  header: SideNavigationBarHeader(
                    image: Image.asset(
                      'assets/images/logo.png',
                      height: 40,
                      width: 40,
                      fit: BoxFit.fill,
                    ),
                    title: Text("Insticket                  ",
                        style: FlutterTheme.of(context).title1.override(
                            fontFamily: 'Poppins',
                            color: FlutterTheme.of(context).primaryColor)),
                    subtitle: Text("***"),
                  ),
                  selectedIndex: currentIndex,
                  items: const [
                    SideNavigationBarItem(
                      icon: Icons.home_outlined,
                      label: 'Accueil',
                    ),
                    SideNavigationBarItem(
                      icon: Icons.confirmation_num_outlined,
                      label: 'Billets',
                    ),
                    SideNavigationBarItem(
                      icon: Icons.person_outlined,
                      label: 'Profil',
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      switch (index) {
                        case 0:
                          _currentPage = tabs.keys.toList()[index];
                          break;
                        case 1:
                          _currentPage = tabs.keys.toList()[index];
                          break;
                        case 2:
                          _currentPage = tabs.keys.toList()[index];
                          break;
                      }
                    });
                  },
                  footer: SideNavigationBarFooter(
                      label: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () => launchURL(
                              "https://github.com/hammiddi/projet-PFE/blob/main/README.md"),
                          icon: Icon(Icons.info_outline)),
                      IconButton(
                          onPressed: () => launchUrl(
                              Uri.parse("mailto:mr.hammiddi@gmail.com")),
                          icon: Icon(Icons.people_outline)),
                      IconButton(
                          onPressed: () => (isSwitched == false)
                              ? setState(() {
                                  setDarkModeSetting(context, ThemeMode.dark);
                                })
                              : setState(() {
                                  setDarkModeSetting(context, ThemeMode.light);
                                }),
                          icon: Icon(Icons.dark_mode_outlined)),
                    ],
                  )),
                )
              : Container(),
          Expanded(child: tabs[_currentPage]),
        ],
      ),
      drawer: width < height
          ? Drawer(
              backgroundColor: FlutterTheme.of(context).primaryBackground,
              elevation: 16,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 8.0),
                        child: Text("Insticket",
                            style: FlutterTheme.of(context).title1.override(
                                fontFamily: 'Poppins',
                                color: FlutterTheme.of(context).primaryColor)),
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 20),
                        child: ListTile(
                          title: Text(
                            'À propos',
                            style: FlutterTheme.of(context).bodyText1,
                          ),
                          leading: Icon(Icons.info_outline_rounded),
                          onTap: () {
                            launchURL(
                                "https://github.com/hammiddi/projet-PFE/blob/main/README.md");
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, right: 20),
                        child: ListTile(
                          title: Text(
                            'Contactez-nous',
                            style: FlutterTheme.of(context).bodyText1,
                          ),
                          leading: Icon(Icons.mail_outline_rounded),
                          onTap: () {
                            launchUrl(
                                Uri.parse("mailto:mr.hammiddi@gmail.com"));
                          },
                        ),
                      ),
                      Divider(
                        thickness: 1.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 20, right: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Thème sombre",
                                style: FlutterTheme.of(context)
                                    .bodyText1
                                    .override(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                              ),
                              Switch(
                                inactiveThumbImage: NetworkImage(
                                    "https://cdn-icons-png.flaticon.com/512/5115/5115625.png"),
                                activeThumbImage: NetworkImage(
                                    "https://cdn-icons-png.flaticon.com/512/5115/5115625.png"),
                                onChanged: toggleSwitch,
                                value: isSwitched,
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      bottomNavigationBar: width < height
          ? BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (i) =>
                  setState(() => _currentPage = tabs.keys.toList()[i]),
              backgroundColor: FlutterTheme.of(context).secondaryBackground,
              selectedItemColor: FlutterTheme.of(context).primaryColor,
              unselectedItemColor: FlutterTheme.of(context).unselectedIcon,
              showSelectedLabels: true,
              showUnselectedLabels: false,
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 28,
                  ),
                  label: '•',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.confirmation_num_outlined,
                    size: 28,
                  ),
                  label: '•',
                  tooltip: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_outlined,
                    size: 28,
                  ),
                  label: '•',
                  tooltip: '',
                )
              ],
            )
          : null,
    );
  }
}
