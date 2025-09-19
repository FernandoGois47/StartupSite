<?php
require_once 'User.php';

// Representa um usuário do tipo Cliente
class Cliente implements User {
    public $id, $nome, $email, $telefone, $cidade, $estado;

    public function __construct($dados) {
        $this->id = $dados['id'] ?? null;
        $this->nome = $dados['nome'];
        $this->email = $dados['email'];
        $this->telefone = $dados['telefone'] ?? null;
        $this->cidade = $dados['cidade'] ?? null;
        $this->estado = $dados['estado'] ?? null;
    }
    public function getNome() { return $this->nome; }
    public function getEmail() { return $this->email; }
}
?>