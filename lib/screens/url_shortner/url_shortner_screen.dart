import 'package:code_test/screens/url_shortner/widgets/recently_shortened_urls.dart';
import 'package:code_test/screens/url_shortner/widgets/search_bar.dart';
import 'package:code_test/style.dart';
import 'package:flutter/material.dart';

class UrlShortenerScreen extends StatelessWidget {
  const UrlShortenerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Url Shortener'),
      ),
      body: Column(
        children: const [
          SizedBox(
            height: 30,
          ),
          SearchBar(),
          SizedBox(
            height: 34,
          ),
          Expanded(child: RecentlyShortenedUrls()),
        ],
      ),
    );
  }
}
