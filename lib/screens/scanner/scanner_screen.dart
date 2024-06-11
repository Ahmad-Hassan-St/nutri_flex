import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter_tflite/flutter_tflite.dart';
import '../../constants/foodNutrients.dart';
import 'scanner_cliper.dart';

class ScannerScreen extends StatefulWidget {
  final CameraDescription camera;

  ScannerScreen({required this.camera});

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen>
    with SingleTickerProviderStateMixin {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isScanning = false;
  bool _showError = false;
  bool _flashOn = false;
  late AnimationController _animationController;
  String _scanResult = "";
  XFile? _capturedImage;



  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    initTflite();
  }

  initTflite() async {
    await Tflite.loadModel(
      model: 'assets/ai_model/modelM.tflite',
      labels: 'assets/ai_model/labelsM.txt',
      isAsset: true,
      numThreads: 1,
    );
  }
  Future<void> _takePicture() async {
    setState(() {
      _isScanning = true;
      _showError = false;
      _scanResult = "";
      _capturedImage = null;
    });

    await _initializeControllerFuture;

    try {
      _capturedImage = await _controller.takePicture();

      var recognitions = await Tflite.runModelOnImage(
        path: _capturedImage!.path,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 1,
        threshold: 0.4,
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        setState(() {
          _scanResult = recognitions.first["label"];
          _isScanning = false;
          _animationController.stop();
        });

      } else {
        setState(() {
          _showError = true;
          _isScanning = false;

          _animationController.stop();
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _showError = true;
        _isScanning = false;

        _animationController.stop();
      });
    }
  }

  void _toggleFlash() async {
    if (_flashOn) {
      await _controller.setFlashMode(FlashMode.off);
    } else {
      await _controller.setFlashMode(FlashMode.torch);
    }
    setState(() {
      _flashOn = !_flashOn;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _capturedImage == null
              ? FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
              : Image.file(File(_capturedImage!.path)),
          ClipPath(
            clipper: ScannerClipper(),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          ScannerOverlay(animation: _animationController),
          if (_showError)
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning, color: Colors.yellow),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Object not found\nplace your food inside the frame',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (_scanResult.isNotEmpty)
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check, color: Colors.green),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Detected: $_scanResult',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    if (foodNutrients.containsKey(_scanResult.toLowerCase())) ...[
                      Text('KCal: ${foodNutrients[_scanResult.toLowerCase()]?['kcal'] ?? 'Unknown'}'),
                      Text('Fat: ${foodNutrients[_scanResult.toLowerCase()]?['fat'] ?? 'Unknown'} g'),
                      Text('Carbs: ${foodNutrients[_scanResult.toLowerCase()]?['carbs'] ?? 'Unknown'} g'),
                      Text('Protein: ${foodNutrients[_scanResult.toLowerCase()]?['protein'] ?? 'Unknown'} g'),
                    ] else ...[
                      Text('Nutritional information not available'),
                    ]
                  ],
                ),
              ),
            ),
          Positioned(
            top: 32,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.white,
            ),
          ),
          Positioned(
            top: 32,
            right: 16,
            child: IconButton(
              icon: Icon(
                _flashOn ? Icons.flash_on : Icons.flash_off,
                color: Colors.white,
              ),
              onPressed: _toggleFlash,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isScanning ? null : _takePicture,
        child: const Icon(
          Icons.camera,
        ),
      ),
    );
  }
}
