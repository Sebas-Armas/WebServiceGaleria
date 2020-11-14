import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File _imageFile; //imagen seleccionada de galería
  File _imageFileCamera; //imagen tomada de camara
  File _videoFile; //video seleccionado de galería
  VideoPlayerController _controller;
  File _videoFileCamera; //video grabado de camara

  void _pickImageFromGallery() async {
    var picture = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _imageFile = File(picture.path);
    });
  }

  void _openCamera() async {
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    if (picture != null && picture.path != null) {
      GallerySaver.saveImage(picture.path);
    }
    setState(() {
      _imageFileCamera = File(picture.path);
    });
  }

  void _pickVideoFromGallery() async {
    var video = await ImagePicker().getVideo(source: ImageSource.gallery);
    _videoFile = File(video.path);
    _controller = VideoPlayerController.file(_videoFile)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  void _openVideo() async {
    var video = await ImagePicker().getVideo(source: ImageSource.camera);
    if (video != null && video.path != null) {
      GallerySaver.saveVideo(video.path);
    }
    setState(() {
      _videoFileCamera = File(video.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cámara"),
      ),
      body: Center(
          child: ListView(padding: const EdgeInsets.all(8), children: <Widget>[
            if (_imageFile != null)
              Image.file(_imageFile)
            else
              Text(
                "Click en Elige una Imagen para seleccionar una imagen",
                style: TextStyle(fontSize: 16.0),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 8, 60, 8),
              child: RaisedButton(
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  color: Colors.blue,
                  child: Text("Elige una Imagen de Galería")),
            ),
            Text(
              "Click en Toma una Foto para Abrir Cámara",
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 60, 8),
              child: RaisedButton(
                onPressed: () {
                  _openCamera();
                },
                color: Colors.blue,
                child: Text("Toma una Foto"),
              ),
            ),
            if (_videoFile != null)
              _controller.value.initialized
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
                  : Container()
            else
              Text("Click en Elige un Video para seleccionar un video",
                  style: TextStyle(fontSize: 16.0)),
            Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 60, 8),
              child: RaisedButton(
                onPressed: () {
                  _pickVideoFromGallery();
                },
                color: Colors.blue,
                child: Text("Elige un Video de Galería"),
              ),
            ),
            Text(
              "Click en Graba un Video para Abrir Cámara",
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(60, 0, 60, 8),
              child: RaisedButton(
                onPressed: () {
                  _openVideo();
                },
                color: Colors.blue,
                child: Text("Graba un Video"),
              ),
            ),
          ])),
    );
  }
}