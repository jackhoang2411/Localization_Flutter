import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  // Static method to access the _MyAppState from other widgets
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  // Method to set the selected locale
  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.welcome)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.helloUser,
              style: const TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            createDropdownButton(context),
          ],
        ),
      ),
    );
  }

  DropdownButton<String> createDropdownButton(BuildContext context) {
    return DropdownButton<String>(
      value: AppLocalizations.of(context)!.localeName,
      onChanged: (value) {
        // Accessing the setLocale method from MyApp using the static of() method
        MyApp.of(context)!.setLocale(Locale.fromSubtags(languageCode: value!));
      },
      items: [
        DropdownMenuItem(
          value: 'en',
          child: Text(AppLocalizations.of(context)!.english),
        ),
        DropdownMenuItem(
          value: 'es',
          child: Text(AppLocalizations.of(context)!.spanish),
        ),
      ],
    );
  }
}
