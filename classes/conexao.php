<?php
$servername = "localhost";
$username = "root";
$password = ""; // padrão do XAMPP
$dbname = "aproximati"; // nome do seu banco

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}
?>