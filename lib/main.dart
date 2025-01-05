import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/pages/main_page.dart';
import 'package:ebook_store/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EbookStoreBloc(),
      child: MaterialApp(
        title: "Ebook Store",
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.white,
          appBarTheme: const AppBarTheme(backgroundColor: AppColors.white),
        ),
        home: const MainPage(),
      ),
    );
  }
}
