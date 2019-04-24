DROP SCHEMA IF EXISTS locadoras CASCADE;


CREATE schema locadoras;

SET search_path to locadoras;

CREATE DOMAIN tel AS VARCHAR (15);

CREATE DOMAIN mail AS VARCHAR (45);


CREATE TABLE IF NOT EXISTS locadora (
  CNPJ VARCHAR(45) NOT NULL,
  nome VARCHAR(80) NOT NULL,
  rua VARCHAR(60) NOT NULL,
  cep VARCHAR(60) NOT NULL,
  num INT NOT NULL,
  bairro VARCHAR(60) NOT NULL,
   PRIMARY KEY (CNPJ)


);

CREATE TABLE IF NOT EXISTS telefone_locadora (
  locadora_CNPJ VARCHAR(45) NOT NULL,
  telefone tel NOT NULL  DEFAULT '',
  telefone2 tel NULL,
  telefone3 tel NULL,
   PRIMARY KEY (locadora_CNPJ, telefone),
   CONSTRAINT fk_telefones_locadora1 -- pode ser que der um erro, botar "fk_telefones_titular" no lugar.
      FOREIGN KEY (locadora_CNPJ)
      REFERENCES locadora (CNPJ)
      ON DELETE SET NULL
      ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS filme (
  titulo VARCHAR(45) NOT NULL,
  codigo VARCHAR(45) NOT NULL,
  locadora_CNPJ VARCHAR (45) NOT NULL,
  PRIMARY KEY (codigo),
  CONSTRAINT fk_filme_locadora1
  FOREIGN KEY (locadora_CNPJ)
  REFERENCES locadora(CNPJ)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION

);

CREATE INDEX fk_filme_locadora1_idx ON filme (locadora_CNPJ ASC); --pode ser um erro de sintaxe

CREATE TABLE IF NOT EXISTS funcionario (
  cpf VARCHAR(45) NOT NULL,
  locadora_CNPJ VARCHAR(45) NOT NULL,
  PRIMARY KEY (cpf),
  CONSTRAINT fk_funcionario_locadora1
  FOREIGN KEY (locadora_CNPJ)
  REFERENCES locadora (CNPJ)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
);

CREATE INDEX fk_funcionario_locadora1_idx ON funcionario (locadora_CNPJ ASC);

CREATE TABLE IF NOT EXISTS gerente (
  funcionario_cpf VARCHAR(45) NOT NULL,
  salario REAL NOT NULL,
  nome VARCHAR(45) NOT NULL,
  sobrenome VARCHAR(45) NOT NULL,
  rua VARCHAR(45) NOT NULL,
  cep VARCHAR(45) NOT NULL,
  num INT NOT NULL,
  PRIMARY KEY (funcionario_cpf),
  CONSTRAINT ck_salario CHECK (salario > 0),
  CONSTRAINT fk_gerente_funcionario1
  FOREIGN KEY (funcionario_cpf)
  REFERENCES funcionario(cpf)
  ON DELETE SET NULL
  ON UPDATE CASCADE
);

CREATE INDEX fk_gerente_funcionario1_idx ON gerente(funcionario_cpf ASC);

CREATE TABLE IF NOT EXISTS telefone_gerente (
  gerente_funcionario_cpf VARCHAR(45) NOT NULL,
  telefone tel NOT NULL  DEFAULT '',
  telefone2 tel NULL,
  telefone3 tel NULL,
  PRIMARY KEY (gerente_funcionario_cpf, telefone),
  CONSTRAINT fk_telefones_gerente1
  FOREIGN KEY (gerente_funcionario_cpf)
  REFERENCES gerente(funcionario_cpf)
  ON DELETE SET NULL
  ON UPDATE CASCADE

); -- Tabelas com o mesmo nome que são criadas usando o "if not exists" podem dar erro.

CREATE INDEX fk_telefones_gerente1_idx ON telefone_gerente (gerente_funcionario_cpf ASC);

CREATE TABLE IF NOT EXISTS emails_gerente (
  gerente_funcionario_cpf VARCHAR(45) NOT NULL,
  email mail NOT NULL  DEFAULT '',
  email2 mail NULL,
  email3 mail NULL,
  PRIMARY KEY (gerente_funcionario_cpf, email),
  CONSTRAINT fk_emails_gerente1
  FOREIGN KEY (gerente_funcionario_cpf)
  REFERENCES gerente(funcionario_cpf)
  ON DELETE SET NULL
  ON UPDATE CASCADE
);

CREATE INDEX fk_emails_gerente1_idx ON emails_gerente(gerente_funcionario_cpf ASC);

CREATE TABLE IF NOT EXISTS  estoquista (
  funcionario_cpf VARCHAR(45) NOT NULL,
  salario REAL NOT NULL,
  nome VARCHAR(45) NOT NULL,
  sobrenome VARCHAR(45) NOT NULL,
  rua VARCHAR(45) NOT NULL,
  cep VARCHAR(45) NOT NULL,
  num INT NOT NULL,
  PRIMARY KEY (funcionario_cpf),
  CONSTRAINT ck_salario CHECK (salario > 0),
  CONSTRAINT fk_estoquista_funcionario1
  FOREIGN KEY (funcionario_cpf)
  REFERENCES funcionario(cpf)
  ON DELETE SET NULL
  ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS caixa (
  funcionario_CPF VARCHAR(45) NOT NULL,
  salario REAL NOT NULL,
  nome VARCHAR(45) NOT NULL,
  sobrenome VARCHAR(45) NOT NULL,
  rua VARCHAR(45) NOT NULL,
  cep VARCHAR(45) NOT NULL,
  num INT NOT NULL,
  PRIMARY KEY (funcionario_cpf),
  CONSTRAINT ck_salario CHECK (salario > 0),
  CONSTRAINT fk_estoquista_funcionario10
    FOREIGN KEY (funcionario_cpf)
    REFERENCES funcionario (cpf)
    ON DELETE SET NULL
    ON UPDATE CASCADE
  );

  CREATE TABLE IF NOT EXISTS emails_estoquista (
    estoquista_funcionario_cpf VARCHAR(45) NOT NULL,
    email mail NOT NULL DEFAULT '',
    email2 mail NULL,
    email3 mail NULL,
    PRIMARY KEY (estoquista_funcionario_cpf, email),
    CONSTRAINT fk_emails_copy1_estoquista1
      FOREIGN KEY (estoquista_funcionario_cpf)
      REFERENCES estoquista ( funcionario_cpf)
      ON DELETE SET NULL
      ON UPDATE CASCADE
    );


    CREATE INDEX fk_emails_copy1_estoquista1_idx ON emails_estoquista (estoquista_funcionario_cpf ASC);

    CREATE TABLE IF NOT EXISTS telefone_estoquista (
      estoquista_funcionario_cpf VARCHAR(45) NOT NULL,
      telefone tel NOT NULL DEFAULT '',
      telefone2 tel NULL,
      telefone3 tel NULL,
      PRIMARY KEY (estoquista_funcionario_cpf, telefone),
      CONSTRAINT fk_telefones_copy1_estoquista1
        FOREIGN KEY (estoquista_funcionario_cpf)
        REFERENCES estoquista (funcionario_cpf)
        ON DELETE SET NULL
        ON UPDATE CASCADE
      );


    CREATE INDEX fk_telefones_copy1_estoquista1_idx ON telefone_estoquista (estoquista_funcionario_cpf ASC);


    CREATE TABLE IF NOT EXISTS emails_caixa (
      caixa_funcionario_cpf VARCHAR(45) NOT NULL,
      email mail NOT NULL  DEFAULT '',
      email2 mail NULL,
      email3 mail NULL,
      PRIMARY KEY (caixa_funcionario_cpf, email),
      CONSTRAINT fk_emails_caixa1
        FOREIGN KEY (caixa_funcionario_cpf)
        REFERENCES caixa (funcionario_cpf)
        ON DELETE SET NULL
        ON UPDATE CASCADE
      );


    CREATE INDEX fk_emails_caixa1_idx ON emails_caixa ( caixa_funcionario_cpf ASC);


    CREATE TABLE IF NOT EXISTS telefone_caixa (
    caixa_funcionario_cpf VARCHAR(45) NOT NULL,
    telefone tel NOT NULL  DEFAULT '',
    telefone2 tel NULL,
    telefone3 tel NULL,
    PRIMARY KEY (caixa_funcionario_cpf, telefone),
    CONSTRAINT fk_telefones_caixa1
      FOREIGN KEY (caixa_funcionario_cpf)
      REFERENCES caixa (funcionario_cpf)
      ON DELETE SET NULL
      ON UPDATE CASCADE
    );


  CREATE INDEX fk_telefones_caixa1_idx ON telefone_caixa (caixa_funcionario_cpf ASC);

  CREATE TABLE IF NOT EXISTS copia (
  filme_codigo VARCHAR(45) NOT NULL,
  filme_titulo VARCHAR(45) NOT NULL,
  quantidade INT  NOT NULL,
  data_emprestimo DATE NULL ,
  data_devolucao DATE NULL ,
  PRIMARY KEY (filme_codigo),
  CONSTRAINT ck_quantidade CHECK (quantidade >= 0),
  CONSTRAINT fk_copia_filme1
    FOREIGN KEY ( filme_codigo)
    REFERENCES filme ( codigo)
    ON DELETE SET NULL
    ON UPDATE CASCADE
  );

CREATE INDEX fk_copia_filme1_idx ON copia (filme_titulo ASC, filme_codigo ASC);

CREATE TABLE IF NOT EXISTS cliente (
cpf VARCHAR(45) NOT NULL,
PRIMARY KEY (cpf)
);





CREATE TABLE IF NOT EXISTS dependente (
  cliente_cpf VARCHAR(45) NOT NULL,
  cpfdp VARCHAR(45) NOT NULL,
  nome VARCHAR(45) NOT NULL,
  sobrenome VARCHAR (45) NOT NULL,
  PRIMARY KEY (cpfdp),
  CONSTRAINT fk_dependente_cliente1
    FOREIGN KEY (cliente_cpf)
    REFERENCES cliente (cpf)
    ON DELETE SET NULL
    ON UPDATE CASCADE
  );




  CREATE TABLE IF NOT EXISTS titular (
    cliente_cpf VARCHAR(45) NOT NULL,
    nome VARCHAR(45) NULL,
    sobrenome VARCHAR(45) NULL,
    PRIMARY KEY (cliente_cpf),
    CONSTRAINT fk_titular_cliente1
      FOREIGN KEY (cliente_cpf)
      REFERENCES cliente (cpf)
      ON DELETE SET NULL
      ON UPDATE CASCADE

    );

  CREATE INDEX fk_titular_cliente1_idx ON titular (cliente_cpf ASC);


  CREATE TABLE IF NOT EXISTS telefone_dependente (
  dependente_cpfdp VARCHAR(45) NOT NULL,
  telefone VARCHAR(45) NOT NULL,
  telefone2 VARCHAR(45) NULL,
  telefone3 VARCHAR(45) NULL,
  PRIMARY KEY (dependente_cpfdp, telefone),
  CONSTRAINT fk_telefones_dependente1
    FOREIGN KEY (dependente_cpfdp)
    REFERENCES dependente (cpfdp)
    ON DELETE SET NULL
    ON UPDATE CASCADE
  );

CREATE INDEX fk_telefones_dependente1_idx ON telefone_dependente (dependente_cpfdp ASC);


CREATE TABLE IF NOT EXISTS emails_dependente (
  dependente_cpfdp VARCHAR(45) NOT NULL,
  email VARCHAR(45) NOT NULL,
  email2 VARCHAR(45) NULL,
  email3 VARCHAR(45) NULL,
  PRIMARY KEY (dependente_cpfdp, email),
  CONSTRAINT fk_emails_dependente1
    FOREIGN KEY (dependente_cpfdp)
    REFERENCES dependente (cpfdp)
    ON DELETE SET NULL
    ON UPDATE CASCADE
  );

CREATE INDEX fk_emails_dependente1_idx ON emails_dependente (dependente_cpfdp ASC);

CREATE TABLE IF NOT EXISTS emails_titular (
  titular_cliente_cpf VARCHAR(45) NOT NULL,
  email mail NOT NULL DEFAULT '',
  email2 mail NULL,
  email3 mail NULL,
  PRIMARY KEY (titular_cliente_cpf, email),
  CONSTRAINT fk_emails_titular1
    FOREIGN KEY (titular_cliente_cpf)
    REFERENCES titular (cliente_cpf)
    ON DELETE SET NULL
    ON UPDATE CASCADE
  );

CREATE INDEX fk_emails_titular1_idx ON emails_titular (titular_cliente_cpf ASC);


CREATE TABLE IF NOT EXISTS telefone_titular (
  titular_cliente_cpf VARCHAR(45) NOT NULL,
  telefone tel NOT NULL DEFAULT '',
  telefone2 tel NULL,
  telefone3 tel NULL,
  PRIMARY KEY (titular_cliente_cpf, telefone),
  CONSTRAINT fk_telefones_titular1
    FOREIGN KEY (titular_cliente_cpf)
    REFERENCES titular (cliente_cpf)
    ON DELETE SET NULL
    ON UPDATE CASCADE
  );

CREATE INDEX fk_telefones_titular1_idx ON telefone_titular (titular_cliente_cpf ASC);

CREATE TABLE IF NOT EXISTS emprestimo (
  id VARCHAR(45) NOT NULL,
  copia_filme_codigo VARCHAR(45) NOT NULL,
  cliente_cpf VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_emprestimo_copia1
    FOREIGN KEY (copia_filme_codigo)
    REFERENCES copia (filme_Codigo)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT fk_emprestimo_cliente1
    FOREIGN KEY (cliente_cpf)
    REFERENCES cliente (cpf)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
  );

CREATE INDEX fk_emprestimo_copia1_idx ON emprestimo (copia_filme_codigo ASC);

CREATE INDEX fk_emprestimo_cliente1_idx ON emprestimo (cliente_cpf ASC);
