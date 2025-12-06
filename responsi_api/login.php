<?php
header("Content-Type: application/json");
include 'koneksi.php';

$username = $_POST['username'];
$password = md5($_POST['password']);

$sql = "SELECT * FROM users WHERE username='$username' AND password='$password'";
$result = mysqli_query($koneksi, $sql);

if (mysqli_num_rows($result) > 0) {
    $data = mysqli_fetch_assoc($result);
    echo json_encode([
        "is_success" => true,
        "message" => "Login Berhasil",
        "id" => $data['id'],
        "username" => $data['username']
    ]);
} else {
    echo json_encode(["is_success" => false, "message" => "Login Gagal"]);
}
?>