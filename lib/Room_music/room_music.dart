import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_fonts/google_fonts.dart';


const urlRhythm = "https://www.youtube.com/results?search_query=baby+rhythm";
const urlMusic = "https://www.youtube.com/results?search_query=sleep+music";
const urlSearch = "https://www.youtube.com/";
const urlSpotify = "https://open.spotify.com/";
const urlSaavan = "https://www.jiosaavn.com/";
const urlGaana = "https://www.gaana.com/music/";

class RoomMusic extends StatelessWidget {
  const RoomMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        "/": (_) => const Home(),
        "/rhythm": (_) => Container(
          padding: const EdgeInsets.only(top: 50),
          child: const WebviewScaffold(
            url: urlRhythm,
            withJavascript: true,
            withLocalStorage: true,
            withZoom: true,
          ),
        ),
        "/sleep": (_) => Container(
          padding: const EdgeInsets.only(top: 50),
          child: const WebviewScaffold(
            url: urlMusic,
            withJavascript: true,
            withLocalStorage: true,
            withZoom: true,
          ),
        ),
        "/search": (_) => Container(
          padding: const EdgeInsets.only(top: 50),
          child: const WebviewScaffold(
            url: urlSearch,
            withJavascript: true,
            withLocalStorage: true,
            withZoom: true,
          ),
        ),
        "/spotify": (_) => Container(
          padding: const EdgeInsets.only(top: 50),
          child: const WebviewScaffold(
            url: urlSpotify,
            withJavascript: true,
            withLocalStorage: true,
            withZoom: true,
          ),
        ),
        "/saavan": (_) => Container(
          padding: const EdgeInsets.only(top: 50),
          child: const WebviewScaffold(
            url: urlSaavan,
            withJavascript: true,
            withLocalStorage: true,
            withZoom: true,
          ),
        ),
        "/gaana": (_) => Container(
          padding: const EdgeInsets.only(top: 50),
          child: const WebviewScaffold(
            url: urlGaana,
            withJavascript: true,
            withLocalStorage: true,
            withZoom: true,
          ),
        ),
      },

      // home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final webView = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    webView.close();

  }

  @override
  void dispose() {
    webView.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30,),
                    Column(
                      children: [
                        const SizedBox(height: 50,),
                        Center(
                          child: Text(
                            'Our Playlist',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 52,
                                color: Colors.black45
                            ),
                          ),
                        ),

                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("/rhythm");
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ]
                                  )
                              ),
                              child: const Center(
                                child: Text("Baby Rhythm", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              )),
                        ),
                        const SizedBox(height: 30,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("/sleep");
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ]
                                  )
                              ),
                              child: const Center(
                                child: Text("Sleep Music", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              )),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        const SizedBox(height: 80,),
                        Center(
                          child: Text(
                            'Search Your Songs',
                            style: GoogleFonts.bebasNeue(
                                fontSize: 52,
                                color: Colors.black45
                            ),
                          ),
                        ),

                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed("/search");
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ]
                                  )
                              ),
                              child: const Center(
                                child: Text("Search Music", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              )
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 80,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed("/spotify");
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/music/spotify.png',
                                height: 75,
                              ),
                              const Text("Spotify", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed("/saavan");
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/music/saavan.png',
                                height: 75,
                              ),
                              const Text("Saavan", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                              ],
                          ),
                        ) ,
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed("/gaana");
                          },
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/music/gaana.png',
                                height: 75,
                              ),
                              const Text("Gaana", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}