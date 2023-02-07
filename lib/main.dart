import 'dart:ui';

import 'package:alex/finalmissiondialog.dart';
import 'package:alex/socialcreditdialog.dart';
import 'package:alex/videodialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gave',
      theme: ThemeData(
        canvasColor: Color.fromARGB(255, 56, 56, 56),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Alex\'s gave'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  bool startBox = false;
  bool videoCompleted = false;
  bool trollCompleted = false;
  bool socialCompleted = false;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: startBox == false
            ? Column(
                children: [
                  Text(
                      "OBS: Hjemmesiden er blevet lavet til at være på pc så du kan ikke gøre det på din mobil :/",
                      style: TextStyle(fontSize: 30, color: Colors.white)),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green),
                    child: TextButton(
                        onPressed: (() => setState(() {
                              startBox = true;
                            })),
                        child: Text(
                          "Okay",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        )),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: videoCompleted == false
                            ? Colors.green
                            : Colors.green.shade300),
                    height: 100,
                    width: 500,
                    child: videoCompleted == false
                        ? TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                            onPressed: () {
                              setState((() {
                                videoCompleted = true;
                              }));

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const VideoScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Video instruction",
                              style: TextStyle(fontSize: 30),
                            ))
                        : Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Video instruction",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.grey.shade200),
                                ),
                                Icon(
                                  Icons.check,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: trollCompleted == false
                            ? Colors.green
                            : Colors.green.shade300),
                    height: 100,
                    width: 500,
                    child: trollCompleted == false
                        ? TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (videoCompleted == false) {
                                const snackBar = SnackBar(
                                  content: Text(
                                      'Du skal lave Video instruction inden du kan spille budget Osu!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                return;
                              }
                              setState((() {
                                trollCompleted = true;
                              }));

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FinalMissionScreem(),
                                ),
                              );
                            },
                            child: Text(
                              "Budget Osu!",
                              style: TextStyle(fontSize: 30),
                            ))
                        : Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Budget Osu!",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.grey.shade200),
                                ),
                                Icon(
                                  Icons.check,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: socialCompleted == false
                            ? Colors.green
                            : Colors.green.shade300),
                    height: 100,
                    width: 500,
                    child: socialCompleted == false
                        ? TextButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStatePropertyAll<Color>(Colors.black),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (videoCompleted == false &&
                                  trollCompleted == false) {
                                const snackBar = SnackBar(
                                  content: Text(
                                      'Du skal lave video instruction and Budget osu! inden du kan samle social credits ind'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                return;
                              }
                              setState((() {
                                socialCompleted = true;
                              }));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SocialCreditScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Social Credit mission",
                              style: TextStyle(fontSize: 30),
                            ))
                        : Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Social Credit mission",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.grey.shade200),
                                ),
                                Icon(
                                  Icons.check,
                                  size: 40,
                                )
                              ],
                            ),
                          ),
                  ),
                  videoCompleted == true &&
                          trollCompleted == true &&
                          socialCompleted == true
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green.shade300),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Skriv denne kode til Jesper: 'JegErEnAbe4Real' for at aktiver din gave",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 30),
                              ),
                              Image(image: AssetImage("assets/card.png"))
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
      ),
    );
  }
}
