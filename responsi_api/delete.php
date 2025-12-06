<?php
header("Content-Type: application/json");
include 'koneksi.php';

$id = $_POST['id'];
$sql = "DELETE FROM books WHERE id=$id";

if (mysqli_query($koneksi, $sql)) {
    echo json_encode(["is_success" => true, "message" => "Berhasil Hapus Data"]);
} else {
    echo json_encode(["is_success" => false, "message" => "Gagal Hapus Data"]);
}
?>