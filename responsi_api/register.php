<?php
header("Content-Type: application/json");
include 'koneksi.php';

$username = $_POST['username'];
$password = md5($_POST['password']); 

$sql = "INSERT INTO users (username, password) VALUES ('$username', '$password')";
$query = mysqli_query($koneksi, $sql);

if ($query) {
    echo json_encode(["is_success" => true, "message" => "Berhasil Register"]);
} else {
    echo json_encode(["is_success" => false, "message" => "Gagal Register"]);
}
?>