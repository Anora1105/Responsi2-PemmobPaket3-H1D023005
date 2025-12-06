<?php
header("Content-Type: application/json");
include 'koneksi.php';

$judul = $_POST['judul'];
$harga = $_POST['harga'];
$jumlah = $_POST['jumlah'];
$tanggal_masuk = $_POST['tanggal_masuk'];
$volume = $_POST['volume'];
$penulis = $_POST['penulis'];
$penerbit = $_POST['penerbit'];

$sql = "INSERT INTO books (judul, harga, jumlah, tanggal_masuk, volume, penulis, penerbit) 
        VALUES ('$judul', '$harga', '$jumlah', '$tanggal_masuk', '$volume', '$penulis', '$penerbit')";

if (mysqli_query($koneksi, $sql)) {
    echo json_encode(["is_success" => true, "message" => "Berhasil Menambahkan Data"]);
} else {
    echo json_encode(["is_success" => false, "message" => "Gagal Menambahkan Data"]);
}
?>