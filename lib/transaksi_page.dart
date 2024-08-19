import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sertifikasi_jmp_final/toko_page.dart';
import 'map_page.dart';

class TransaksiPage extends StatefulWidget {
  final Map<String, String> items;

  TransaksiPage({required this.items});

  @override
  _TransaksiPageState createState() => _TransaksiPageState();
}

class _TransaksiPageState extends State<TransaksiPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  LatLng? _pickedLocation;

  String formatCurrency(double amount) {
    String amountStr = amount.toStringAsFixed(0);
    String reversedAmountStr = amountStr.split('').reversed.join();
    String formattedReversedAmount = '';
    for (int i = 0; i < reversedAmountStr.length; i++) {
      if (i > 0 && i % 3 == 0) {
        formattedReversedAmount += '.';
      }
      formattedReversedAmount += reversedAmountStr[i];
    }
    return 'Rp ${formattedReversedAmount.split('').reversed.join()}';
  }

  Future<void> _sendTransactionData() async {
    String url = "http://192.168.72.153/kuliah/sertifikasi_jmp/connection.php";

    final response = await http.post(
      Uri.parse(url),
      body: {
        'nama_lengkap': nameController.text,
        'alamat': addressController.text,
        'nomor_telepon': phoneController.text,
        'latitude': _pickedLocation?.latitude.toString(),
        'longitude': _pickedLocation?.longitude.toString(),
        'nama_barang': widget.items['nama']!,
        'deskripsi_barang': widget.items['deskripsi']!,
        'harga_barang': double.parse(widget.items['harga']!).toString()
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pembelian berhasil')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => TokoPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal melakukan pembelian')),
      );
    }
  }

  Future<void> _showConfirmationDialog() async {
    final double harga = double.parse(widget.items['harga']!);
    final String formattedHarga = formatCurrency(harga);

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Data Pembelian', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.grey[50],
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Nama: ${nameController.text}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 2),
                Text('Alamat: ${addressController.text}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 2),
                Text('Nomor Telepon: ${phoneController.text}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 2),
                Text( 'Lokasi: ${_pickedLocation?.latitude}, ${_pickedLocation?.longitude}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 2),
                Text('Item: ${widget.items['nama']}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 2),
                Text('Harga: $formattedHarga', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Konfirmasi', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
                _sendTransactionData();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Format harga untuk ditampilkan di UI
    final double harga = double.tryParse(widget.items['harga'] ?? '0.0') ?? 0.0;
    final String formattedHarga = formatCurrency(harga);

    return Scaffold(
      appBar: AppBar(
        title: Text("Transaksi ${widget.items['nama']}"),
        backgroundColor: Colors.amber[300],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Nama Lengkap",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: "Alamat",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Nomor Telepon",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(_pickedLocation == null
                  ? "Pilih Alamat Pengiriman"
                  : "Lokasi dipilih: ${_pickedLocation!.latitude}, ${_pickedLocation!.longitude}"),
              trailing: Icon(Icons.map),
              onTap: () async {
                LatLng? location = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapPage(),
                  ),
                );
                if (location != null) {
                  setState(() {
                    _pickedLocation = location;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              'Harga: $formattedHarga',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_pickedLocation != null &&
                      nameController.text.isNotEmpty &&
                      addressController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty) {
                    _showConfirmationDialog();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Lengkapi semua data transaksi')),
                    );
                  }
                },
                child: Text("Konfirmasi Pembelian", style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[300],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
