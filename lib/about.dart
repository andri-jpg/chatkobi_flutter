// ignore_for_file: deprecated_member_use

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
              'Chatkobi.AI',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'oxygen',
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'ChatKobi.AI adalah aplikasi chatbot kesehatan berbasis model GPT-2 yang menggunakan bahasa Indonesia. Aplikasi ini dirancang khusus untuk berjalan secara offline, memungkinkan pengguna untuk mendapatkan informasi dan saran kesehatan bahkan di wilayah yang minim sinyal internet. Model GPT-2 yang digunakan dalam proyek ini sangat ringan sehingga dapat dijalankan di berbagai perangkat, termasuk laptop dan ponsel dengan spesifikasi rendah. Dengan ChatKobi.AI, Anda dapat dengan mudah mengakses referensi medis tanpa perlu koneksi internet.',
              style: TextStyle(fontSize: 16.0,
              fontFamily: 'oxygen'),
            ),
          
            const SizedBox(height: 16.0),
            InkWell(
              child: const Text(
                'Chatkobi.AI',
                style: TextStyle(
                  fontSize: 18.0,
                  fontFamily: 'oxygen',
                  color: Colors.blue,
                ),
              ),
              onTap: () async {
                const url = 'https://github.com/andri-jpg/chatkobi.ai'; 
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
