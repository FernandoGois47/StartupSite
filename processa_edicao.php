<?php
require_once 'includes/db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Define a especialidade como null se não for enviada
    $especialidade = $_POST['especialidade'] ?? null;

    // Atualiza os dados no banco
    $sql = "UPDATE usuarios SET nome = ?, email = ?, telefone = ?, especialidade = ? WHERE id = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([
        $_POST['nome'],
        $_POST['email'],
        $_POST['telefone'],
        $especialidade,
        $_POST['id']
    ]);

    // Redireciona para a lista
    header('Location: listar_usuarios.php');
}
?>