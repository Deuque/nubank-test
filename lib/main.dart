import 'package:code_test/bloc/create_alias_cubit.dart';
import 'package:code_test/bloc/recent_urls_cubit.dart';
import 'package:code_test/repository/alias_repository.dart';
import 'package:code_test/screens/url_shortner/url_shortner_screen.dart';
import 'package:code_test/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (_) => CreateAliasCubit(AliasRepository()),
        ),
        BlocProvider(
          create: (_) => RecentUrlsCubit(),
        )
      ], child: const UrlShortenerScreen()),
    );
  }
}
