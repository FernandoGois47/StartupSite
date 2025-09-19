<?php
// Arquivo de conexão com o banco de dados
$host = 'localhost';
$dbname = 'aproximati';
$user = 'root';
$pass = '';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    die("Erro de conexão com o banco de dados: " . $e->getMessage());
}
?>