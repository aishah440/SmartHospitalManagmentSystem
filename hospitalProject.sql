-- USERS TABLE
CREATE TABLE users (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    userType ENUM('Doctor', 'Patient', 'Admin') NOT NULL
);

INSERT INTO users (id, name, password, userType) VALUES ('9', 'Fahad Al-Qahtani', 'fahad456', 'Patient'),
('10', 'Reem Al-Sabah', 'reem789', 'Patient'),
('8', 'Noura Al-Fayez', 'noura123', 'Patient'), ('5', 'Dr. Aisha Al-Harbi', 'aisha123', 'Doctor'),
('6', 'Dr. Omar Al-Fahad', 'omar123', 'Doctor'),
('7', 'Dr. Sara Al-Qassim', 'sara123', 'Doctor'),
('4', 'Raghad', 'rgh123', 'Admin'),('3', 'Raghad', 'rg123', 'Patient'),('2', 'lama', 'lama23', 'Doctor'),('1', 'aeshah', 'aeshahal4', 'Admin');

CREATE TABLE admins (
    admin_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    FOREIGN KEY (admin_id) REFERENCES users(id)
);

-- DOCTORS TABLE
CREATE TABLE doctors (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    FOREIGN KEY (id) REFERENCES users(id)
);


INSERT INTO doctors (id, name, specialization) VALUES ('2', 'Dr. Lama', 'Dermatology'),
('5', 'Dr. Aisha Al-Harbi', 'Cardiology'),
('6', 'Dr. Omar Al-Fahad', 'Neurology'),
('7', 'Dr. Sara Al-Qassim', 'Pediatrics');

-- PATIENTS TABLE
CREATE TABLE patients (
    patient_id VARCHAR(50) PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    medical_condition TEXT,
    current_medications TEXT,
    FOREIGN KEY (patient_id) REFERENCES users(id)
);
INSERT INTO patients (patient_id, patient_name, medical_condition, current_medications) VALUES
('3', 'Raghad', 'Seasonal allergies', 'Cetirizine'),
('8', 'Noura Al-Fayez', 'Hypertension', 'Amlodipine'),
('9', 'Fahad Al-Qahtani', 'Type 2 Diabetes', 'Insulin and Metformin'),
('10', 'Reem Al-Sabah', 'Migraine', 'Sumatriptan as needed');

-- LOGGED USERS TABLE
CREATE TABLE logged_users (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    id VARCHAR(50),
    name VARCHAR(100),
    userType ENUM('Doctor', 'Patient', 'Admin'),
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM logged_users ORDER BY login_time DESC;
-- EMERGENCY ALERTS
CREATE TABLE emergency_alerts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    alert_type VARCHAR(255),
    message TEXT,
    reportDate DATE
);

INSERT INTO emergency_alerts (alert_type, message, reportDate) VALUES
('Code Blue', 'Patient collapsed in Room 301. Immediate resuscitation needed.', '2025-04-15'),
('Fire Drill', 'Fire alarm triggered. Evacuate the building immediately.', '2025-04-16'),
('System Outage', 'Hospital system temporarily offline. Use paper records.', '2025-04-17'),
('Medical Supply Shortage', 'Low inventory on insulin. Notify pharmacy.', '2025-04-18'),
('Critical Lab Result', 'Urgent: Blood report of Patient P002 indicates severe abnormality.', '2025-04-19');

SELECT * FROM emergency_alerts;

-- PRESCRIPTIONS (linked to doctor & patient)
CREATE TABLE prescriptions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id VARCHAR(50),
    doctor_id VARCHAR(50),
    prescription TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);
INSERT INTO prescriptions (patient_id, prescription) VALUES
('3', 'Cetirizine 10mg once daily for 10 days'),
('8', 'Amlodipine 5mg once daily'),
('9', 'Insulin 10 units before meals, Metformin 500mg twice daily'),
('10', 'Sumatriptan 50mg as needed for migraines');

-- CONSULTATIONS (linked to patient & doctor)
CREATE TABLE consultations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id VARCHAR(50),
    doctor_id VARCHAR(50),
    consultation_time TIME,
    consultation_date DATE,
    price DOUBLE,
    description TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);


-- APPOINTMENTS TABLE
CREATE TABLE appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id VARCHAR(50),
    doctor_id VARCHAR(50),
    date DATE,
    time VARCHAR(10),
    price DOUBLE,
    title VARCHAR(255) NOT NULL ,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id)
);

-- REMINDERS
CREATE TABLE reminders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    reminder_date DATE,
    patient_id VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
INSERT INTO reminders (title, description, reminder_date, patient_id) VALUES
('Allergy Medication', 'Take Cetirizine at 9 AM daily', '2025-04-25', '3'),
('Blood Pressure Check', 'Measure BP and log results', '2025-04-26', '8'),
('Insulin Reminder', 'Inject 10 units before lunch', '2025-04-27', '9'),
('Migraine Medication', 'Keep Sumatriptan available', '2025-04-28', '10');
-- BILLING
CREATE TABLE billing (
    billing_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id VARCHAR(50),
    service_type VARCHAR(100),
    amount DOUBLE,
    billing_date DATE,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);
-- REPORTS TABLE
CREATE TABLE reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    reportType VARCHAR(100),
    message TEXT,
    reportDate DATE
);



