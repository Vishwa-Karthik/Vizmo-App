import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vizmo_app/core/injection/injection.dart';
import 'package:vizmo_app/features/events/data/schema/event_schema.dart';
import 'package:vizmo_app/features/events/data/schema/vizmo_events_schema.dart';
import 'package:vizmo_app/features/events/presentation/pages/event_page.dart';
import 'package:vizmo_app/utils/app_constants.dart';
import 'package:vizmo_app/utils/app_themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Injection injection = Injection();
  injection.initialise();
  final documentsDir = await getApplicationDocumentsDirectory();
  Hive.init(documentsDir.path);

  Hive.registerAdapter(EventSchemaAdapter());
  Hive.registerAdapter(VizmoEventsSchemaAdapter());

  // Open boxes
  await Hive.openBox<VizmoEventsSchema>(AppConstants.vizmoEventsBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultTheme,
      home: const EventPage(),
    );
  }
}
