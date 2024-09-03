import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: "Touch screen app",
      home: TouchApp(),
    ),
  );
}

class TouchApp extends StatefulWidget {
  const TouchApp({super.key});

  @override
  State<TouchApp> createState() => _TouchAppState();
}

class _TouchAppState extends State<TouchApp> {
  late Offset? _tapPosition;
  double posY = 0.0;
  double posX = 0.0;
  double centerX = 0.0;
  double centerY = 0.0;

  @override
  void initState() {
    super.initState();
    // Ejecuta un método después de que la interfaz se haya creado.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final size = MediaQuery.of(context).size;
      centerX = size.width / 2;
      centerY = size.height / 2;
      await startAutomaticallyTouch();
    });
  }

  Future<void> touchScreenDown(int i) async {
    posY = i.toDouble();
    WidgetsBinding.instance.handlePointerEvent(PointerDownEvent(pointer: 0, position: Offset(centerX + posX, 100 + posY),)); 
    WidgetsBinding.instance.handlePointerEvent(PointerUpEvent(pointer: 0, position: Offset(centerX + posX, 100 + posY),));
  }

  Future<void> touchScreenRight(int i) async {
    posX = i.toDouble();
    WidgetsBinding.instance.handlePointerEvent(PointerDownEvent(pointer: 0, position: Offset(100 + posX, 100 + posY),)); 
    WidgetsBinding.instance.handlePointerEvent(PointerUpEvent(pointer: 0, position: Offset(100 + posX, 100 + posY),));
  }

  Future<void> touchScreenUp(int i) async {
    posY = i.toDouble();
    WidgetsBinding.instance.handlePointerEvent(PointerDownEvent(pointer: 0, position: Offset(100 + posX, 100 - posY),)); 
    WidgetsBinding.instance.handlePointerEvent(PointerUpEvent(pointer: 0, position: Offset(100 + posX, 100 - posY),));
  }

  Future<void> touchScreenLeft(int i) async {
    posX = i.toDouble();
    WidgetsBinding.instance.handlePointerEvent(PointerDownEvent(pointer: 0, position: Offset(100 - posX, 100 + posY),)); 
    WidgetsBinding.instance.handlePointerEvent(PointerUpEvent(pointer: 0, position: Offset(100 - posX, 100 + posY),));
  }

  Future<void> startAutomaticallyTouch() async {
    for(int i = 0; i < 100; i++){
      touchScreenDown(i);
      await Future.delayed(const Duration(seconds: 1));
    }
    for(int i = 0; i < 100; i++){
      touchScreenRight(i);
      await Future.delayed(const Duration(seconds: 1));
    }
    for(int i = 0; i < 100; i++){
      touchScreenUp(i);
      await Future.delayed(const Duration(seconds: 1));
    }
    for(int i = 0; i < 100; i++){
      touchScreenLeft(i);
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) {
          _tapPosition = details.localPosition;
        },
        child: Stack(
          children: [
            Container(
              color: Colors.blue[50],
              // child: const Center(child: Text('Toca en cualquier lugar')),
            ),
            if (_tapPosition != null)
              Positioned(
                left: _tapPosition!.dx,
                top: _tapPosition!.dy,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.red,
                  child: const Text(
                    'Etiqueta',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}