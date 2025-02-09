import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smollan_flutter/homepage.dart';
import 'package:smollan_flutter/util/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),  // Light theme
          darkTheme: ThemeData.dark(),  // Dark theme
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: Homepage(),
        );
      },
    );
  }
}
