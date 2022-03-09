import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'dart:io';
import 'package:meta/meta.dart';

extension Log on Object {
  void log() {
    devtools.log(toString());
  }
}

extension GetOnUri on Object {
  Future<HttpClientResponse> getUrl(
    String url,
  ) =>
      HttpClient()
          .getUrl(
            Uri.parse(url),
          )
          .then(
            (req) => req.close(),
          );
}

mixin CanMakeGetCall {
  String get url;
  @useResult
  Future<String> getString() => getUrl(url).then((
        resp,
      ) =>
          resp
              .transform(
                utf8.decoder,
              )
              .join());
}

@immutable
class GetPeople with CanMakeGetCall {
  const GetPeople();
  @override
  String get url => 'http://192.168.1.10:5500/apis/people.json';
}

void test() async {
  final people = await const GetPeople().getString();
  people.log();
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    test();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World'),
      ),
      body: const Center(
        child: Text('Hello World'),
      ),
    );
  }
}
