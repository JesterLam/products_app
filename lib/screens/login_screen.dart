import 'package:flutter/material.dart';
import 'package:products_app/providers/login_form_provider.dart';
import 'package:products_app/ui/input_decorations.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
   
	const LoginScreen({Key? key}) : super(key: key);
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: AuthBackground( 
				child: SingleChildScrollView(
					child: Column(
						children: [
							const SizedBox(height : 220),
							CardContainer(
								child: Column(
									children: [
										const SizedBox( height: 10 ),
										Text( 'Login', style: Theme.of(context).textTheme.headline4 ),
										const SizedBox( height: 30 ),
										ChangeNotifierProvider(
											create: ( _ ) => LoginFormProvider(),
											child: const _LoginForm(),
										)
									],
								)
							),
							const SizedBox( height: 40 ),
							const Text('Create a new account', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold)),
              				const SizedBox( height: 40 ),
						],
					),
				),
			)
		);
	}
}


class _LoginForm extends StatelessWidget {
	const _LoginForm({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		final loginForm = Provider.of<LoginFormProvider>(context);

		return Container(
			child: Form(
				key: loginForm.formKey,
				autovalidateMode: AutovalidateMode.onUserInteraction,
				child: Column(
					children: [
						TextFormField(
							autocorrect: false,
							keyboardType: TextInputType.emailAddress,
							decoration: InputDecorations.authInputDecoration( 
								hintText: 'example@gmail.com',
								labelText: 'Email',
								prefixIcon: Icons.alternate_email_rounded
							),
							onChanged: ( value ) => loginForm.email = value,
							validator: ( value ) {
								String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
								RegExp regExp  = RegExp(pattern);
								return regExp.hasMatch(value ?? '') ? null : 'Invalid email';
							},
						),
						const SizedBox( height: 30),
						TextFormField(
							autocorrect: false,
							obscureText: true,
							keyboardType: TextInputType.emailAddress,
							decoration: InputDecorations.authInputDecoration(
								hintText: '******',
								labelText: 'Password',
								prefixIcon: Icons.lock_outline
							),
							onChanged: ( value ) => loginForm.password = value,
							validator: ( value ) {
								return ( value != null && value.length >= 6 ) ? null : 'Password must be 6 characters or more';
							},
						),
						const SizedBox( height: 30),
						MaterialButton(
							shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10)),
							disabledColor: Colors.grey,
							elevation: 0,
							color: Colors.deepPurple,
							child: Container(
								padding: const EdgeInsets.symmetric( horizontal: 90, vertical: 15),
								child: Text(
								loginForm.isLoading ? 'Wait' : 'Login',
								style: const TextStyle( color: Colors.white),
								),
							),
							onPressed: loginForm.isLoading ? null : () async {
								// Quite keyboard
								FocusScope.of(context).unfocus();
								if( !loginForm.isValidForm() ) return;
								
								loginForm.isLoading = true;
								await Future.delayed( const Duration(seconds: 2));
								loginForm.isLoading = true;

								Navigator.pushReplacementNamed(context, 'home');
							},
						)
					],
				),
			),
		);
	}
}