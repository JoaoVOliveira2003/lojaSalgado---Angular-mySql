CREATE SCHEMA sistemaLoja;

CREATE TABLE SL_PESSOA (
    idPessoa INT PRIMARY KEY AUTO_INCREMENT,    
    nome VARCHAR(255),
    cpf VARCHAR(25),
    email VARCHAR(255) UNIQUE,                 
    telefone BIGINT,
    endereco TEXT,
    tipoUsuario ENUM('cliente', 'gerente')    
);

CREATE TABLE SL_LOGIN (
    idPessoa INT PRIMARY KEY,                
    email VARCHAR(255) UNIQUE,                
    senha VARCHAR(255),
    FOREIGN KEY (idPessoa) REFERENCES SL_PESSOA(idPessoa) ON DELETE CASCADE
);

CREATE TABLE SL_CATEGORIA (
    idCategoria INT PRIMARY KEY AUTO_INCREMENT,  
    descricao TEXT,
    ativo CHAR(1) DEFAULT 'S'                  -- 'S' para ativo, 'N' para inativo
);

CREATE TABLE SL_PRODUTO (
    idProduto INT PRIMARY KEY AUTO_INCREMENT,   
    nome VARCHAR(255),                          
    descricao TEXT,                             
    preco DECIMAL(10, 2),                       
    idCategoria INT,                            
    imagem VARCHAR(255),                        
    ativo CHAR(1) DEFAULT 'S',                  -- 'S' para ativo, 'N' para inativo
    FOREIGN KEY (idCategoria) REFERENCES SL_CATEGORIA(idCategoria) ON DELETE SET NULL
);

CREATE TABLE SL_STATUS (
    idStatus INT PRIMARY KEY AUTO_INCREMENT,    
    descricao TEXT,
    ativo CHAR(1) DEFAULT 'S'                  -- 'S' para ativo, 'N' para inativo
);

CREATE TABLE SL_METODOPAGAMENTO (
    idMetodoPagamento INT PRIMARY KEY AUTO_INCREMENT, 
    descricao TEXT,                                  
    ativo CHAR(1) DEFAULT 'S'                         -- 'S' para ativo, 'N' para inativo
);

CREATE TABLE SL_PEDIDO (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,    
    idPessoa INT,                               
    idMetodoPagamento INT,                     
    idStatus INT,                              
    inicioPedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    finalPedido DATETIME,  
    total DECIMAL(10, 2),                       
    enderecoEntrega TEXT,                       
    tipoEntrega ENUM('retirada', 'entrega') DEFAULT 'entrega',    
    FOREIGN KEY (idPessoa) REFERENCES SL_PESSOA(idPessoa) ON DELETE CASCADE,
    FOREIGN KEY (idMetodoPagamento) REFERENCES SL_METODOPAGAMENTO(idMetodoPagamento) ON DELETE SET NULL,
    FOREIGN KEY (idStatus) REFERENCES SL_STATUS(idStatus) ON DELETE SET NULL
);

CREATE TABLE SL_PEDIDO_PRODUTO (
    idPedido INT,                    -- Referência ao pedido
    idProduto INT,                   -- Referência ao produto
    quantidade INT,                  -- Quantidade do produto no pedido
    precoUnitario DECIMAL(10, 2),    -- Preço do produto no momento da compra
    PRIMARY KEY (idPedido, idProduto), -- Chave composta (pedido + produto) para garantir a unicidade
    FOREIGN KEY (idPedido) REFERENCES SL_PEDIDO(idPedido) ON DELETE CASCADE,  -- Relaciona com a tabela SL_PEDIDO
    FOREIGN KEY (idProduto) REFERENCES SL_PRODUTO(idProduto) ON DELETE CASCADE  -- Relaciona com a tabela SL_PRODUTO
);
