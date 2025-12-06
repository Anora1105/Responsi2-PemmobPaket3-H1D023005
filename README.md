# Nama: Ariza Nola Rufiana
# NIM: H1D023005
## Responsi 2 Paket 3 Pemmob C

### Video Demo Aplikasi
<img src="https://raw.githubusercontent.com/Anora1105/Responsi2-PemmobPaket3-H1D023005/main/responsi%020%.gif" width="200">
![responsi 2](https://github.com/user-attachments/assets/168d3725-6ec4-462f-be81-ad7696301918)

---

### Spesifikasi API (Backend)
Aplikasi ini menggunakan backend **PHP Native** dengan database **MySQL**.
Berikut adalah daftar endpoint yang digunakan:

| Fitur | Method | Endpoint | Parameter (Body) |
| :--- | :---: | :--- | :--- |
| **Login** | `POST` | `/login.php` | `username`, `password` |
| **Register** | `POST` | `/register.php` | `username`, `password` |
| **Read Data** | `GET` | `/read.php` | - |
| **Tambah Data** | `POST` | `/create.php` | `judul`, `harga`, `jumlah`, `tanggal_masuk`, `volume`, `penulis`, `penerbit` |
| **Edit Data** | `POST` | `/update.php` | `id`, `judul`, `harga`, `jumlah`, `tanggal_masuk`, `volume`, `penulis`, `penerbit` |
| **Hapus Data** | `POST` | `/delete.php` | `id` |

---

## 📱 Penjelasan Kode Flutter
Berikut adalah penjelasan fungsi dari setiap file dalam project Flutter:

### 1. `main.dart`
* **Fungsi Utama:** Titik awal aplikasi (`entry point`).
* **Konfigurasi:** Mengatur tema aplikasi dengan warna utama **Coklat** (`Colors.brown`) sesuai ketentuan soal.
* **Routing:** Mengarahkan pengguna langsung ke halaman `LoginPage` saat aplikasi pertama dibuka.

### 2. `login_page.dart`
* Menangani autentikasi pengguna.
* Mengirim request `POST` ke API `login.php`.
* Jika respons sukses (`is_success: true`), pengguna diarahkan ke `HomePage`.
* Terdapat tombol navigasi menuju halaman registrasi jika belum punya akun.

### 3. `register_page.dart`
* Form pendaftaran akun baru.
* Mengirim request `POST` ke API `register.php` untuk menyimpan `username` dan `password` (terenkripsi md5) ke tabel `users`.

### 4. `home_page.dart` (Read & Delete)
* **Read:** Mengambil data buku dari API `read.php` menggunakan method `GET` dan menampilkannya dalam bentuk `ListView`.
* **Delete:** Menyediakan tombol sampah pada tiap item. Jika diklik, mengirim request `POST` ke `delete.php` berdasarkan ID barang.
* **Refresh:** Otomatis memuat ulang data (`setState`) setelah proses tambah, edit, atau hapus selesai.

### 5. `add_edit_page.dart` (Create & Update)
* Halaman ini bersifat dinamis (satu halaman untuk dua fungsi):
    * **Mode Tambah:** Jika tidak ada data yang dikirim dari halaman Home, maka form kosong dan tombol berfungsi sebagai "Simpan" (akses `create.php`).
    * **Mode Edit:** Jika menerima parameter data buku, maka form terisi otomatis dan tombol berfungsi sebagai "Update" (akses `update.php`).
* Menangani 7 input field sesuai soal: Judul, Harga, Jumlah, Tanggal, Volume, Penulis, dan Penerbit.

---

## ⚙️ Cara Instalasi
1.  **Backend:**
    * Import database `responsi_abimart` ke phpMyAdmin.
    * Simpan folder `responsi_api` ke dalam `htdocs` XAMPP.
    * Pastikan XAMPP berjalan.
2.  **Mobile:**
    * Buka project di VS Code.
    * Jalankan `flutter pub get`.
    * Ubah IP Address di kodingan jika menggunakan device asli (default: `10.0.2.2` untuk emulator).
    * Jalankan `flutter run`.
