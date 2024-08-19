import 'package:flutter/material.dart';
import 'package:sertifikasi_jmp_final/transaksi_page.dart';

class DetailPage extends StatelessWidget {
  final Map<String, String> item;

  DetailPage({required this.item});

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

  @override
  Widget build(BuildContext context) {
    // Mengonversi harga dari String ke double
    final double harga = double.parse(item['harga']!);

    return Scaffold(
      appBar: AppBar(
        title: Text(item['nama']!),
        backgroundColor: Colors.amber[300],
      ),
      body: Stack(
        children: [
          // Konten yang dapat di-scroll
          SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200, // Atur tinggi gambar sesuai kebutuhan
                  child: Image.network(
                    item['gambar']!,
                    fit: BoxFit.fill,
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  item['nama']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  formatCurrency(harga),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Deskripsi",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  item['deskripsi']!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 80), // Space for the button
              ],
            ),
          ),
          // Tombol yang selalu berada di bawah
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransaksiPage(
                        items: {
                          "gambar": item['gambar']!,
                          "nama": item['nama']!,
                          "deskripsi": item['deskripsi']!,
                          "harga": harga.toString(), // Kirim harga sebagai String
                        },
                      ),
                    ),
                  );
                },
                child: Text("Beli Sekarang", style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[300],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
