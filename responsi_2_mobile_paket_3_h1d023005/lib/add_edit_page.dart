import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddEditPage extends StatefulWidget {
  // Jika ini null, berarti mode TAMBAH. Jika ada isinya, mode EDIT.
  final Map? listData;

  const AddEditPage({super.key, this.listData});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  // Controller untuk semua kolom input
  TextEditingController judulController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController volumeController = TextEditingController();
  TextEditingController penulisController = TextEditingController();
  TextEditingController penerbitController = TextEditingController();
  
  bool isEditMode = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Cek apakah ada data yang dikirim? (Mode Edit)
    if (widget.listData != null) {
      isEditMode = true;
      judulController.text = widget.listData!['judul'];
      hargaController.text = widget.listData!['harga'];
      jumlahController.text = widget.listData!['jumlah'];
      tanggalController.text = widget.listData!['tanggal_masuk'];
      volumeController.text = widget.listData!['volume'];
      penulisController.text = widget.listData!['penulis'];
      penerbitController.text = widget.listData!['penerbit'];
    }
  }

  Future<void> submitData() async {
    // Validasi sederhana: Judul tidak boleh kosong
    if (judulController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul buku wajib diisi!')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Tentukan URL: Mau Create atau Update?
      String url = isEditMode
          ? "http://10.0.2.2/responsi_api/update.php"
          : "http://10.0.2.2/responsi_api/create.php";

      // Siapkan data yang mau dikirim
      Map<String, String> bodyData = {
        "judul": judulController.text,
        "harga": hargaController.text,
        "jumlah": jumlahController.text,
        "tanggal_masuk": tanggalController.text,
        "volume": volumeController.text,
        "penulis": penulisController.text,
        "penerbit": penerbitController.text,
      };

      // Kalau Edit, wajib kirim ID
      if (isEditMode) {
        bodyData["id"] = widget.listData!['id'];
      }

      final response = await http.post(Uri.parse(url), body: bodyData);
      final data = jsonDecode(response.body);

      if (data['is_success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(isEditMode ? 'Berhasil Update' : 'Berhasil Tambah')),
        );
        Navigator.pop(context); // Kembali ke halaman Home
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menyimpan data')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Buku' : 'Tambah Buku Baru'),
      ),
      body: SingleChildScrollView( // Biar bisa discroll kalau keyboard muncul
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildTextField(judulController, 'Judul Buku'),
            _buildTextField(penulisController, 'Penulis'),
            _buildTextField(penerbitController, 'Penerbit'),
            
            // Row untuk input angka biar rapi (sebelah-sebelahan)
            Row(
              children: [
                Expanded(child: _buildTextField(hargaController, 'Harga', isNumber: true)),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField(jumlahController, 'Jumlah (Stok)', isNumber: true)),
              ],
            ),
            
            Row(
              children: [
                Expanded(child: _buildTextField(volumeController, 'Volume', isNumber: true)),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField(tanggalController, 'Tgl Masuk (YYYY-MM-DD)')),
              ],
            ),

            const SizedBox(height: 20),
            
            isLoading
              ? const CircularProgressIndicator()
              : SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: submitData,
                    child: Text(isEditMode ? 'UPDATE DATA' : 'SIMPAN DATA'),
                  ),
                )
          ],
        ),
      ),
    );
  }

  // Fungsi kecil untuk membuat TextField biar kodingan tidak kepanjangan
  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}