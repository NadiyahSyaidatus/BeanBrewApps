// notifikasi_screen.dart
import 'package:flutter/material.dart';
import 'package:beanbrewapps/screens/respon_dukungan_screen.dart';

class NotifikasiScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifikasi'),
        backgroundColor: Colors.brown,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          ListTile(
            title: Text('Customer Service'),
            subtitle: Text('Terimakasih telah memberikan pertanyaan/keluhan. Berikut adalah respon dukungan dari pertanyaan/keluhan teman-teman!'),
            leading: Icon(Icons.chat_bubble),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResponDukunganScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
