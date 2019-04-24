Set search_path to locadoras;

INSERT INTO cliente values ('012345');
INSERT INTO titular values ('012345','titular0123', 'titu0123');
INSERT INTO telefone_titular values ('012345', '123456789');
INSERT INTO emails_titular values ('012345', 'titu123@gmail.com')

select* from caixa
select * from copia
select * from titular

1-- listar todos os dependentes

select * from dependente

2--Maior salario dos caixas

Select nome,max(salario) from caixa
Group by nome

3-- junta filme com copia pela chave estrangeira

select * from filme join copia on(filme.codigo = copia.filme_codigo)

4-- retorna o titulo dos filmes que tem mais de 2 copias.

select filme_titulo,quantidade
from copia
Group by filme_titulo, quantidade having quantidade > 2

5-- Junta as tabelas telefone e emails titular á tabela titular
select *
from telefone_titular
join emails_titular using (titular_cliente_cpf) NATURAL JOIN titular
order by nome

6-- listando titulares que não possuem dependentes
select * from dependente d right outer join titular t
on (d.cliente_cpf = t.cliente_cpf)
where cpfdp is null

7-- descobre todos os emprestimos no cpf de um titular especifico
select id from emprestimo where cliente_cpf like '%6'



--PROVA

--3
--a
CREATE TABLE Usuario (
  id_usuario INT,
  nome varchar(30),
  sobrenome varchar(30),
  idade int,
  produtor_favorito int,
  PRIMARY KEY (id_usuario)
  FOREIGN KEY (produtor_favorito)
  REFERENCES produtor (id_produto)

select nome
from produtor
where(cod_empresa = 1)


--b
select nome, sobrenome from Usuario
where idade > 18 and produtor_favorito = 'produtor x'

--c
select nome
from produtor outer join Usuario
on (produtor.id_produtor = usuario.produtor_favorito)

--d
select nome, avg(salario)
from empresa e join produtor p using(cod_empresa)
where avg(salario) > 3000


--e
select t_produtor.idp, t_produtor.pm_estrelas ,t_produtor.p_empresa, avg(nr_estrelas) as em_estrelas
from (select p.id_produtor as idp, avg(p.nr_estrelas) as pm_estrelas, p.cod_empresa as p_empresa as pm_estrelas
from produtor p ) join (conteudo join like using (id_conteudo)) using (id_produtor)) as t_produtor

--h
select titulo from tema
where descricao ilike 'banco de dados___'
