-- Creación y uso de esquema "proyecto_final"
CREATE SCHEMA `proyecto_final`;

USE proyecto_final;

-- Creación de todas las tablas
CREATE TABLE
    disease (
        id_disease INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(45) NOT NULL
    );

CREATE TABLE
    medical_speciality (
        id_speciality INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(30) NOT NULL
    );

CREATE TABLE
    doctor (
        id_doctor INT PRIMARY KEY AUTO_INCREMENT,
        full_name VARCHAR(100) NOT NULL,
        age INT NOT NULL,
        sex VARCHAR(1) NOT NULL,
        id_speciality INT,
        FOREIGN KEY (id_speciality) REFERENCES medical_speciality (id_speciality)
    );

CREATE TABLE
    room (
        id_room INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(30) NOT NULL
    );

CREATE TABLE
    patient (
        id_patient INT PRIMARY KEY AUTO_INCREMENT,
        full_name VARCHAR(100) NOT NULL,
        age INT NOT NULL,
        sex VARCHAR(1) NOT NULL,
        id_assigned_room INT NULL,
        FOREIGN KEY (id_assigned_room) REFERENCES room (id_room)
    );

CREATE TABLE
    patient_diagnosis (
        id_patient INT,
        id_disease INT,
        date DATE NOT NULL,
        PRIMARY KEY (id_patient, id_disease),
        FOREIGN KEY (id_patient) REFERENCES patient (id_patient),
        FOREIGN KEY (id_disease) REFERENCES disease (id_disease)
    );

CREATE TABLE
    symptom (
        id_symptom INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(50) NOT NULL
    );

CREATE TABLE
    patient_symptom (
        id_patient INT,
        id_symptom INT,
        date DATE NOT NULL,
        PRIMARY KEY (id_patient, id_symptom),
        FOREIGN KEY (id_patient) REFERENCES patient (id_patient),
        FOREIGN KEY (id_symptom) REFERENCES symptom (id_symptom)
    );

CREATE TABLE
    medical_test (
        id_test INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(50) NOT NULL
    );

CREATE TABLE
    medicine (
        id_medicine INT PRIMARY KEY AUTO_INCREMENT,
        med_name VARCHAR(30) NOT NULL
    );

CREATE TABLE
    nurse (
        id_nurse INT PRIMARY KEY AUTO_INCREMENT,
        full_name VARCHAR(100) NOT NULL,
        age INT NOT NULL,
        sex VARCHAR(1) NOT NULL,
        id_assigned_room INT NOT NULL,
        FOREIGN KEY (id_assigned_room) REFERENCES room (id_room)
    );

CREATE TABLE
    turn (
        id_turn INT PRIMARY KEY AUTO_INCREMENT,
        id_patient INT,
        id_assigned_doctor INT,
        id_medicine INT,
        id_req_med_test INT,
        date DATE NOT NULL,
        FOREIGN KEY (id_patient) REFERENCES patient (id_patient),
        FOREIGN KEY (id_assigned_doctor) REFERENCES doctor (id_doctor),
        FOREIGN KEY (id_medicine) REFERENCES medicine (id_medicine),
        FOREIGN KEY (id_req_med_test) REFERENCES medical_test (id_test)
    );

CREATE TABLE
    audit_log_turn (
        id_turn INT PRIMARY KEY,
        id_patient INT NOT NULL,
        delete_date DATE NOT NULL
    );