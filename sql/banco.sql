-- Tabela de Usuários (Profissionais de TI)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    cidade VARCHAR(100),
    estado VARCHAR(50),
    bio TEXT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Habilidades
CREATE TABLE habilidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL
);

-- Relacionamento: Usuários <-> Habilidades
CREATE TABLE usuario_habilidades (
    usuario_id INT,
    habilidade_id INT,
    PRIMARY KEY (usuario_id, habilidade_id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (habilidade_id) REFERENCES habilidades(id) ON DELETE CASCADE
);

-- Tabela de Empresas
CREATE TABLE empresas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) UNIQUE,
    email_contato VARCHAR(100),
    descricao TEXT,
    cidade VARCHAR(100),
    estado VARCHAR(50),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Oportunidades
CREATE TABLE oportunidades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    tipo_contrato VARCHAR(50), -- CLT, PJ, Freelance etc.
    nivel_experiencia VARCHAR(50), -- Júnior, Pleno, Sênior etc.
    remoto BOOLEAN DEFAULT FALSE,
    cidade VARCHAR(100),
    estado VARCHAR(50),
    empresa_id INT,
    data_publicacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empresa_id) REFERENCES empresas(id) ON DELETE CASCADE
);

-- Relacionamento: Oportunidades <-> Habilidades
CREATE TABLE oportunidade_habilidades (
    oportunidade_id INT,
    habilidade_id INT,
    PRIMARY KEY (oportunidade_id, habilidade_id),
    FOREIGN KEY (oportunidade_id) REFERENCES oportunidades(id) ON DELETE CASCADE,
    FOREIGN KEY (habilidade_id) REFERENCES habilidades(id) ON DELETE CASCADE
);

-- Candidaturas de Usuários a Oportunidades
CREATE TABLE candidaturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    oportunidade_id INT,
    data_candidatura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Pendente',
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (oportunidade_id) REFERENCES oportunidades(id) ON DELETE CASCADE
);