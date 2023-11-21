import 'package:flutter/material.dart';
import 'package:weather/main.dart';
import 'api_call.dart';

class LocationChange extends StatefulWidget {
  Function(ThemeMode)? themeData;
  LocationChange({super.key, required this.themeData});

  @override
  State<LocationChange> createState() => _LocationChangeState();
}

class _LocationChangeState extends State<LocationChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Location Change",
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate(themeData: widget.themeData));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> locations = cities;
  Function(ThemeMode)? themeData;
  CustomSearchDelegate({required this.themeData});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in locations) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        themeData: themeData,
                      )),
            );
          },
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in locations) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        location: result,
                        themeData: themeData,
                      )),
            );
          },
          title: Text(result),
        );
      },
    );
  }
}
