import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CapturePhotoPage extends StatefulWidget {
  const CapturePhotoPage({Key? key}) : super(key: key);

  @override
  State<CapturePhotoPage> createState() => _CapturePhotoPageState();
}

class _CapturePhotoPageState extends State<CapturePhotoPage> {
  late CameraDescription camera;
  late CameraController controller;
  bool _isInited = false;
  String? _imagePath;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      final cameras = await availableCameras();
      print(cameras);
      // setState(() {});
      controller = CameraController(cameras[0], ResolutionPreset.medium);
      controller.initialize().then((value) => {
            setState(() {
              _isInited = true;
            })
          });
      controller.setFlashMode(FlashMode.auto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _imagePath == null
          ? Container(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: _isInited
                        ? AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: CameraPreview(controller),
                          )
                        : Container(),
                  ),
                ],
              ),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: Image.file(File(_imagePath!)),
              )),
      floatingActionButton: _imagePath == null
          ? FloatingActionButton(
              backgroundColor: Colors.black,
              heroTag: 'camera',
              child: Icon(Icons.camera),
              onPressed: () async {
                await controller.takePicture().then((res) => {
                      setState(() {
                        _imagePath = res.path;
                      })
                    });
              },
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  heroTag: 'clear',
                  backgroundColor: Colors.black,
                  child: Icon(Icons.close),
                  onPressed: () async {
                    setState(() {
                      _imagePath = null;
                    });
                  },
                ),
                FloatingActionButton(
                  heroTag: 'done',
                  child: Icon(Icons.done),
                  onPressed: () async {
                    Navigator.pop(context, _imagePath);
                  },
                )
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
