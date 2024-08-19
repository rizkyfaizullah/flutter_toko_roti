import 'package:flutter/material.dart';
import 'package:sertifikasi_jmp_final/detail_page.dart';
import 'package:sertifikasi_jmp_final/sensor_page.dart';

class TokoPage extends StatelessWidget {
  TokoPage({super.key});

  final List<Map<String, dynamic>> items = [
    {
      "gambar": "https://izkey.com/wp-content/uploads/2017/09/Aneka-Roti-Basah-768x371.jpg",
      "nama": "Roti Basah",
      "deskripsi": "Nikmati kelezatan Roti Basah kami, pilihan ideal untuk Anda yang menyukai tekstur lembut dan rasa yang penuh kelembutan. Roti ini dirancang untuk menjadi pilihan lezat, baik untuk sarapan pagi atau sebagai camilan sore. Terbuat dari bahan berkualitas tinggi dan melalui proses yang hati-hati, Roti Basah kami memberikan rasa autentik dengan sedikit kelembapan, menjadikannya sempurna untuk disajikan dengan selai favorit Anda atau dinikmati begitu saja. Meskipun sudah tidak segar seperti roti baru, rasanya tetap memuaskan dan cocok untuk berbagai keperluan. Cocok untuk Anda yang mencari pengalaman makan yang lebih santai dan nikmat.",
      "harga": 20000.00,
    },
    {
      "gambar": "https://www.myraga.com.my/wp-content/uploads/2020/11/Roti-putih.jpg",
      "nama": "Roti Tawar",
      "deskripsi": "Temukan kelezatan dan kelembutan dalam setiap gigitan Roti Tawar kami! Roti tawar ini adalah pilihan sempurna untuk Anda yang menyukai roti dengan tekstur lembut dan rasa netral. Ideal untuk berbagai hidangan, dari sandwich lezat hingga panggangan roti yang renyah. Dibuat dengan bahan berkualitas dan proses pemanggangan yang cermat, Roti Tawar kami memberikan rasa yang konsisten dan memuaskan di setiap irisan. Sempurna untuk sarapan cepat, bekal sekolah, atau makan siang yang praktis. Dengan kemasan segar dan siap dinikmati, Roti Tawar kami akan menjadi favorit di dapur Anda.",
      "harga": 12500.00,
    },
    {
      "gambar": "https://cf.shopee.co.id/file/sg-11134201-22120-lhmb5ns0c3kvf8",
      "nama": "Roti Kering",
      "deskripsi": "Roti Kering kami menawarkan krispi dan tekstur renyah yang sempurna untuk camilan ringan atau sebagai teman minum teh Anda. Dengan proses pengeringan yang tepat, roti ini kehilangan kelembapan dan menghadirkan sensasi kering yang memuaskan. Ideal untuk dijadikan kudapan sehari-hari atau dicelupkan dalam kopi dan teh. Nikmati kelezatan sederhana dari Roti Kering kami yang selalu segar dan enak.",
      "harga": 30000.00,
    },
    {
      "gambar": "https://izkey.com/wp-content/uploads/2017/09/Aneka-Roti-Basah-768x371.jpg",
      "nama": "Roti Basah Spesial",
      "deskripsi": "Rasakan kelembutan dan kelezatan Roti Basah Spesial kami yang merupakan pilihan terbaik untuk Anda yang mencari roti dengan tekstur lembut dan rasa yang unik. Roti ini dibuat dengan bahan berkualitas tinggi dan teknik khusus untuk menciptakan kelembapan yang pas, menjadikannya ideal untuk diolah menjadi berbagai hidangan lezat. Cocok untuk dijadikan menu sarapan atau camilan yang memanjakan lidah.",
      "harga": 25000.00,
    },
    {
      "gambar": "https://www.myraga.com.my/wp-content/uploads/2020/11/Roti-putih.jpg",
      "nama": "Roti Tawar Spesial",
      "deskripsi": "Roti Tawar Spesial kami menawarkan tekstur lembut yang tiada tara dan rasa yang sedikit berbeda dari roti tawar biasa. Dibuat dengan bahan premium dan proses pemanggangan yang cermat, roti ini sangat cocok untuk berbagai hidangan, termasuk sandwich gourmet dan panggangan roti. Dengan sentuhan spesial pada setiap irisan, Roti Tawar Spesial ini akan memberikan pengalaman makan yang lebih istimewa.",
      "harga": 17500.00,
    },
    {
      "gambar": "https://cf.shopee.co.id/file/sg-11134201-22120-lhmb5ns0c3kvf8",
      "nama": "Roti Kering Spesial",
      "deskripsi": "Roti Kering Spesial menghadirkan krispi dan rasa yang lebih kaya dibandingkan roti kering biasa. Dibuat dengan resep rahasia dan proses pengeringan khusus, roti ini memiliki tekstur yang sangat renyah dan cita rasa yang memikat. Ideal untuk camilan elegan atau disajikan sebagai pendamping minuman hangat. Nikmati keistimewaan dan kemewahan dari setiap gigitan Roti Kering Spesial kami.",
      "harga": 35000.00,
    },
  ];

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Toko Roti Semua Suka"),
        backgroundColor: Colors.amber[300],
        actions: [
          IconButton(
            icon: Icon(Icons.sensors),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SensorPage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Jumlah card per baris
            crossAxisSpacing: 10, // Spasi horizontal
            mainAxisSpacing: 10, // Spasi vertikal
            childAspectRatio: 0.75, // Ukuran card
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.grey[50],
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        item: {
                          "gambar": item['gambar']!,
                          "nama": item['nama']!,
                          "deskripsi": item['deskripsi']!,
                          "harga": item['harga'].toString(),
                        },
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        item['gambar']!,
                        fit: BoxFit.fill,
                        width: double.infinity,
                        height: 120,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['nama']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '${formatCurrency(item['harga'])}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    item: {
                                      "gambar": item['gambar']!,
                                      "nama": item['nama']!,
                                      "deskripsi": item['deskripsi']!,
                                      "harga": item['harga'].toString(),
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Text("Detail", style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber[300],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
