import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'dart:io';


void main() {
  runApp(MaterialApp(
      home: UnityDemoScreen()
  ));
}

class UnityDemoScreen extends StatefulWidget {

  UnityDemoScreen({Key? key}) : super(key: key);

  @override
  _UnityDemoScreenState createState() => _UnityDemoScreenState();
}

class _UnityDemoScreenState extends State<UnityDemoScreen>{
  static final GlobalKey<ScaffoldState> _scaffoldKey =
  GlobalKey<ScaffoldState>();
  late UnityWidgetController _unityWidgetController;

  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              color: Colors.transparent,
              child: UnityWidget(
                onUnityCreated: onUnityCreated,
              ),
            ),
            Positioned(width: 100, height: 100, left: 0, top: 100, child: TextButton(child: Text('test', style: TextStyle(color: Colors.black),), onPressed: () async {
              setTexture();
              // var systemTempDir = Directory.systemTemp.parent.path;
              // var test = File(systemTempDir.toString() + '/1.fbx');
              // print(test.readAsString());
            },))
          ],
        ),
      ),
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
    addModel();
  }

  void addModel() {
    var systemTempDir = Directory.systemTemp.parent.path;
    var test = File(systemTempDir.toString() + '/1.fbx');
    print(test.readAsString());
    _unityWidgetController.postMessage(
      'AR Session Origin',
      'LoadModel',
      systemTempDir.toString() + '/1.fbx',
    );
    _unityWidgetController.postMessage(
        'AR Session Origin',
        'ModelTexture',
        systemTempDir.toString() + '/textures/1.jpeg' + ', ' +
              systemTempDir.toString() + '/textures/2.jpeg' + ', ' +
              systemTempDir.toString() + '/textures/3.jpeg'
    );
  }
  void setTexture() {
    var systemTempDir = Directory.systemTemp.parent.path;
    _unityWidgetController.postMessage(
        'AR Session Origin',
        'LoadTexture',
        systemTempDir.toString() + '/textures/1.png' + ', ' +
            systemTempDir.toString() + '/textures/2.jpeg' + ', ' +
            systemTempDir.toString() + '/textures/3.jpeg'
    );
  }
}