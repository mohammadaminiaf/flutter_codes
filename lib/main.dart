import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registry/component_registry_initializer.dart';
import 'screens/screen_desktop_layout.dart';

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
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        ),
        home: const ScreenDesktopLayout(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
