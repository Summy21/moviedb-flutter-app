import 'package:flutter/material.dart';

/// Detail screen for a movie or TV show.
/// Full implementation coming in next step.
class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.id,
    required this.isMovie,
  });

  final int id;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Detail')),
    );
  }
}