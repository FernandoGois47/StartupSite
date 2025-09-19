<?php
require_once 'includes/header.php';
require_once 'includes/db.php';

// Busca o usuário pelo ID da URL
$id = $_GET['id'];
$stmt = $pdo->prepare("SELECT * FROM usuarios WHERE id = ?");
$stmt->execute([$id]);
$usuario = $stmt->fetch(PDO::FETCH_ASSOC);
?>
<main>
    <h2>Editar Usuário</h2>
    <form action="processa_edicao.php" method="post">
        <input type="hidden" name="id" value="<?= $usuario['id']; ?>">
        <label>Nome:</label><br><input type="text" name="nome" value="<?= htmlspecialchars($usuario['nome']); ?>"><br>
        <label>Email:</label><br><input type="email" name="email" value="<?= htmlspecialchars($usuario['email']); ?>"><br>
        <label>Telefone:</label><br><input type="text" name="telefone" value="<?= htmlspecialchars($usuario['telefone']); ?>"><br>

        <?php if ($usuario['tipo'] === 'tecnico'): ?>
            <label>Especialidade:</label><br><input type="text" name="especialidade" value="<?= htmlspecialchars($usuario['especialidade']); ?>"><br>
        <?php endif; ?>
        <br>
        <button type="submit">Salvar Alterações</button>
    </form>
</main>
<?php require_once 'includes/footer.php'; ?>