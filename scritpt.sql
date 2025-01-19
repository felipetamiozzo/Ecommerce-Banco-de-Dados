-- criação do vanco de dados para E-commerce

CREATE DATABASE ecommerce;
use ecommerce;


-- criando tabela cliente
CREATE TABLE CLIENTE(
    idCliente INT NOT NULL AUTO_INCREMENT,
    Pnome VARCHAR(10),
    NomeInicialdoMeio VARCHAR(10),
    Sobrenome VARCHAR(20),
    CPF CHAR(11) NOT NULL,
    Endereco VARCHAR(45),
     
    CONSTRAINT PK_CLIENTE PRIMARY KEY (idCliente),
    CONSTRAINT unique_cpf UNIQUE(CPF)

);

-- criabdo tabela produto 
CREATE TABLE PRODUTO(
    idProduto INT NOT NULL AUTO_INCREMENT,
    Nome VARCHAR(10) NOT NULL
    Classificaçao_kids BOOL DEFAULT False,
    Categoria ENUM('Eletronico','Vestimenta','Brinquedos','Alimentos') NOT NULL,
    Avaliaçao FLOAT DEFAULT 0,
    Dimensao VARCHAR(10),

    CONSTRAINT PK_PRODUTO PRIMARY KEY (idProduto)

);




-- criando tabela pedido
CREATE TABLE PEDIDO(
    idPedido INT NOT NULL AUTO_INCREMENT,
    Pedido_idCliente INT,
    StatusPedido ENUM('Cancelado', 'Em processamento', 'Confirmado') DEFAULT 'Em processamento',
    Descrição VARCHAR(255),
    Frete FLOAT DEFAULT 10,


    CONSTRAINT PK_PEDIDO PRIMARY KEY (idPedido),
    CONSTRAINT FK_Pedido_Cliente FOREIGN KEY (Pedido_idCliente) REFERENCES ClIENTE (idCliente)

);

-- criando tabela pagamento
CREATE TABLE PAGAMENTO (
    idPagamento INT NOT NULL AUTO_INCREMENT,
    Pagamento_idCliente INT,
    Valor FLOAT,
    TipoPagemento ENUM('Boleto','Pix','Cartao'),

    CONSTRAINT PK_PAGAMENTO PRIMARY KEY (idPagamento),
    CONSTRAINT FK_Pagamento_idCliente FOREIGN KEY (Pagamento_idCliente) REFERENCES CLIENTE (idCliente)

);


-- criando tabela estoque
CREATE TABLE ESTOQUE(
    idEstoque INT NOT NULL AUTO_INCREMENT,
    Localizacao VARCHAR(30),
    Quantidade INT DEFAULT 0,

    CONSTRAINT PK_idEstoque PRIMARY KEY (idEstoque)

);


-- criando tabela fornecedor
CREATE TABLE FORNECEDOR(
    idFornecedor INT NOT NULL AUTO_INCREMENT,
    RazaoSocial VARCHAR(255) NOT NULL,
    CNPJ CHAR(15) NOT NULL,
    Contato CHAR(11) NOT NULL,

    CONSTRAINT PK_idFornecedor PRIMARY KEY (idFornecedor),
    CONSTRAINT UNIQUE_CNPJ UNIQUE (CNPJ)

);


-- criando tabela terceiro vendedor
CREATE TABLE TERCEIRO(
    idTerceiro INT NOT NULL AUTO_INCREMENT,
    RazaoSocial VARCHAR (255) NOT NULL,
    CNPJ CHAR(15),
    CPF CHAR(9),
    Localizacao VARCHAR(45),
    NomeFantasia VARCHAR (45),
    Contato CHAR(11) NOT NULL,
    
    
    CONSTRAINT PK_idTerceiro PRIMARY KEY (idTerceiro),
    CONSTRAINT UNIQUE_CNPJ_TERCEIRO UNIQUE (CNPJ),
    CONSTRAINT UNIQUE_CPF_TERCEIRO UNIQUE (CPF)

);


-- criando tabela Produto_Fornecedor
CREATE TABLE PRODUTO_FORNECEDOR(
    ProdFornecedor_idFornecedor INT,
    ProdFornecedor_idProduto INT,
    Quantidade INT DEFAULT 1,
    
    
    CONSTRAINT PK_ProdFornecedor PRIMARY KEY (ProdFornecedor_idFornecedor, ProdFornecedor_idProduto),
    CONSTRAINT FK_ProdFornecedor_idFornecedor FOREIGN KEY ProdFornecedor_idFornecedor REFERENCES FORNECEDOR (idFornecedor),
    CONSTRAINT FK_ProdFornecedor_idProduto FOREIGN KEY ProdFornecedor_idProduto REFERENCES PRODUTO (idProduto)
);



-- criando tavbela Produto_Vendedor
CREATE TABLE PRODUTO_VENDEDOR(
    ProdVend_idTerceiro INT,
    ProdVend_idProduto INT,
    Quantidade INT DEFAULT 1,

    
    CONSTRAINT PK_idProdVend PRIMARY KEY (ProdVend_idTerceiro,ProdVend_idProduto ),
    CONSTRAINT FK_ProdVend_idTerceiro FOREIGN KEY (ProdVend_idTerceiro) REFERENCES TERCEIRO (idTerceiro),
    CONSTRAINT FK_ProdVend_idProduto FOREIGN KEY (ProdVend_idProduto) REFERENCES PRODUTO (idProduto)


);

-- criando a tabela Produto_em_Estoque
CREATE TABLE PRODUTO_ESTOQUE(
    ProdEstoque_idProduto INT,
    ProdEstoque_idEstoque INT,
    Localizacao VARCHAR (30) NOT NULL,
    
    CONSTRAINT PK_ProdEstoque PRIMARY KEY (ProdEstoque_idProduto, ProdEstoque_idEstoque ),
    CONSTRAINT FK_ProdEstoque_idProduto FOREIGN KEY (ProdEstoque_idProduto) REFERENCES PRODUTO (idProduto),
    CONSTRAINT FK_ProdEstoque_idEstoque FOREIGN KEY (ProdEstoque_idEstoque) REFERENCES ESTOQUE (idEstoque)
);

-- criando a tabela Produto_Pedido
CREATE TABLE PRODUTO_PEDIDO(
    ProdPedido_idProduto INT,
    ProdPedido_idPedido INT,
    Quantidade INT DEFAULT 1,
    ProdStatus ENUM('Disponível', 'Sem Estoque') DEFAULT 'Disponível',
    
    CONSTRAINT PK_ProdPedido PRIMARY KEY (ProdPedido_idProduto, ProdPedido_idPedido ),
    CONSTRAINT FK_ProdPedido_idProduto FOREIGN KEY (ProdPedido_idProduto) REFERENCES PRODUTO (idProduto),
    CONSTRAINT FK_ProdPedido_idPedido FOREIGN KEY (ProdPedido_idPedido) REFERENCES PEDIDO (idPedido)
);