import 'package:flutter/material.dart';

class TopMoviesScreen extends StatefulWidget {
  const TopMoviesScreen({Key? key}) : super(key: key);

  static const String routeName = '/top-movies';

  @override
  _TopMoviesScreenState createState() => _TopMoviesScreenState();
}

class _TopMoviesScreenState extends State<TopMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Top Movies'),
      ),
    );
  }
}
