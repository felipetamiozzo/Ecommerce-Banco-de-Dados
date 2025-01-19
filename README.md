# Ecommerce-Banco-de-Dados
Este repositório contém um projeto relacionado a criação de um modelo de banco de dados e o modelo lógico de um e-commerce.

# Modelo de Banco de Dados para E-commerce

Este repositório contém o modelo de diagrama e a implementação SQL de um banco de dados para um sistema de e-commerce. Ele foi projetado para gerenciar informações de clientes, produtos, fornecedores, pedidos, pagamentos e estoques, oferecendo uma solução escalável e bem estruturada.

## Estrutura do Repositório

- **`ecommerce.mwb`**: Arquivo do MySQL Workbench contendo o modelo ER (Entidade-Relacionamento) do banco de dados.
- **`script.sql`**: Script SQL para a criação das tabelas, relações e restrições do banco de dados.

## Descrição do Banco de Dados

O banco de dados é composto por diversas tabelas que representam as entidades e suas relações em um sistema de e-commerce.

### Tabelas e Atributos

#### 1. **CLIENTE**
- `idCliente` (PK): Identificador único do cliente.
- `Pnome`: Primeiro nome.
- `NomeInicialdoMeio`: Nome do meio.
- `Sobrenome`: Sobrenome.
- `CPF` (único): Número único de CPF.
- `Endereco`: Endereço do cliente.

#### 2. **PRODUTO**
- `idProduto` (PK): Identificador único do produto.
- `Nome`: Nome do produto.
- `Classificaçao_kids`: Indica se o produto é voltado para crianças.
- `Categoria`: Categoria do produto (Eletrônico, Vestimenta, Brinquedos, Alimentos).
- `Avaliaçao`: Avaliação média do produto.
- `Dimensao`: Dimensão do produto.

#### 3. **PEDIDO**
- `idPedido` (PK): Identificador único do pedido.
- `Pedido_idCliente` (FK): Referência ao cliente que realizou o pedido.
- `StatusPedido`: Status do pedido (Cancelado, Em processamento, Confirmado).
- `Descrição`: Descrição detalhada do pedido.
- `Frete`: Valor padrão de frete.

#### 4. **PAGAMENTO**
- `idPagamento` (PK): Identificador único do pagamento.
- `Pagamento_idCliente` (FK): Referência ao cliente que realizou o pagamento.
- `Valor`: Valor do pagamento.
- `TipoPagemento`: Método de pagamento (Boleto, Pix, Cartão).

#### 5. **ESTOQUE**
- `idEstoque` (PK): Identificador único do estoque.
- `Localizacao`: Localização do estoque.
- `Quantidade`: Quantidade disponível no estoque.

#### 6. **FORNECEDOR**
- `idFornecedor` (PK): Identificador único do fornecedor.
- `RazaoSocial`: Razão social do fornecedor.
- `CNPJ` (único): CNPJ do fornecedor.
- `Contato`: Contato do fornecedor.

#### 7. **TERCEIRO (VENDEDOR)**
- `idTerceiro` (PK): Identificador único do vendedor terceirizado.
- `RazaoSocial`: Razão social do vendedor.
- `CNPJ` (único): CNPJ do vendedor (se aplicável).
- `CPF` (único): CPF do vendedor (se aplicável).
- `Localizacao`: Localização do vendedor.
- `NomeFantasia`: Nome fantasia.
- `Contato`: Contato do vendedor.

#### 8. **PRODUTO_FORNECEDOR**
- Relaciona produtos e fornecedores.
- `ProdFornecedor_idFornecedor` (FK): Referência ao fornecedor.
- `ProdFornecedor_idProduto` (FK): Referência ao produto.
- `Quantidade`: Quantidade fornecida.

#### 9. **PRODUTO_VENDEDOR**
- Relaciona produtos e vendedores terceirizados.
- `ProdVend_idTerceiro` (FK): Referência ao vendedor.
- `ProdVend_idProduto` (FK): Referência ao produto.
- `Quantidade`: Quantidade vendida.

#### 10. **PRODUTO_ESTOQUE**
- Relaciona produtos e estoques.
- `ProdEstoque_idProduto` (FK): Referência ao produto.
- `ProdEstoque_idEstoque` (FK): Referência ao estoque.
- `Localizacao`: Localização no estoque.

#### 11. **PRODUTO_PEDIDO**
- Relaciona produtos e pedidos.
- `ProdPedido_idProduto` (FK): Referência ao produto.
- `ProdPedido_idPedido` (FK): Referência ao pedido.
- `Quantidade`: Quantidade do produto no pedido.
- `ProdStatus`: Status do produto (Disponível, Sem Estoque).

---

### Restrições e Relacionamentos

O banco de dados foi projetado com as seguintes restrições:
- **Chaves Primárias (PK)**: Garantem unicidade em cada tabela.
- **Chaves Estrangeiras (FK)**: Estabelecem relações entre tabelas, como:
  - `PEDIDO` → `CLIENTE`
  - `PAGAMENTO` → `CLIENTE`
  - `PRODUTO_FORNECEDOR` → `FORNECEDOR` e `PRODUTO`
  - `PRODUTO_VENDEDOR` → `TERCEIRO` e `PRODUTO`
  - `PRODUTO_ESTOQUE` → `PRODUTO` e `ESTOQUE`
  - `PRODUTO_PEDIDO` → `PRODUTO` e `PEDIDO`
- **Restrições Únicas**: Como CPF e CNPJ nas tabelas `CLIENTE`, `FORNECEDOR` e `TERCEIRO`.
- **Valores Padrão**: Aplicados em colunas como `Frete` em `PEDIDO` e `ProdStatus` em `PRODUTO_PEDIDO`.

## Como Utilizar

1. Abra o arquivo `ecommerce.mwb` no MySQL Workbench para visualizar o modelo do banco de dados.
2. Execute o script SQL `script.sql` para criar as tabelas no seu servidor MySQL:
   ```sql
   mysql -u [usuário] -p < script.sql
