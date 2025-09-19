<?php 
// 1. Inclui o cabeçalho e a conexão com o banco
include 'includes/header.php';
require_once 'includes/db.php';

// 2. Prepara e executa a busca por técnicos no banco de dados
try {
    $sql = "SELECT nome, cidade, estado, especialidade FROM usuarios WHERE tipo = 'tecnico' ORDER BY nome";
    $stmt = $pdo->query($sql);
    $tecnicos = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Erro ao consultar técnicos: " . $e->getMessage());
}
?>

<section class="tecnicos">
    <h2><?php echo count($tecnicos); ?> Técnico(s) encontrado(s)</h2>
    
    <?php
    // 3. Verifica se encontrou algum técnico
    if (count($tecnicos) > 0):
        // 4. Cria um card para cada técnico usando um loop
        foreach ($tecnicos as $tecnico):
    ?>

    <div class="tecnico">
        <div class="perfil">
            <img src="../img/tecnico_default.jpg" alt="Foto do Técnico">
            <div class="info">
                <h3><?php echo htmlspecialchars($tecnico['nome']); ?></h3>

                <p><strong>Localização:</strong> <?php echo htmlspecialchars($tecnico['cidade']); ?> - <?php echo htmlspecialchars($tecnico['estado']); ?></p>
                
                <p>Avaliação geral: <span>⭐ (em breve)</span></p>
                <p>atendimento(s): (em breve)</p>
                
                <ul>
                    <li>Especialidade principal: <?php echo htmlspecialchars($tecnico['especialidade']); ?></li>
                </ul>
            </div>
            <a href="#" class="ver-perfil">Ver perfil →</a>
        </div>
    </div>

    <?php 
        endforeach; 
    else: 
    ?>
        <p style="text-align: center; margin-top: 20px;">Nenhum técnico cadastrado no momento.</p>
    <?php 
    endif; 
    ?>
</section>

<?php 
include 'includes/footer.php'
?>