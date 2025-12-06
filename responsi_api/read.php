<?php
header("Content-Type: application/json");
include 'koneksi.php';

$sql = "SELECT * FROM books";
$result = mysqli_query($koneksi, $sql);
$data = array();

while($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}

echo json_encode([
    "is_success" => true,
    "data" => $data
]);
?>