<?php
require_once 'User.php';

// Representa um usuário do tipo Técnico
class Tecnico implements User {
    public $id, $nome, $email, $telefone, $cidade, $estado, $especialidade;

    public function __construct($dados) {
        $this->id = $dados['id'] ?? null;
        $this->nome = $dados['nome'];
        $this->email = $dados['email'];
        $this->telefone = $dados['telefone'] ?? null;
        $this->cidade = $dados['cidade'] ?? null;
        $this->estado = $dados['estado'] ?? null;
        $this->especialidade = $dados['especialidade'] ?? null;
    }
    public function getNome() { return $this->nome; }
    public function getEmail() { return $this->email; }
}
?>