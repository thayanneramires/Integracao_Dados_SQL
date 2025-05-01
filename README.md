# Integração de Dados

Este projeto tem como objetivo demonstrar o consumo e a integração de dados no PostgreSQL, além de abordar as etapas de transformação de dados (ETL) e validação de estratégias em conjunto com o cliente.

![case_banco - public](https://github.com/user-attachments/assets/abd95d81-4220-43ce-8aec-5c4b8526889f)

O arquivo SQL `case_banco.sql` foi utilizado tanto para criar a estrutura das tabelas, por meio de comandos CREATE, quanto para inserir dados nelas, utilizando comandos INSERT, preenchendo assim o banco de dados inicialmente vazio.

## Parte 1 – Consultas SQL

### 1.1 – Consumo por produto e mês
````
-- Total de consumo de cada produto no mês de fevereiro de 2025
select
	TO_CHAR(data_emissao, 'MM/YYYY') as MES,
	PRODUTO_ID,
	SUM(QTDE_VENDIDA) TOTAL_CONSUMO
from VENDA
where DATA_EMISSAO between '2025-02-01' and '2025-02-28'
group by MES, PRODUTO_ID
order by TOTAL_CONSUMO DESC
````
![image](https://github.com/user-attachments/assets/71f09d03-be91-412f-97a4-f7f052247384)

### 1.2 – Produtos com requisição pendente
````
-- Produtos que foram requisitados, mas não recebidos
select 
	PRODUTO_ID,
	DESCRICAO_PRODUTO,
	QTDE_PEDIDA,
	QTDE_ENTREGUE,
	QTDE_PENDENTE
from PEDIDO_COMPRA
where QTDE_PENDENTE > 0
order by QTDE_PENDENTE DESC;
````
![image](https://github.com/user-attachments/assets/06843a30-925b-4eac-bb97-c148cf4846c6)

### 1.3 – Produtos não consumidos e não recebidos

````
-- Produtos que foram requisitados, mas não consumidos e não recebidos, no mês de fevereiro de 2025
SELECT 
	P.PRODUTO_ID, 
	P.DESCRICAO_PRODUTO,
	P.QTDE_PEDIDA,
	coalesce(V.QTDE_VENDIDA,0) as QTDE_VENDIDA,
	coalesce(E.QTDE_RECEBIDA, 0) as QTDE_RECEBIDA
from PEDIDO_COMPRA P
left join VENDA V 
	on P.PRODUTO_ID = V.PRODUTO_ID
	and to_char(V.DATA_EMISSAO, 'MM-YYYY') = '02-2025'
left join ENTRADAS_MERCADORIA E 
	on P.PRODUTO_ID = E.PRODUTO_ID
	and to_char(E.DATA_ENTRADA,'MM-YYYY') = '02-2025'
where to_char(P.DATA_PEDIDO, 'MM-YYYY') = '02-2025'
	and V.PRODUTO_ID is null
	and E.PRODUTO_ID is null;
````
![image](https://github.com/user-attachments/assets/35257c21-7f3a-4593-b424-a3db0dccc12a)

## Parte 2 – Transformações de Dados para Pedidos de Compra e Venda

1. Concatenar os campos produto_id e descricao_produto (onde houver) no formato;
2. Transformar o campo de datas para o formato `DD/MM/YYYY`;
3. Retornar os dados filtrando apenas os produtos requisitados mais de 10 vezes no período.

````
-- Transformações para Pedidos de Compra
select 
	produto_id ||' - '|| descricao_produto as Produto,
	qtde_pedida as Qtde_Requisitada,
	to_char(data_pedido, 'DD/MM/YYYY') as Data_Solicitacao
from pedido_compra
where qtde_pedida > 10
````
![image](https://github.com/user-attachments/assets/bb028418-3503-4589-929c-f9d3ecf7801b)

````
-- Transformações para Pedidos de Venda
select 
	produto_id ||' - '|| unidade_medida as Produto,
	qtde_vendida as Qtde_Requisitada,
	to_char(data_emissao, 'DD/MM/YYYY') as Data_Solicitacao
from venda
where qtde_vendida > 10;
````
![image](https://github.com/user-attachments/assets/7045b5e1-60d4-429b-ba1b-63aa38924f33)

## Parte 3 – Estratégia de Validação com o Cliente

Imaginando que é preciso validar os dados do mês de Fevereiro de 2025 com o cliente:

1. Quais seriam os principais pontos que você validaria com o cliente?
   
   • Podutos mais vendidos e menos vendidos
   
   • Quantidade e Custo de mercadorias que entraram
   
   • Produtos com requisição pendente
   
   • Pedidos de compra de produtos sem vendas
   
3. Quais técnicas utilizaria para garantir a exatidão e a precisão dos dados?

   • Comparar diretamente com as rotinas do ERP do Cliente
   
   • Comparar com planilhas de controle manual do cliente
   
   • Alinhar com o cliente se os dados refletem a realidade
   
4. Quais consultas você deixaria prontas para usar na reunião de validação?
   
   • Consulta de resumo de vendas por produto em fevereiro, contendo o total de vendas (distinct count de venda_id), qtde_vendida, valor_unitario , faturamento (qtde_vendida * valor_unitario ) e ticket médio (faturamento/ total de vendas)
   
   • Consulta de entrada de produtos em fevereiro, exibindo tanto a quantidade recebida quanto o custo
   
   • Conculta de resumo de pedidos de compra, contendo a qtde_pedida, qtde_entregue, qtde_pendente e data da última entrega
   
   • Consulta de produtos que foram requisitados, mas não consumidos
   
   • Consulta de com valores de entrada e saída de produtos por mês

   
