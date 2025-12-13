/// Company: CETAM
/// Project: QParking
/// File: main.dart
/// Created on: 13/12/2025
/// Created by: Rodrigo Peña
/// Approved by: Gamaliel Juarez
///
/// Changelog:
/// - ID: 1 | Modified on: 13/12/2025 | Rodrigo Peña | Configured localization to force Spanish (ES) as default.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // [cite: 453]

// Imports Institucionales
import 'core/config/router/app_router.dart';
import 'core/theme/app_theme.dart';
// Importante: Importar las localizaciones generadas localmente (synthetic-package: false)
import 'l10n/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch router provider
    final appRouter = ref.watch(appRouterProvider);

    // Instanciar tema institucional
    final appTheme = AppTheme(isDarkMode: false);

    return MaterialApp.router(
      // Título interno (no visible en UI generalmente, pero requerido)
        onGenerateTitle: (context) => AppLocalizations.of(context)!.app_name,

        debugShowCheckedModeBanner: false,
      // Tema Institucional [cite: 199]
        theme: appTheme.getTheme(),

    // Configuración de Rutas
    routerConfig: appRouter,

    // --- CONFIGURACIÓN DE IDIOMA (OBLIGATORIO SECCIÓN 6.4) ---

    // 1. Forzar Español como idioma predeterminado de la UI
    locale: const Locale('es', ''),

    // 2. Idiomas soportados
    supportedLocales: const [
    Locale('es', ''), // Español
    Locale('en', ''), // Inglés (Requerido como fallback/template)
    ],

    // 3. Delegados de traducción (Sistema + App)
    localizationsDelegates: const [
    // Delegado generado por nuestra app
    AppLocalizations.delegate,
    // Textos base de Material (Ej: Botones de calendario, diálogos nativos)
    GlobalMaterialLocalizations.delegate,
    // Textos de widgets base
    GlobalWidgetsLocalizations.delegate,
    // Textos estilo iOS
    GlobalCupertinoLocalizations.delegate,
    ],
    );
  }
}