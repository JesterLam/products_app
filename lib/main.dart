import 'package:flutter/material.dart';
import 'package:products_app/screens/home_screen.dart';
import 'package:products_app/screens/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
	const MyApp({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			title: 'Products App',
			initialRoute: 'home',
			routes: {
				'login': ( _ ) => const LoginScreen(),
				'home' : ( _ ) => const HomeScreen()
			},
			theme: ThemeData.light().copyWith(
				scaffoldBackgroundColor: Colors.grey[ 300 ]
			),
		);
	}
}