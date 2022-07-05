import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  late final Timer _timer;
  int _count = 0;
  bool _active = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(_active){
        setState(() {
          _count++;
        });
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
    _timer.cancel();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.resumed) {
      _active = true;
      print("resumed $state");
    } else if(state == AppLifecycleState.inactive) {
      _active = false;
      print("inactive $state");
    } else if(state == AppLifecycleState.detached) {
      _active = false;
      print("detached $state");
    } else if(state == AppLifecycleState.paused) {
      _active = false;
      print("paused $state");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppLifeCycle'),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(_count.toString(),style: const TextStyle(fontSize: 57.0,color: Colors.black),))
        ],
      ),
    );
  }
}
