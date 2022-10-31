import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const url = "https://www.youtube.com/results?search_query=baby+rhythm";

class RoomMusic extends StatelessWidget {
  const RoomMusic({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        "/": (_) => const Home(),
        "/webview": (_) => const WebviewScaffold(
          url: url,
          withJavascript: true,
          withLocalStorage: true,
          withZoom: true,
        )
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed("/webview");
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
                        Navigator.of(context).pushNamed("/webview");
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
              )
            ],
          ),
        )
    );
  }
}