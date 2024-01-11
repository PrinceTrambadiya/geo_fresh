import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geo_fresh/utils/colors.dart';
import 'package:image/image.dart' as IMG;
import 'package:intl/intl.dart' as i;
import 'package:path_provider/path_provider.dart';

class CameraWidget extends StatefulWidget {
  final CameraDescription camera;

  CameraWidget({@required this.camera});

  @override
  _CameraWidgetState createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();

    _cameraController =
        CameraController(widget.camera, ResolutionPreset.medium);

    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isLoading
          ? CircularProgressIndicator()
          : FloatingActionButton(
              child: Icon(Icons.camera),
              onPressed: () {
                isLoading = true;
                _takePicture(context);
                setState(() {});
              },
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(children: <Widget>[
        FutureBuilder(
          future: _initializeCameraControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ]),
    );
  }

  void _takePicture(BuildContext context) async {
    try {
      await _initializeCameraControllerFuture;
      // var path = (await getTemporaryDirectory()).path;
      // path = path + '${DateTime.now()}.png';

      XFile result = await _cameraController.takePicture();
      File file = await addTimeToImage(result);
      Navigator.pop(context, file);
    } catch (e) {
      print(e);
    }
  }

  Future<File> addTimeToImage(XFile xFile) async {
    DateTime now = DateTime.now();
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final TextPainter textPainterTime =
        TextPainter(textDirection: TextDirection.ltr);

    // http.Response imageBytes = await http.get(
    //     "https://www.pixel4k.com/wp-content/uploads/2019/07/colorful-skull-dark-art_1563222221.jpg");
    final Uint8List frameImageByte = await xFile.readAsBytes();

    ///Add image
    IMG.Image frameImage = IMG.decodeImage(frameImageByte);
    frameImage = IMG.copyRotate(frameImage, 90);
    final ui.Codec changeFrameImageCode =
        await ui.instantiateImageCodec(IMG.encodePng(frameImage));
    final ui.Image finalFrameImage =
        (await changeFrameImageCode.getNextFrame()).image;
    // final ui.Image finalFrameImage =
    //     (await frameImageCode.getNextFrame()).image;
    canvas.drawImage(finalFrameImage, Offset(0.0, 0.0), Paint());

    ///Draw Time
    textPainterTime.text = TextSpan(
      text:
          "${now.day} ${i.DateFormat.MMMM().format(now).substring(0, 3)} ${now.year} ${now.hour}:${now.minute}",
      style: TextStyle(
        fontSize: 20,
        color: redColor,
      ),
    );
    textPainterTime.textAlign = TextAlign.left;
    textPainterTime.layout();
    textPainterTime.paint(
      canvas,
      Offset((finalFrameImage.width - textPainterTime.width) - 10,
          (finalFrameImage.height - 25).toDouble()),
    );

    final image = await pictureRecorder
        .endRecording()
        .toImage(finalFrameImage.width, finalFrameImage.height);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    final path = (await getTemporaryDirectory()).path + "${DateTime.now()}.png";
    File(path).writeAsBytesSync(data.buffer.asUint8List());
    File file = File(path);
    return file;
    //debugPrint(path);
  }
}
