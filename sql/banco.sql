-- =============================
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS APROXIMATI
-- Versão corrigida e organizada
-- =============================

-- Cria o banco de dados 'aproximati' se ele não existir
CREATE DATABASE IF NOT EXISTS aproximati
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;

-- Define o banco de dados 'aproximati' como o padrão para os comandos a seguir
USE aproximati;

-- =============================
-- 1. TABELA DE USUÁRIOS
-- =============================
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `tipo` ENUM('tecnico','cliente','admin') NOT NULL,
  `telefone` VARCHAR(20) DEFAULT NULL,
  `cidade` VARCHAR(100) DEFAULT NULL,
  `estado` CHAR(2) DEFAULT NULL,
  `foto_perfil` VARCHAR(255) DEFAULT NULL,
  `especialidade` VARCHAR(255) DEFAULT NULL COMMENT 'Campo simplificado para o CRUD inicial',
  `data_cadastro` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_unique` (`email`),
  INDEX `idx_tipo` (`tipo`),
  INDEX `idx_cidade_estado` (`cidade`, `estado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- 2. TABELA DE ESPECIALIZAÇÕES
-- =============================
DROP TABLE IF EXISTS `especializacoes`;
CREATE TABLE `especializacoes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_unique` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- 3. TABELA DE CATEGORIAS DE SERVIÇOS
-- =============================
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_unique` (`nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- 4. TABELA DE SERVIÇOS
-- =============================
DROP TABLE IF EXISTS `servicos`;
CREATE TABLE `servicos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tecnico_id` INT(11) NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `descricao` TEXT DEFAULT NULL,
  `preco` DECIMAL(10,2) DEFAULT NULL,
  `categoria_id` INT(11) DEFAULT NULL,
  `tempo_estimado` VARCHAR(50) DEFAULT NULL,
  `data_cadastro` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_tecnico` (`tecnico_id`),
  INDEX `idx_categoria` (`categoria_id`),
  INDEX `idx_preco` (`preco`),
  CONSTRAINT `fk_servicos_tecnico` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_servicos_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- 5. TABELA DE ATENDIMENTOS
-- =============================
DROP TABLE IF EXISTS `atendimentos`;
CREATE TABLE `atendimentos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tecnico_id` INT(11) NOT NULL,
  `cliente_id` INT(11) NOT NULL,
  `servico_id` INT(11) NOT NULL,
  `data_atendimento` DATETIME DEFAULT NULL,
  `data_conclusao` DATETIME DEFAULT NULL,
  `status` ENUM('pendente','em_andamento','concluido','cancelado') DEFAULT 'pendente',
  `observacoes` TEXT DEFAULT NULL,
  `data_criacao` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_tecnico` (`tecnico_id`),
  INDEX `idx_cliente` (`cliente_id`),
  INDEX `idx_servico` (`servico_id`),
  INDEX `idx_status` (`status`),
  INDEX `idx_data_atendimento` (`data_atendimento`),
  CONSTRAINT `fk_atendimentos_tecnico` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_atendimentos_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_atendimentos_servico` FOREIGN KEY (`servico_id`) REFERENCES `servicos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- 6. TABELA DE AVALIAÇÕES
-- =============================
DROP TABLE IF EXISTS `avaliacoes`;
CREATE TABLE `avaliacoes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` INT(11) NOT NULL,
  `tecnico_id` INT(11) NOT NULL,
  `atendimento_id` INT(11) NOT NULL,
  `nota` TINYINT(1) NOT NULL CHECK (`nota` BETWEEN 1 AND 5),
  `comentario` TEXT DEFAULT NULL,
  `data_avaliacao` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_cliente` (`cliente_id`),
  INDEX `idx_tecnico` (`tecnico_id`),
  INDEX `idx_atendimento` (`atendimento_id`),
  INDEX `idx_nota` (`nota`),
  UNIQUE KEY `unique_avaliacao_atendimento` (`atendimento_id`),
  CONSTRAINT `fk_avaliacoes_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_avaliacoes_tecnico` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_avaliacoes_atendimento` FOREIGN KEY (`atendimento_id`) REFERENCES `atendimentos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- 7. TABELA DE PORTFÓLIO
-- =============================
DROP TABLE IF EXISTS `portfolio`;
CREATE TABLE `portfolio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tecnico_id` INT(11) NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `descricao` TEXT DEFAULT NULL,
  `imagem_url` VARCHAR(255) DEFAULT NULL,
  `data_publicacao` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `idx_tecnico` (`tecnico_id`),
  INDEX `idx_data_publicacao` (`data_publicacao`),
  CONSTRAINT `fk_portfolio_tecnico` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- 8. TABELA DE CONVERSAS (CHAT)
-- =============================
DROP TABLE IF EXISTS `conversas`;
CREATE TABLE `conversas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` INT(11) NOT NULL,
  `tecnico_id` INT(11) NOT NULL,
  `data_criacao` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `data_ultima_mensagem` DATETIME DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_cliente` (`cliente_id`),
  INDEX `idx_tecnico` (`tecnico_id`),
  INDEX `idx_data_criacao` (`data_criacao`),
  UNIQUE KEY `unique_conversa` (`cliente_id`, `tecnico_id`),
  CONSTRAINT `fk_conversas_cliente` FOREIGN KEY (`cliente_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_conversas_tecnico` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- 9. TABELA DE MENSAGENS (CHAT)
-- =============================
DROP TABLE IF EXISTS `mensagens`;
CREATE TABLE `mensagens` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `conversa_id` INT(11) NOT NULL,
  `remetente_id` INT(11) NOT NULL,
  `mensagem` TEXT NOT NULL,
  `data_envio` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `lida` BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (`id`),
  INDEX `idx_conversa` (`conversa_id`),
  INDEX `idx_remetente` (`remetente_id`),
  INDEX `idx_data_envio` (`data_envio`),
  INDEX `idx_lida` (`lida`),
  CONSTRAINT `fk_mensagens_conversa` FOREIGN KEY (`conversa_id`) REFERENCES `conversas` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_mensagens_remetente` FOREIGN KEY (`remetente_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- 10. TABELA DE RELAÇÃO TÉCNICO x ESPECIALIZAÇÃO
-- =============================
DROP TABLE IF EXISTS `tecnico_especializacao`;
CREATE TABLE `tecnico_especializacao` (
  `tecnico_id` INT(11) NOT NULL,
  `especializacao_id` INT(11) NOT NULL,
  `data_associacao` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tecnico_id`, `especializacao_id`),
  INDEX `idx_especializacao` (`especializacao_id`),
  CONSTRAINT `fk_tecnico_especializacao_tecnico` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_tecnico_especializacao_especializacao` FOREIGN KEY (`especializacao_id`) REFERENCES `especializacoes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- TRIGGER PARA ATUALIZAR DATA_ULTIMA_MENSAGEM
-- =============================
DELIMITER $$
CREATE TRIGGER `tr_atualiza_ultima_mensagem`
AFTER INSERT ON `mensagens`
FOR EACH ROW
BEGIN
  UPDATE `conversas` 
  SET `data_ultima_mensagem` = NEW.`data_envio`
  WHERE `id` = NEW.`conversa_id`;
END$$
DELIMITER ;

-- =============================
-- ÍNDICES COMPOSTOS ADICIONAIS PARA PERFORMANCE
-- =============================
ALTER TABLE `atendimentos` ADD INDEX `idx_tecnico_status` (`tecnico_id`, `status`);
ALTER TABLE `atendimentos` ADD INDEX `idx_cliente_status` (`cliente_id`, `status`);
ALTER TABLE `avaliacoes` ADD INDEX `idx_tecnico_nota` (`tecnico_id`, `nota`);

COMMIT;