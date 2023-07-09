import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indagram/state/auth/providers/auth_state_provider.dart';
import 'package:indagram/state/auth/providers/is_logged_in_provider.dart';
import 'package:indagram/state/providers/is_loading_provider.dart';
import 'package:indagram/views/components/loading/loading_screen.dart';
import 'firebase_options.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
          indicatorColor: Colors.blueGrey),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(builder: ((context, ref, child) {
        // loading screen responsible
        ref.listen<bool>(
          isLoadingProvider,
          (_, isLoading) {
            if (isLoading) {
              LoadingScreen.instance().show(context: context);
            } else {
              LoadingScreen.instance().hide();
            }
          },
        );

        final isLoggedIn = ref.watch(isLoggedInProvider);
        if (isLoggedIn) {
          return const MainView();
        } else {
          return const LoginView();
        }
      })),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Instant-gram"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return TextButton(
            onPressed: () async {
              await ref.read(authStateProvider.notifier).logOut();
            },
            child: const Text('Logout'),
          );
        },
      ),
    );
  }
}

class LoginView extends ConsumerWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login View"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50, left: 15, right: 15),
            child: Text(
              'Welcome to Instant-gram!',
              style: TextStyle(
                  fontSize: 45,
                  color: Color.fromARGB(255, 165, 165, 165),
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 65,
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Log into your account using one of the options below.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(
            height: 17,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 60,
              child: TextButton(
                onPressed:
                    ref.read(authStateProvider.notifier).loginWithFacebook,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/1024px-Facebook_Logo_%282019%29.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Sign in with Facebook',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SizedBox(
              height: 60,
              child: TextButton(
                onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  )),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-icon-logo-png-transparent-svg-vector-bie-supply-14.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Sign in with Google',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 65,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, right: 20),
            child: Row(
              children: [
                Text("Don't have an account?"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
