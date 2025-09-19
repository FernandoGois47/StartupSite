<?php
require_once 'includes/db.php';

// Pega o ID da URL e deleta o registro
$id = $_GET['id'] ?? null;
if ($id) {
    $stmt = $pdo->prepare("DELETE FROM usuarios WHERE id = ?");
    $stmt->execute([$id]);
}

// Redireciona para a lista
header('Location: listar_usuarios.php');
exit;
?>