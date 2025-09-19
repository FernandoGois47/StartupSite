-- Cria o banco de dados 'aproximati' se ele não existir, e define o padrão de caracteres.
CREATE DATABASE IF NOT EXISTS aproximati

-- Seleciona o banco de dados 'aproximati' para executar os comandos a seguir.
USE aproximati;

-- =============================
-- TABELA DE USUÁRIOS (MODIFICADA)
-- =============================
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
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- TABELA DE ESPECIALIZAÇÕES
-- =============================
CREATE TABLE `especializacoes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `descricao` TEXT DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- RELAÇÃO TÉCNICO x ESPECIALIZAÇÃO
-- =============================
CREATE TABLE `tecnico_especializacao` (
  `tecnico_id` INT(11) NOT NULL,
  `especializacao_id` INT(11) NOT NULL,
  PRIMARY KEY (`tecnico_id`,`especializacao_id`),
  KEY `especializacao_id` (`especializacao_id`),
  CONSTRAINT `tecnico_especializacao_ibfk_1` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `tecnico_especializacao_ibfk_2` FOREIGN KEY (`especializacao_id`) REFERENCES `especializacoes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- TABELA DE CATEGORIAS DE SERVIÇOS
-- =============================
CREATE TABLE `categorias` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- TABELA DE SERVIÇOS
-- =============================
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
  KEY `tecnico_id` (`tecnico_id`),
  KEY `categoria_id` (`categoria_id`),
  CONSTRAINT `servicos_ibfk_1` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `servicos_ibfk_2` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- TABELA DE ATENDIMENTOS
-- =============================
CREATE TABLE `atendimentos` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tecnico_id` INT(11) NOT NULL,
  `cliente_id` INT(11) NOT NULL,
  `servico_id` INT(11) NOT NULL,
  `data_atendimento` DATETIME DEFAULT NULL,
  `data_conclusao` DATETIME DEFAULT NULL,
  `status` ENUM('pendente','em_andamento','concluido','cancelado') DEFAULT 'pendente',
  `observacoes` TEXT DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tecnico_id` (`tecnico_id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `servico_id` (`servico_id`),
  CONSTRAINT `atendimentos_ibfk_1` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `atendimentos_ibfk_2` FOREIGN KEY (`cliente_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `atendimentos_ibfk_3` FOREIGN KEY (`servico_id`) REFERENCES `servicos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- TABELA DE AVALIAÇÕES
-- =============================
CREATE TABLE `avaliacoes` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` INT(11) NOT NULL,
  `tecnico_id` INT(11) NOT NULL,
  `atendimento_id` INT(11) NOT NULL,
  `nota` INT(11) DEFAULT NULL CHECK (`nota` BETWEEN 1 AND 5),
  `comentario` TEXT DEFAULT NULL,
  `data_avaliacao` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `tecnico_id` (`tecnico_id`),
  KEY `atendimento_id` (`atendimento_id`),
  CONSTRAINT `avaliacoes_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `avaliacoes_ibfk_2` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `avaliacoes_ibfk_3` FOREIGN KEY (`atendimento_id`) REFERENCES `atendimentos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- TABELA DE PORTFÓLIO
-- =============================
CREATE TABLE `portfolio` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `tecnico_id` INT(11) NOT NULL,
  `titulo` VARCHAR(100) NOT NULL,
  `descricao` TEXT DEFAULT NULL,
  `imagem_url` VARCHAR(255) DEFAULT NULL,
  `data_publicacao` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tecnico_id` (`tecnico_id`),
  CONSTRAINT `portfolio_ibfk_1` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- =============================
-- TABELAS DE CHAT (CONVERSAS E MENSAGENS)
-- =============================
CREATE TABLE `conversas` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` INT(11) NOT NULL,
  `tecnico_id` INT(11) NOT NULL,
  `data_criacao` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`),
  KEY `tecnico_id` (`tecnico_id`),
  CONSTRAINT `conversas_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `conversas_ibfk_2` FOREIGN KEY (`tecnico_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `mensagens` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `conversa_id` INT(11) NOT NULL,
  `remetente_id` INT(11) NOT NULL,
  `mensagem` TEXT NOT NULL,
  `data_envio` DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `conversa_id` (`conversa_id`),
  KEY `remetente_id` (`remetente_id`),
  CONSTRAINT `mensagens_ibfk_1` FOREIGN KEY (`conversa_id`) REFERENCES `conversas` (`id`),
  CONSTRAINT `mensagens_ibfk_2` FOREIGN KEY (`remetente_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

COMMIT;