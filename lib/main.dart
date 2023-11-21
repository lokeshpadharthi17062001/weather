import 'package:flutter/material.dart';
import 'package:weather/location_change.dart';

import 'api_call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    void changeTheme(ThemeMode themeMode) {
      setState(() {
        _themeMode = themeMode;
      });
    }

    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: HomePage(
        themeData: changeTheme,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  String? location;
  Function(ThemeMode)? themeData;
  HomePage({super.key, this.location, required this.themeData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<dynamic>? futureWeather;

  @override
  void initState() {
    futureWeather = fetchWeather(
        Uri.parse("https://mocki.io/v1/60ffc94d-f3cb-470c-bfc4-85de670be2c7"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.themeData!(ThemeMode.light);
                  },
                  child: const Icon(Icons.light_mode),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      textStyle: const TextStyle(color: Colors.white)),
                  onPressed: () {
                    widget.themeData!(ThemeMode.dark);
                  },
                  child: const Icon(Icons.dark_mode),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FutureBuilder(
                    future: futureWeather,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: Text("Data Not Fetched...."));
                        }
                        if (snapshot.hasError) {
                          return const Center(
                              child: Text("Oops Something went wrong...."));
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              widget.location ?? snapshot.data[0]["location"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (widget.location == null)
                                  ? "${snapshot.data[0]['temp_in_celsius']} \u2103"
                                  : " ${snapshot.data[cities.indexOf("${widget.location}")]['temp_in_celsius']}\u2103",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(
                            // color: Colors.black,
                            ),
                      );
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocationChange(
                                    themeData: widget.themeData,
                                  )),
                        );
                      },
                      child: const Text("Change Location"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
