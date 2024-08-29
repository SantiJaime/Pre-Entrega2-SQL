USE proyecto_final;

CREATE VIEW all_doctors_view AS
	SELECT d.full_name AS nombre_completo, d.age AS edad, d.sex AS sexo, m_s.name AS especialidad_medica
    FROM doctor d
    LEFT JOIN medical_speciality m_s ON (d.id_speciality = m_s.id_speciality);

CREATE VIEW male_doctors_view AS
	SELECT d.full_name AS nombre_completo, d.age AS edad, d.sex AS sexo, m_s.name AS especialidad_medica
    FROM doctor d
    LEFT JOIN medical_speciality m_s ON (d.id_speciality = m_s.id_speciality)
    WHERE sex = "H";

CREATE VIEW female_doctors_view AS
	SELECT d.full_name AS nombre_completo, d.age AS edad, d.sex AS sexo, m_s.name AS especialidad_medica
    FROM doctor d
    LEFT JOIN medical_speciality m_s ON (d.id_speciality = m_s.id_speciality)
    WHERE sex = "M";

CREATE VIEW basic_patients_view AS
	SELECT p.full_name AS nombre_completo, p.age AS edad, sex AS sexo, r.name
    FROM patient p
    LEFT JOIN room r ON (p.id_assigned_room = r.id_room);
    
CREATE VIEW adult_patients_view AS
	SELECT p.full_name AS nombre_completo, p.age AS edad, sex AS sexo, r.name
    FROM patient p
    LEFT JOIN room r ON (p.id_assigned_room = r.id_room)
    WHERE age >= 18;

CREATE VIEW number_patient_by_sex_view AS
	SELECT sex AS sexo, COUNT(*) AS cantidad_pacientes
    FROM patient
    GROUP BY sex;
    
CREATE VIEW patients_per_room_view AS
	SELECT r.name AS nombre_sala, COUNT(DISTINCT id_assigned_room) AS cantidad_pacientes
    FROM patient p
    LEFT JOIN room r ON (p.id_assigned_room = r.id_room)
    GROUP BY r.name;
    
CREATE VIEW nurses_view AS
	SELECT n.full_name AS nombre, n.age AS edad, n.sex AS sexo, r.name AS sala_asignada
    FROM nurse n
    LEFT JOIN room r ON (n.id_assigned_room = r.id_room);
    
CREATE VIEW patients_diagnosis_view AS
	SELECT p.full_name AS nombre_paciente, ds.name AS diagnostico, pd.date AS fecha_diagnostico
    FROM patient_diagnosis pd
    LEFT JOIN patient p ON (p.id_patient = pd.id_patient)
    LEFT JOIN disease ds ON (ds.id_disease = pd.id_disease);

CREATE VIEW patients_symptom_view AS
	SELECT p.full_name AS nombre_paciente,
		GROUP_CONCAT(s.name ORDER BY s.name SEPARATOR ', ') AS sintomas,
		ps.date AS fecha_aparicion_sintomas
	FROM patient_symptom ps
	LEFT JOIN patient p ON p.id_patient = ps.id_patient
	LEFT JOIN symptom s ON ps.id_symptom = s.id_symptom
	GROUP BY p.full_name, ps.date;

CREATE VIEW turns_info_view AS
	SELECT p.full_name AS nombre_paciente, d.full_name AS nombre_medico_asignado,
	m.med_name AS nombre_medicina_recetada, mt.name AS estudio_medico
    FROM turn t
    LEFT JOIN patient p ON (p.id_patient = t.id_patient)
    LEFT JOIN doctor d ON (d.id_doctor = t.id_assigned_doctor)
    LEFT JOIN medicine m ON (m.id_medicine = t.id_medicine)
    LEFT JOIN medical_test mt ON (mt.id_test = t.id_req_med_test);