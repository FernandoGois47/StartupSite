<?php
require_once 'includes/db.php';
require_once 'classes/UserFactory.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Usa a Factory para criar o objeto User (Cliente ou Tecnico)
    $user = UserFactory::create($_POST['tipo'], $_POST);
    
    // Criptografa a senha
    $senhaHash = password_hash($_POST['senha'], PASSWORD_DEFAULT);

    // SQL para inserir os dados no banco
    $sql = "INSERT INTO usuarios (nome, email, senha, tipo, telefone, cidade, estado, especialidade) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    
    try {
        $stmt = $pdo->prepare($sql);
        // Executa a query
        $stmt->execute([
            $user->nome,
            $user->email,
            $senhaHash,
            $_POST['tipo'],
            $user->telefone,
            $user->cidade,
            $user->estado,
            $user->especialidade ?? null
        ]);

        echo "<h1>Cadastro realizado com sucesso!</h1>";
        echo '<a href="listar_usuarios.php">Ver lista de usuários</a>';

    } catch (PDOException $e) {
        die("Erro ao cadastrar: " . $e->getMessage());
    }
}
?>