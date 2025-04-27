import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registry/component_registry_initializer.dart';
import 'screens/screen_home_new.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the component registry
  await ComponentRegistryInitializer.initialize();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter UI Components',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        ),
        home: const ScreenHomeNew(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
