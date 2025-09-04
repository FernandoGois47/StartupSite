<?php
require_once __DIR__ . '/conexao.php';

// Recebe os dados do formulário
$nome = $_POST['nome'];
$email = $_POST['email'];
$senha = $_POST['senha'];
$especialidade = $_POST['especialidade'];

// Criptografa a senha
$senha_hash = password_hash($senha, PASSWORD_DEFAULT);

// Insere o usuário
$stmt = $conn->prepare("INSERT INTO usuarios (nome, email, senha_hash) VALUES (?, ?, ?)");
$stmt->bind_param("sss", $nome, $email, $senha_hash);
$stmt->execute();
$usuario_id = $stmt->insert_id;
$stmt->close();

// Verifica se a habilidade já existe
$stmt = $conn->prepare("SELECT id FROM habilidades WHERE nome = ?");
$stmt->bind_param("s", $especialidade);
$stmt->execute();
$stmt->bind_result($habilidade_id);
if ($stmt->fetch()) {
    $stmt->close();
} else {
    $stmt->close();
    // Insere nova habilidade
    $stmt = $conn->prepare("INSERT INTO habilidades (nome) VALUES (?)");
    $stmt->bind_param("s", $especialidade);
    $stmt->execute();
    $habilidade_id = $stmt->insert_id;
    $stmt->close();
}

// Relaciona usuário à habilidade
$stmt = $conn->prepare("INSERT INTO usuario_habilidades (usuario_id, habilidade_id) VALUES (?, ?)");
$stmt->bind_param("ii", $usuario_id, $habilidade_id);
$stmt->execute();
$stmt->close();

echo "Cadastro realizado com sucesso!";
?>