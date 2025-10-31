<<<<<<< HEAD
import 'package:flutter/material.dart';
// import 'package:mus3if/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mus3if/screens/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
=======
import 'package:flutter/material.dart' hide HomeScreen;
import 'package:mus3if/screens/home_screen.dart';
import 'package:mus3if/data/dummy_data.dart';
import 'package:mus3if/local_storage/contact_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final loadedContacts = await ContactStorage.loadContacts();

    if (loadedContacts.isEmpty) {
      contacts = List.from(defaultContacts);
      await ContactStorage.saveContacts(contacts);
    } else {
      contacts = loadedContacts;
    }
  } catch (e) {
    print('Error loading contacts: $e');
    contacts = List.from(defaultContacts);
  }

  runApp(const MyApp());
>>>>>>> 4f4eee8 (guide and profile tabs)
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

<<<<<<< HEAD
  // This widget is the root of your application.
=======
>>>>>>> 4f4eee8 (guide and profile tabs)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mus3if',
      theme: ThemeData(
<<<<<<< HEAD
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: LoginScreen(),

=======
        primaryColor: Color(0xFFDC2626),
        scaffoldBackgroundColor: Color(0xFFF8FAFC),
      ),
      home: HomeScreen(),
>>>>>>> 4f4eee8 (guide and profile tabs)
    );
  }
}
