<?php include '../includes/header.php'?>

<main>
    <h2>Cadastro de Técnico</h2>
    <form action="../classes/processa_tecnico.php" method="post">
        <label for="nome">Nome:</label>
        <input type="text" name="nome" id="nome" required><br>

        <label for="email">E-mail:</label>
        <input type="email" name="email" id="email" required><br>

        <label for="senha">Senha:</label>
        <input type="password" name="senha" id="senha" required><br>

        <label for="especialidade">Especialidade:</label>
        <input type="text" name="especialidade" id="especialidade" required><br>

        <button type="submit">Cadastrar</button>
    </form>
</main>

<?php include '../includes/footer.php'?>