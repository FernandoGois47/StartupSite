<?php
require_once 'Cliente.php';
require_once 'Tecnico.php';

// Classe Factory responsável por criar os objetos de usuário
class UserFactory {
    public static function create($tipo, $dados) {
        switch ($tipo) {
            case 'cliente':
                return new Cliente($dados);
            case 'tecnico':
                return new Tecnico($dados);
            default:
                throw new Exception("Tipo de usuário inválido.");
        }
    }
}
?>