import 'dart:async';
import 'dart:isolate';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sentry/sentry.dart';
import './pages/Home.dart';
import './utils/Routes.dart';


final SentryClient _sentry = new SentryClient(dsn: "http://b678d33cca0d41c48257309a81f27058@106.12.86.67:9000/4");

Future<Null> _reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');
  print('Reporting to Sentry.io...');

  final SentryResponse response = await _sentry.captureException(
    exception: error,
    stackTrace: stackTrace,
  );

  if (response.isSuccessful) {
    print('Success! Event ID: ${response.eventId}');
  } else {
    print('Failed to report to Sentry.io: ${response.error}');
  }
}

dynamic main() async {
  ///初始化并配置路由
  final router = new Router();
  Routes.configureRoutes(router);

  FlutterError.onError = (FlutterErrorDetails details) async {
    print('FlutterError.onError caught an error');
    await _reportError(details.exception, details.stack);
  };

  Isolate.current.addErrorListener(new RawReceivePort((dynamic pair) async {
    print('Isolate.current.addErrorListener caught an error');
    await _reportError(
      (pair as List<String>).first,
      (pair as List<String>).last,
    );
  }).sendPort);
  runZoned<Future<Null>>(() async {
    runApp(Home(
      onGenerateRoute: Routes.router.generator
    ));
  }, onError: (error, stackTrace) async {
    print('Zone caught an error');
    await _reportError(error, stackTrace);
  });
}
// void main() => runApp(Home());
