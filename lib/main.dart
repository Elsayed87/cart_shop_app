import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore_app/bloc/products/bloc/store_bloc.dart';
import 'package:mystore_app/bloc/products/bloc/store_event.dart';
import 'package:mystore_app/screens/home_screen.dart';

void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  BlocProvider<StoreBloc>(
        create: (context) => StoreBloc()..add(StroreProductsRequsted()),
        child: const HomePage(),
      ),
    );
  }
}
