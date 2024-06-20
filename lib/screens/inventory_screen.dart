import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      final newItem = {
        'id': DateTime.now().toString(), // Generate unique ID
        'name': _nameController.text,
        'description': _descriptionController.text,
        'price': double.parse(_priceController.text),
        'category': _categoryController.text,
        'image': _imageController.text,
        'rating': 0.0,
        'isRecommended': false,
        'isBestSeller': false,
      };

      final url = Uri.parse('http://localhost:3000/api/items');
      try {
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(newItem),
        );
        if (response.statusCode == 201) {
          // If the server returns an OK response, display a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product added successfully!')),
          );
          _nameController.clear();
          _descriptionController.clear();
          _priceController.clear();
          _categoryController.clear();
          _imageController.clear();
        } else {
          // If the server returns an error response, display an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add product!')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventaris'),
        backgroundColor: Colors.brown,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Input Inventaris',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Warna teks hitam
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                style: TextStyle(color: Colors.black), // Warna teks hitam
                decoration: InputDecoration(
                  labelText: 'Nama Produk',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black), // Warna teks hitam
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan nama produk';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                style: TextStyle(color: Colors.black), // Warna teks hitam
                decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black), // Warna teks hitam
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan deskripsi produk';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                style: TextStyle(color: Colors.black), // Warna teks hitam
                decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(),
                  prefixText: 'Rp ',
                  labelStyle: TextStyle(color: Colors.black), // Warna teks hitam
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan harga produk';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _categoryController,
                style: TextStyle(color: Colors.black), // Warna teks hitam
                decoration: InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black), // Warna teks hitam
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan kategori produk';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: _imageController,
                style: TextStyle(color: Colors.black), // Warna teks hitam
                decoration: InputDecoration(
                  labelText: 'URL Gambar',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: Colors.black), // Warna teks hitam
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan URL gambar produk';
                  }
                  return null;
                },
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _addProduct,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.brown), // Warna latar belakang coklat
                ),
                child: Text(
                  'Simpan',
                  style: TextStyle(color: Colors.white), // Warna teks putih
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
