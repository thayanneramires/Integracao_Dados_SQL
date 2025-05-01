-- ESTRUTURA DE DADOS

CREATE TABLE public.venda(
	venda_id int8 NOT NULL,
	data_emissao date NOT NULL,
	horariomov varchar(8) DEFAULT '00:00:00'::character varying NOT NULL,
	produto_id varchar(25) DEFAULT ''::character varying NOT NULL,
	qtde_vendida float8 NULL,
	valor_unitario numeric(12, 4) DEFAULT 0 NOT NULL,
	filial_id int8 DEFAULT 1 NOT NULL,
	item int4 DEFAULT 0 NOT NULL,
	unidade_medida varchar(3) NULL,
	CONSTRAINT pk_consumo PRIMARY KEY (filial_id, venda_id, data_emissao, produto_id, item, horariomov)
);


CREATE TABLE public.pedido_compra(
	pedido_id float8 DEFAULT 0 NOT NULL,
	data_pedido date NULL,
	item float8 DEFAULT 0 NOT NULL,
	produto_id varchar(25) DEFAULT '0' NOT NULL,
	descricao_produto varchar(255) NULL,
	ordem_compra float8 DEFAULT 0 NOT NULL,
	qtde_pedida float8 NULL,
	filial_id int4 NULL,
	data_entrega date NULL,
	qtde_entregue float8 DEFAULT 0 NOT NULL,
	qtde_pendente float8 DEFAULT 0 NOT NULL,
	preco_compra float8 DEFAULT 0 NULL,
	fornecedor_id int4 DEFAULT 0 NULL,
	CONSTRAINT pedido_compra_pkey PRIMARY KEY (pedido_id , produto_id, item),
	CONSTRAINT uq_ordem_compra UNIQUE (ordem_compra)
);


CREATE TABLE public.entradas_mercadoria (
	data_entrada date NULL,
	nro_nfe varchar(255) NOT NULL,
	ordem_compra float8 DEFAULT 0 NOT NULL,
	item float8 DEFAULT 0 NOT NULL,
	produto_id varchar(25) DEFAULT '0' NOT NULL,
	descricao_produto varchar(255) NULL,
	qtde_recebida float8 NULL,
	filial_id int4 NULL,
	custo_unitario numeric(12, 4) DEFAULT 0 NOT NULL,
	CONSTRAINT entradas_mercadoria_pkey PRIMARY KEY (ordem_compra, item, produto_id, nro_nfe)
);

-- INSERIR DADOS

INSERT INTO public.venda (venda_id, data_emissao, horariomov, produto_id, qtde_vendida, valor_unitario, filial_id, item, unidade_medida)
VALUES 
(1001, '2025-01-01', '08:30:00', 'PROD001', 2.0, 15.5000, 1, 1, 'UN'),
(1001, '2025-01-01', '08:35:00', 'PROD002', 1.0, 120.0000, 1, 2, 'CX'),
(1002, '2025-01-02', '09:10:00', 'PROD003', 3.5, 8.9900, 1, 1, 'KG'),
(1003, '2025-01-03', '10:45:00', 'PROD004', 0.5, 300.0000, 1, 1, 'LT'),
(1003, '2025-01-03', '10:50:00', 'PROD005', 5.0, 50.2500, 1, 2, 'UN'),
(1004, '2025-01-04', '11:15:00', 'PROD006', 1.2, 33.3300, 1, 1, 'M'),
(1005, '2025-01-05', '12:00:00', 'PROD007', 10.0, 2.5000, 1, 1, 'UN'),
(1006, '2025-01-06', '14:20:00', 'PROD008', 0.75, 200.0000, 1, 1, 'PC'),
(1007, '2025-01-07', '15:45:00', 'PROD009', 2.2, 17.4700, 1, 1, 'KG'),
(1008, '2025-01-08', '16:30:00', 'PROD010', 1.0, 99.9900, 1, 1, 'UN'),
(1010, '2025-02-05', '09:00:00', 'PROD001', 3.0, 15.5000, 1, 1, 'UN'),
(1011, '2025-02-10', '10:00:00', 'PROD002', 2.0, 120.0000, 1, 1, 'CX'),
(1012, '2025-02-15', '11:00:00', 'PROD003', 1.5, 8.9900, 1, 1, 'KG'),
(1013, '2025-02-20', '12:00:00', 'PROD001', 1.0, 15.5000, 1, 2, 'UN');


INSERT INTO public.pedido_compra (pedido_id, data_pedido, item, produto_id, descricao_produto, ordem_compra, qtde_pedida, filial_id, data_entrega, qtde_entregue, qtde_pendente, preco_compra, fornecedor_id)
VALUES
(5001, '2025-01-01', 1, 'PROD001', 'Produto 001 - Unidade', 10001, 5.0, 1, '2025-01-03', 2.0, 3.0, 14.00, 101),
(5002, '2025-01-01', 1, 'PROD002', 'Produto 002 - Caixa', 10002, 3.0, 1, '2025-01-04', 1.0, 2.0, 110.00, 102),
(5003, '2025-01-02', 1, 'PROD003', 'Produto 003 - Quilo', 10003, 10.0, 1, '2025-01-05', 4.0, 6.0, 8.00, 103),
(5004, '2025-01-02', 1, 'PROD004', 'Produto 004 - Litro', 10004, 1.0, 1, '2025-01-05', 0.5, 0.5, 290.00, 104),
(5005, '2025-01-03', 1, 'PROD005', 'Produto 005 - Unidade', 10005, 6.0, 1, '2025-01-06', 5.0, 1.0, 48.00, 105),
(5006, '2025-01-03', 1, 'PROD006', 'Produto 006 - Metro', 10006, 2.0, 1, '2025-01-07', 1.2, 0.8, 30.00, 106),
(5007, '2025-01-04', 1, 'PROD007', 'Produto 007 - Unidade', 10007, 12.0, 1, '2025-01-08', 10.0, 2.0, 2.00, 107),
(5008, '2025-01-05', 1, 'PROD008', 'Produto 008 - Peça', 10008, 1.0, 1, '2025-01-09', 0.75, 0.25, 195.00, 108),
(5009, '2025-01-06', 1, 'PROD009', 'Produto 009 - Quilo', 10009, 3.0, 1, '2025-01-10', 2.2, 0.8, 16.50, 109),
(5010, '2025-01-07', 1, 'PROD010', 'Produto 010 - Unidade', 10010, 2.0, 1, '2025-01-11', 1.0, 1.0, 95.00, 110),
(5011, '2025-02-03', 1, 'PROD011', 'Produto 011 - Unidade', 10011, 10.0, 1, '2025-02-10', 5.0, 5.0, 20.00, 111),
(5012, '2025-02-04', 1, 'PROD012', 'Produto 012 - Quilo', 10012, 7.0, 1, '2025-02-12', 0.0, 7.0, 18.00, 112),
(5013, '2025-02-05', 1, 'PROD013', 'Produto 013 - Peça', 10013, 6.0, 1, '2025-02-15', 0.0, 6.0, 25.00, 113);


INSERT INTO public.entradas_mercadoria (data_entrada, nro_nfe, ordem_compra, item, produto_id, descricao_produto, qtde_recebida, filial_id, custo_unitario)
VALUES
('2025-01-03', 'NFE10001', 10001, 1, 'PROD001', 'Produto 001 - Unidade', 2.0, 1, 14.0000),
('2025-01-04', 'NFE10002', 10002, 1, 'PROD002', 'Produto 002 - Caixa', 1.0, 1, 110.0000),
('2025-01-05', 'NFE10003', 10003, 1, 'PROD003', 'Produto 003 - Quilo', 4.0, 1, 8.0000),
('2025-01-06', 'NFE10004', 10004, 1, 'PROD004', 'Produto 004 - Litro', 0.5, 1, 290.0000),
('2025-01-07', 'NFE10005', 10005, 1, 'PROD005', 'Produto 005 - Unidade', 5.0, 1, 48.0000),
('2025-01-08', 'NFE10006', 10006, 1, 'PROD006', 'Produto 006 - Metro', 1.2, 1, 30.0000),
('2025-01-09', 'NFE10007', 10007, 1, 'PROD007', 'Produto 007 - Unidade', 10.0, 1, 2.0000),
('2025-01-10', 'NFE10008', 10008, 1, 'PROD008', 'Produto 008 - Peça', 0.75, 1, 195.0000),
('2025-01-11', 'NFE10009', 10009, 1, 'PROD009', 'Produto 009 - Quilo', 2.2, 1, 16.5000),
('2025-01-12', 'NFE10010', 10010, 1, 'PROD010', 'Produto 010 - Unidade', 1.0, 1, 95.0000),
('2025-02-10', 'NFE10011', 10011, 1, 'PROD011', 'Produto 011 - Unidade', 5.0, 1, 20.0000);


-- ESTABELECENDO RELACAO ENTRE ENTRADAS_MERCADORIA E PEDIDO_COMPRA POR ORDEM_COMPRA

ALTER TABLE public.entradas_mercadoria
ADD CONSTRAINT fk_entrada_ordem_compra
FOREIGN KEY (ordem_compra)
REFERENCES public.pedido_compra (ordem_compra);
