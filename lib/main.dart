import 'package:ebook_store/pages/bloc/ebook_store_bloc.dart';
import 'package:ebook_store/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => EbookStoreBloc(),
    child: const MaterialApp(
      home: MainPage(),
    ),
  ));
}
