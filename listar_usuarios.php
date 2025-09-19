<?php
require_once 'includes/header.php';
require_once 'includes/db.php';

// Busca todos os usuários
$stmt = $pdo->query("SELECT * FROM usuarios ORDER BY nome");
$usuarios = $stmt->fetchAll(PDO::FETCH_ASSOC);
?>
<main>
    <h2>Usuários Cadastrados</h2>
    <table border="1" style="width:100%; border-collapse: collapse; margin-top: 15px;">
        <tr style="background-color:#f2f2f2;">
            <th>ID</th> <th>Nome</th> <th>Email</th> <th>Tipo</th> <th>Telefone</th> <th>Ações</th>
        </tr>
        <?php foreach ($usuarios as $usuario): ?>
        <tr>
            <td><?= htmlspecialchars($usuario['id']); ?></td>
            <td><?= htmlspecialchars($usuario['nome']); ?></td>
            <td><?= htmlspecialchars($usuario['email']); ?></td>
            <td><?= htmlspecialchars($usuario['tipo']); ?></td>
            <td><?= htmlspecialchars($usuario['telefone']); ?></td>
            <td>
                <a href="editar_usuario.php?id=<?= $usuario['id']; ?>">Editar</a> |
                <a href="deletar_usuario.php?id=<?= $usuario['id']; ?>" onclick="return confirm('Confirmar exclusão?');">Deletar</a>
            </td>
        </tr>
        <?php endforeach; ?>
    </table>
</main>
<?php require_once 'includes/footer.php'; ?>