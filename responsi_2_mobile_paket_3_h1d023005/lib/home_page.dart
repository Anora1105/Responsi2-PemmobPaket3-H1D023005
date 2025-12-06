import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'add_edit_page.dart'; // File ini akan kita buat setelah ini
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listdata = [];
  bool _isloading = true;

  // Fungsi Ambil Data (Read)
  Future<void> _getdata() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2/responsi_api/read.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data['data'];
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // Fungsi Hapus Data (Delete)
  Future<void> _deleteData(String id) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/responsi_api/delete.php'),
        body: {"id": id},
      );
      final data = jsonDecode(response.body);
      if (data['is_success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil dihapus')),
        );
        _getdata(); 
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Buku Ariza'), // Ganti nama tokomu
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => const LoginPage())
              );
            },
          )
        ],
      ),
      // Tombol Tambah Data
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // Pindah ke halaman Tambah, tunggu sampai kembali untuk refresh
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditPage()),
          );
          _getdata();
        },
      ),
      body: _isloading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      _listdata[index]['judul'], 
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Penulis: ${_listdata[index]['penulis']}"),
                        Text("Harga: Rp ${_listdata[index]['harga']}"),
                        Text("Stok: ${_listdata[index]['jumlah']}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Tombol Edit (Pensil)
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                             await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditPage(
                                  listData: {
                                    "id": _listdata[index]['id'],
                                    "judul": _listdata[index]['judul'],
                                    "harga": _listdata[index]['harga'],
                                    "jumlah": _listdata[index]['jumlah'],
                                    "tanggal_masuk": _listdata[index]['tanggal_masuk'],
                                    "volume": _listdata[index]['volume'],
                                    "penulis": _listdata[index]['penulis'],
                                    "penerbit": _listdata[index]['penerbit'],
                                  },
                                ),
                              ),
                            );
                            _getdata();
                          },
                        ),
                        // Tombol Hapus (Sampah)
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context, 
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Hapus Buku?'),
                                  content: const Text('Yakin ingin menghapus data ini?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context), 
                                      child: const Text('Batal')
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        _deleteData(_listdata[index]['id']);
                                        Navigator.pop(context);
                                      }, 
                                      child: const Text('Hapus')
                                    ),
                                  ],
                                );
                              }
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}