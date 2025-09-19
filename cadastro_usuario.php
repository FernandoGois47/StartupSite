<?php include 'includes/header.php'; ?>
<main>
    <h2>Cadastro de Cliente</h2>
    <form action="processa_cadastro.php" method="post">
        <input type="hidden" name="tipo" value="cliente">
        <label>Nome:</label><br><input type="text" name="nome" required><br>
        <label>Email:</label><br><input type="email" name="email" required><br>
        <label>Telefone:</label><br><input type="text" name="telefone"><br>
        <label>Cidade:</label><br><input type="text" name="cidade"><br>
        <label>Estado (UF):</label><br><input type="text" name="estado" maxlength="2"><br>
        <label>Senha:</label><br><input type="password" name="senha" required><br><br>
        <button type="submit">Cadastrar</button>
    </form>
</main>
<?php include 'includes/footer.php'; ?>