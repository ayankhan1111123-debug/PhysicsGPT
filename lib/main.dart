import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/navigation/screens/main_navigation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(const PhysicsGPT());
}

class PhysicsGPT extends StatefulWidget {
  const PhysicsGPT({super.key});

  @override
  State<PhysicsGPT> createState() => _PhysicsGPTState();
}

class _PhysicsGPTState extends State<PhysicsGPT> {
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    _themeProvider.addListener(_updateTheme);
  }

  void _updateTheme() {
    setState(() {});
  }

  @override
  void dispose() {
    _themeProvider.removeListener(_updateTheme);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhysicsGPT',

      theme: AppTheme.darkTheme,
darkTheme: AppTheme.darkTheme,
themeMode: ThemeMode.dark,

      home: const MainNavigation(),
    );
  }
}