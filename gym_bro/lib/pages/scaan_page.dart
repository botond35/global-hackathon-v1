import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> _cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    _cameras = await availableCameras();
  } catch (e) {
    _cameras = [];
  }

  runApp(const ScaanPage());
}

class ScaanPage extends StatefulWidget {
  const ScaanPage({super.key});

  @override
  State<ScaanPage> createState() => _ScaanPage();
}

class _ScaanPage extends State<ScaanPage> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    if (_cameras.isNotEmpty) {
      controller = CameraController(_cameras[0], ResolutionPreset.medium);
      controller!
          .initialize()
          .then((_) {
            if (!mounted) return;
            setState(() {});
          })
          .catchError((Object e) {
            debugPrint('Camera error: $e');
          });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (!mounted || controller == null || !controller!.value.isInitialized)
      // ignore: curly_braces_in_flow_control_structures
      return;

    try {
      final XFile file = await controller!.takePicture();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('the photo is saved ${file.name}')),
      );
    } catch (e) {
      debugPrint('Error while taking the photo $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCameraReady = controller != null && controller!.value.isInitialized;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Scann your food"),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 400,
                  height: 400,
                  color: Colors.grey[800],
                  child: isCameraReady
                      ? CameraPreview(controller!)
                      : const Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white38,
                            size: 60,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 30),

              GestureDetector(
                onTap: _takePicture,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black26, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
