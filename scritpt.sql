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
    Classificacao_kids BOOL DEFAULT False,
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
    CONSTRAINT FK_ProdFornecedor_idFornecedor FOREIGN KEY (ProdFornecedor_idFornecedor) REFERENCES FORNECEDOR (idFornecedor),
    CONSTRAINT FK_ProdFornecedor_idProduto FOREIGN KEY (ProdFornecedor_idProduto) REFERENCES PRODUTO (idProduto)
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

-- fazendo consulta das constraints --

show databases;
use information_schema;
show tables;
desc referential_constraints;

select * 
from referential_constraints
where constraint_schema = 'ecommerce';  -- selecionando somente 'ecommerce' de constraint_schema


-- inserindo dados nas tabelas 

show databases;
use ecommerce;
show tables;

-- tabela cliente --
desc cliente;
-- idCliente, Pnome, NomeInicialdoMeio, Sobrenome, CPF, Endereco

INSERT INTO cliente (Pnome,NomeInicialdoMeio,Sobrenome,CPF,Endereco)
    values('Maria','M','Silva', 12346789, 'rua silva de prata 29, Carangola'),
		  ('Matheus','O','Pimentel', 987654321,'rua alemeda 289, Centro'),
		  ('Ricardo','F','Silva', 45678913,'avenida alemeda vinha 1009, Centro'),
		  ('Julia','S','França', 789123456,'rua lareijras 861, Centro'),
		  ('Roberta','G','Assis', 98745631,'avenidade koller 19, Centro'),
		  ('Isabela','M','Cruz', 654789123,'rua alemeda das flores 28, Centro');
          
select * from cliente;   -- conferindo


-- tabela estoque --
show tables;
desc estoque;

-- idEstoque, Localizacao, Quantidade

INSERT INTO estoque (Localizacao, Quantidade)
   values('Rio de Janeiro',1000),
		 ('Rio de Janeiro',500),
		 ('São Paulo',10),
         ('São Paulo',100),
         ('São Paulo',10),
		 ('Brasília',60);
         
select * from estoque;  -- conferindo

-- tabela fornecedor --
show tables;
desc fornecedor;

-- idFornecedor, RazaoSocial, CNPJ, Contato

INSERT INTO fornecedor(RazaoSocial,CNPJ,Contato)
   values ('Almeida e filhos', 123456789123456,'21985474'),
		  ('Eletrônicos Silva',854519649143457,'21985484'),
		  ('Eletrônicos Valma', 934567893934695,'21975474');
          
select * from fornecedor; -- conferindo

-- tabela pagamento

show tables;
desc pagamento;

alter table pagamento RENAME COLUMN TipoPagemento TO TipoPagamento; -- alterando nome que estava errado

-- idPagamento, Pagamento_idCliente, Valor, TipoPagamento ('Boleto,'Pix,'Cartao')

INSERT INTO pagamento(Pagamento_idCliente, Valor,TipoPagamento)
    values (1, 120.50, 'Pix'),
           (2, 75.90, 'Cartao'),
           (3, 200.00, 'Boleto'),
           (4, 50.75, 'Pix'),
           (5, 180.30, 'Cartao'),
           (6, 95.40, 'Boleto');
           
select * from pagamento;
           
SHOW DATABASES;
use ecommerce;
show tables;

-- tabela pedido ---
desc pedido;
-- idPedido,Pedido_idCliente,StatusPedido ('Cancelado','Em processamento','Confirmado'), Descrição, Frete

INSERT INTO pedido(Pedido_idCliente,StatusPedido,Descrição,Frete)
    values(1, default,'compra via aplicativo',60.0),
		  (2,default,'compra via aplicativo',50.0),
		  (3,'Confirmado',null,20.0),
		  (4,default,'compra via web site',150.0);
          
select* from pedido;


-- tabela produto --
desc produto;
alter table produto modify column Nome varchar(255);
-- idProduto,Nome,Classificacao_kids, Categoria('Eletronico','Vestimenta','Brinquedos','Alimentos'), Avaliaçao, Dimensao

insert into produto (Nome,Classificacao_kids, Categoria, Avaliaçao, Dimensao)
    values ('Fone de ouvido',0,'Eletrônico','4',null),
		   ('Barbie Elsa',1,'Brinquedos','3',null),
		   ('Body Carters',1,'Vestimenta','5',null),
		   ('Microfone Vedo - Youtuber',0,'Eletrônico','4',null),
		   ('Ipad',0,'Eletrônico','3','3x57x80'),
		   ('Farinha de arroz',0,'Alimentos','2',null),
		   ('Fire Stick Amazon',0,'Eletrônico','3',null);
           
select * from produto;

show tables;

-- tabela terceiro --
desc terceiro;

-- idTerceiro, RazaoSocial, CNPJ, CPF, Localizacao, NomeFantasia, Contato
INSERT INTO terceiro(RazaoSocial, CNPJ, CPF, Localizacao, NomeFantasia, Contato)
       VALUES ('Tech eletronics', 123456789456321, null, 'Rio de Janeiro', null,219946287),
			  ('Botique Durgas',123456783,null,'Rio de Janeiro', null, 219567895),
			  ('Kids World',456789123654485,null,'São Paulo',null, 1198657484);
              
select * from terceiro;


-- tabela produto_estoque--
desc produto_estoque;

-- ProdEstoque_idProduto, ProdEstoque_idEstoque
ALTER TABLE produto AUTO_INCREMENT = 1;

insert into produto_estoque(ProdEstoque_idProduto, ProdEstoque_idEstoque)
      values (8,1),
              (9,2),
              (10,3),
              (11,4),
              (12,5),
              (13,6);

show tables;

-- tabela produto_pedido -- 
desc produto_pedido;

-- ProdPedido_idProduto, ProdPedido_idPedido, Quantidade, ProdStatus('Disponível','Sem Estoque')

insert into produto_pedido(ProdPedido_idProduto, ProdPedido_idPedido, Quantidade, ProdStatus)
     values (8, 1, 2, 'Sem Estoque'),
            (9, 2, 1, 'Sem Estoque'),
            (10, 3, 5, 'Disponível'),
            (11, 4, 3, 'Disponível');
            


-- tabela produto fornecedor 

desc produto_fornecedor;
-- ProdFornecedor_idFornecedor, ProdFornecedor_idProduto, Quantidade

insert INTO produto_fornecedor (ProdFornecedor_idFornecedor, ProdFornecedor_idProduto, Quantidade)
   VALUES  (1,8,500),
			(2,9,400),
			(3,10,633),
			(3,11,5),
			(2,12,10);
            

-- tabela produto vendedor 
desc produto_vendedor;

-- ProdVend_idTerceiro, ProdVend_idProduto, Quantidade

INSERT INTO produto_vendedor(ProdVend_idTerceiro, ProdVend_idProduto, Quantidade)
   VALUES (1,8,80),
		  (2,9,10);
          
select * from produto_vendedor;

show tables;


/*    PERGUNTAS DE NEGÓCIO/REALIZANDO QUERYS  */

-- RECUPERAÇOES COM SELECT e GROUP BY 
## Quantos clientes estão cadastrados? 6 clientes.  

SELECT * FROM CLIENTE;

## Quantos produtos existem para cada categoria suas categorias? 4 Eletronico, 1 Brinquedos, 1 Vestimenta, 1 Alimentos.
select count(Nome) AS QTDProdutos, Categoria
FROM PRODUTO
group by CATEGORIA;

-- FILTROS COM WHERE e LIKE: 

## Qual a quantidade de clientes comecando com a letra 'M'? 2 clientes, Maria e Matheu

select Pnome
from cliente
where Pnome LIKE 'M%';

## Quais pedidos com valor de frete maior que 50? 2 pedidos

select * 
from pedido 
where frete >50;

-- CRIAÇÃO DE EXPRESSÇOES PARA GERAR ATRIBUTOS DERIVADOS


## Calcular o valor total de avaliação do pedido com base na quantidade e nome produto.

select pp.ProdPedido_idPedido, pp.Quantidade, p.Avaliaçao, p.Nome,
(pp.Quantidade * p.Avaliaçao) AS ValorTotalPedido
from produto_pedido as pp 
JOIN produto as p ON pp.ProdPedido_idProduto = p.idProduto;


-- Definir ordenações dos dados com ORDER BY

## Ordenar os produtos pela avaliação de forma crescente.

SELECT idProduto, Nome, Avaliaçao
FROM PRODUTO
ORDER BY Avaliaçao ASC;


## Ordenar os clientes pelo sobrenome em ordem alfabética. 

SELECT Pnome,Sobrenome
from cliente
ORDER BY Sobrenome ASC;

-- Condições de filtros aos grupos – HAVING Statement

## Listar fornecedores com mais de 1 produto fornecido.

SELECT f.RazaoSocial, COUNT(pf.ProdFornecedor_idProduto) AS ProdutosFornecidos
FROM FORNECEDOR f
JOIN PRODUTO_FORNECEDOR pf ON f.idFornecedor = pf.ProdFornecedor_idFornecedor
GROUP BY f.idFornecedor
HAVING COUNT(pf.ProdFornecedor_idProduto) > 1;

--  Criação de junções entre tabelas para fornecer uma perspectiva mais complexa dos dados

#Obter todos os produtos e os fornecedores correspondentes.

SELECT p.Nome AS PRODUTO, f.RazaoSocial AS FORNECEDOR 
FROM produto as p 
JOIN produto_fornecedor as pf ON p.idProduto = pf.ProdFornecedor_idProduto
JOIN fornecedor as f ON f.idFornecedor = pf.ProdFornecedor_idFornecedor;



## Obter todos os pedidos, incluindo informações do cliente e o status do pedido.

SELECT p.idPedido, p.Descrição, p.StatusPedido, c.Pnome, c.Sobrenome
FROM PEDIDO p
JOIN CLIENTE c ON p.Pedido_idCliente = c.idCliente
ORDER BY p.StatusPedido;

##  Recuperar os produtos vendidos por um terceiro, com a quantidade disponível e o nome do fornecedor.

SELECT pv.ProdVend_idProduto, p.Nome, pv.Quantidade, f.RazaoSocial AS Fornecedor
FROM PRODUTO_VENDEDOR pv
JOIN PRODUTO p ON pv.ProdVend_idProduto = p.idProduto
JOIN PRODUTO_FORNECEDOR pf ON p.idProduto = pf.ProdFornecedor_idProduto
JOIN FORNECEDOR f ON pf.ProdFornecedor_idFornecedor = f.idFornecedor;





