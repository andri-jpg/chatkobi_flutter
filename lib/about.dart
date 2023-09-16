import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Disclaimer',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'ChatKobi.AI adalah proyek sederhana dan tidak menggantikan konsultasi langsung dengan para profesional medis. Informasi yang diberikan oleh chatbot ini hanya sebagai referensi tambahan. Selalu konsultasikan dokter atau ahli kesehatan yang terpercaya untuk diagnosis dan pengobatan yang akurat terkait masalah kesehatan Anda.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Proyek ChatKobi.AI adalah proyek open-source dengan lisensi MIT. Oleh karena itu, penggunaan dan distribusi proyek ini tunduk pada ketentuan lisensi MIT yang tercantum dalam berkas LICENSE di repositori.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Dengan menggunakan ChatKobi.AI, Anda setuju untuk mematuhi semua ketentuan dan persyaratan lisensi MIT yang berlaku. Anda juga memahami bahwa penggunaan proyek ini adalah risiko Anda sendiri dan pengembang proyek ini tidak bertanggung jawab atas akibat yang mungkin timbul dari penggunaan proyek ini.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Dengan menggunakannya, Anda setuju untuk membebaskan pengembang proyek dari segala tuntutan, klaim, atau tanggung jawab yang mungkin muncul akibat penggunaan atau distribusi proyek ini. Anda setuju bahwa penggunaan proyek ini adalah sepenuhnya atas risiko Anda dan Anda bertanggung jawab untuk memahami dan mematuhi hukum serta etika terkait penggunaan proyek ini.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Penting untuk diingat bahwa ChatKobi.AI menggunakan teknologi model GPT-2 yang umumnya tidak digunakan untuk memberikan jawaban fakta atau informasi medis yang akurat. Model ini mungkin mengandung bias atau informasi yang tidak sepenuhnya valid.',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            InkWell(
              child: const Text(
                'Tentang Projek',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blue,
                ),
              ),
              onTap: () async {
                const url = 'https://github.com/andri-jpg/chatkobi.ai'; // Ganti URL sesuai dengan repositori GitHub Anda
                if (await canLaunch(url)) {
                  await launch(url);
                  } else {
                    throw 'Tidak dapat membuka tautan $url';
                    }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
