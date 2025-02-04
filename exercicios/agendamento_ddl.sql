CREATE TABLE Pessoa (
  cpf VARCHAR(11) NOT NULL,
  email VARCHAR(50) NOT NULL,
  nome VARCHAR(150) NOT NULL,
  data_nasc DATE NOT NULL,
  endereço VARCHAR(300) NOT NULL,
  telefone varchar(15),
  CONSTRAINT cpf_pk PRIMARY KEY (cpf)
);

CREATE TABLE Medico (
  crm VARCHAR(10) NOT NULL,
  cpf_pessoa VARCHAR(11) NOT NULL,
  CONSTRAINT cpf_fk FOREIGN KEY (cpf_pessoa)
    REFERENCES Pessoa(cpf),
  CONSTRAINT crm_un UNIQUE (crm),
  CONSTRAINT medico_pk PRIMARY KEY (cpf_pessoa)
);

CREATE TABLE Paciente (
  cpf_pessoa VARCHAR(11) NOT NULL,
  senha VARCHAR(20) NOT NULL,
  plano_saude BOOLEAN NOT NULL DEFAULT FALSE,
  
  CONSTRAINT cpf_paciente_pk PRIMARY KEY (cpf_pessoa),
  CONSTRAINT cpf_paciente_fk FOREIGN KEY (cpf_pessoa)
    REFERENCES Pessoa(cpf)
);

CREATE TABLE Agendamento (
  cpf_paciente VARCHAR(11) NOT NULL,
  cpf_medico VARCHAR(11) NOT NULL,
  dh_consulta TIMESTAMP NOT NULL,
  dh_agendamento TIMESTAMP NOT NULL,
  valor_consulta FLOAT NOT NULL DEFAULT 0.0,
  CONSTRAINT ag_cpf_med_fk FOREIGN KEY (cpf_medico)
    REFERENCES Medico(cpf_pessoa),
  CONSTRAINT ag_cpf_pac_fk FOREIGN KEY (cpf_paciente)
    REFERENCES Paciente(cpf_pessoa),
  CONSTRAINT agendamento_pk PRIMARY KEY (cpf_medico, cpf_paciente, dh_consulta)
);

CREATE TABLE Especialidade (
  descricao VARCHAR(300) NOT NULL,
  id INT GENERATED ALWAYS AS IDENTITY,
  CONSTRAINT id_pk PRIMARY KEY (id)
);

CREATE TABLE MedicoEspecialidade (
  cpf_medico VARCHAR(11) NOT NULL,
  id_especialidade INT NOT NULL,
  CONSTRAINT esp_med_fk FOREIGN KEY (cpf_medico)
    REFERENCES Medico(cpf_pessoa),
  CONSTRAINT esp_fk FOREIGN KEY (id_especialidade)
    REFERENCES Especialidade(id),
  CONSTRAINT esp_med_pk PRIMARY KEY (cpf_medico,id_especialidade)
);

