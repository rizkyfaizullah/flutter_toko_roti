import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sensors_plus/sensors_plus.dart';

class SensorPage extends StatefulWidget {
  const SensorPage({super.key});

  @override
  State<SensorPage> createState() => _SensorPageState();
}

class _SensorPageState extends State<SensorPage> {
  double x = 0.0, y = 0.0, z = 0.0;
  final storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });

    // Menyimpan token rahasia ketika aplikasi dijalankan
    saveSecureToken();
  }

  Future<void> saveSecureToken() async {
    await storage.write(key: 'secureToken', value: 'Token Super Rahasia');
  }

  Future<String?> readSecureToken() async {
    return await storage.read(key: 'secureToken');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sensor & Secure Storage'),
        backgroundColor: Colors.deepPurpleAccent[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Accelerometer:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'X: ${x.toStringAsFixed(2)}\nY: ${y.toStringAsFixed(2)}\nZ: ${z.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                String? token = await readSecureToken();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Token Rahasia'),
                    content: Text(token ?? 'Tidak ada token'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Baca Token Rahasia'),
            ),
          ],
        ),
      ),
    );
  }
}