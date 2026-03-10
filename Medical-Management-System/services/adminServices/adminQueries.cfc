<cfcomponent>
    <cffunction name="getUserList" returntype="query">
        <cfargument name="role" type="string"/>
        <cfquery name="qryUserList">
            SELECT
                Users.user_id, Users.first_name, Users.last_name, Users.email, Users.phone, Users.password, Departments.department_name,
                CASE 
                    WHEN Users.gender = 'M' THEN 'Male'
                    WHEN Users.gender = 'F' then 'Female'
                    ELSE 'Other'
                END
                AS gender
                FROM
                Users JOIN Roles
                ON Users.role_id = Roles.role_id
                LEFT JOIN
                Departments
                ON Users.department_id = Departments.department_id
                WHERE roles.role_name = <cfqueryparam value=#role# cfsqltype="cf_sql_varchar"/>
        </cfquery>
        <cfreturn qryUserList/>
    </cffunction>

    <cffunction name="getPatientData" returntype="query">
        <cfargument name="patient_id" type="numeric"/>
        <cftry>
            <cfquery name="qryPatientData">
                SELECT first_name, last_name, email, phone, gender, password
                FROM Users 
                WHERE user_id = <cfqueryparam value=#arguments.patient_id# cfsqltype="cf_sql_integer"/> 
            </cfquery>
            <cfreturn qryPatientData/>
            <cfcatch>
                <cfdump var=#cfcatch#/>
            </cfcatch>
        </cftry> 
    </cffunction>

    <cffunction name="updatePatientData" returntype="boolean">
        <cfargument name="patientData" type="struct"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryUpdate">
                UPDATE Users
                 SET 
                    first_name = <cfqueryparam value="#arguments.patientData.firstName#" cfsqltype="cf_sql_varchar"/>,
                    last_name  = <cfqueryparam value="#arguments.patientData.lastName#" cfsqltype="cf_sql_varchar"/>,
                    email = <cfqueryparam value="#arguments.patientData.email#" cfsqltype="cf_sql_varchar"/>,
                    phone = <cfqueryparam value="#arguments.patientData.phone#" cfsqltype="cf_sql_varchar"/>,
                    gender = <cfqueryparam value="#arguments.patientData.gender#" cfsqltype="cf_sql_char"/>,
                    password = <cfqueryparam value="#arguments.patientData.password#" cfsqltype="cf_sql_char"/>
                WHERE user_id = <cfqueryparam value="#arguments.patientData.patient_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
        <cfcatch>
            <cfset success = false/>
        </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="deletePatient" returntype="boolean">
        <cfargument name="patient_id" type="numeric"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryDeletePatient">
                DELETE FROM
                Appointments
                WHERE patient_id = <cfqueryparam value="#patient_id#" cfsqltype="cf_sql_varchar"/> ;
                DELETE FROM
                Users
                WHERE user_id = <cfqueryparam value="#patient_id#" cfsqltype="cf_sql_varchar"/> 
            </cfquery>
            <cfcatch>
                <cfdump var=#cfcatch#/>
                <cfabort/>
                <cfset success = false/>
            </cfcatch>
        </cftry> 
        <cfreturn success/>
    </cffunction>


    <cffunction name="getDoctorData" returntype="query">
        <cfargument name="doctorId" type="numeric"/>
        <cfquery name="qryUserList">
            SELECT
                user_id, first_name, last_name, email, phone, department_id, password, gender
                FROM
                Users
                WHERE user_id = <cfqueryparam value=#arguments.doctorId# cfsqltype="cf_sql_varchar"/>
        </cfquery>
        <cfreturn qryUserList/>
    </cffunction>

    <cffunction name="getDepartments" returntype="query">
        <cftry>
            <cfquery name="qryDepartments">
                SELECT * FROM Departments
            </cfquery>
            <cfreturn qryDepartments>
            <cfcatch>
                <cfdump var=#cfcatch#/>
            </cfcatch>
        </cftry>
    </cffunction>


    
    <cffunction name="updateDoctorData" returntype="boolean">
        <cfargument name="doctorData" type="struct"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryUpdate">
                UPDATE Users
                 SET 
                    first_name = <cfqueryparam value="#arguments.doctorData.firstName#" cfsqltype="cf_sql_varchar"/>,
                    last_name  = <cfqueryparam value="#arguments.doctorData.lastName#" cfsqltype="cf_sql_varchar"/>,
                    email = <cfqueryparam value="#arguments.doctorData.email#" cfsqltype="cf_sql_varchar"/>,
                    phone = <cfqueryparam value="#arguments.doctorData.phone#" cfsqltype="cf_sql_varchar"/>,
                    gender = <cfqueryparam value="#arguments.doctorData.gender#" cfsqltype="cf_sql_char"/>,
                    password = <cfqueryparam value="#arguments.doctorData.password#" cfsqltype="cf_sql_char"/>,
                    department_id = <cfqueryparam value="#arguments.doctorData.department_id#" cfsqltype="cf_sql_char"/>
                WHERE user_id = <cfqueryparam value="#arguments.doctorData.doctor_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
        <cfcatch>
            <cfset success = false/>
            <cfdump var=#cfcatch#/>
            <cfabort/>
        </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="deleteDoctor" returntype="boolean">
        <cfargument name="doctor_id" type="numeric"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryDeleteDoctor">
                DELETE FROM
                Appointments
                WHERE doctor_id = <cfqueryparam value="#doctor_id#" cfsqltype="cf_sql_varchar"/> ;
                DELETE FROM
                Users
                WHERE user_id = <cfqueryparam value="#doctor_id#" cfsqltype="cf_sql_varchar"/> 
            </cfquery>
            <cfcatch>
                <cfdump var=#cfcatch#/>
                <cfset success = false/>
            </cfcatch>
        </cftry> 
        <cfreturn success/>
    </cffunction>

        <cffunction name="doesMailExists" returntype="boolean">
        <cfargument name="email" required="true" type="string"/>
        
        <cfquery result="query">
            SELECT * 
            FROM Users 
            WHERE email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn query.recordCount GT 0/>
    </cffunction>


    <cffunction name="getAppointmentList" returntype="query">
        <cfquery name="qryAppointmentList">
            SELECT Appointments.*,
            (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = Appointments.doctor_id) AS 'doctor_name',
            (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = Appointments.patient_id) AS 'patient_name',
            (SELECT start_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'start_time',
            (SELECT end_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'end_time'
            FROM 
            Appointments;
        </cfquery>
        <cfreturn qryAppointmentList/>
    </cffunction>

        <cffunction name="getAppointmentData" returntype="query">
        <cfargument name="appointment_id" type="numeric"/>
        <cftry>
            <cfquery name="qryAppointment">
                SELECT Appointments.*,
                (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = Appointments.doctor_id) AS 'doctor_name',
                (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = Appointments.patient_id) AS 'patient_name',
                (SELECT start_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'start_time',
                (SELECT end_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'end_time'
                FROM 
                Appointments
                WHERE appointment_id = <cfqueryparam value="#appointment_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfreturn qryAppointment/>
            <cfcatch>
                <cfdump var=#cfcatch#/>
            </cfcatch>
        </cftry> 
    </cffunction>
    

    <cffunction name="updateAppointmentData" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>
        
        <cfset success = true/>
        <cftry>
            <cfquery name="qryUpdate">
                UPDATE Appointments
                 SET 
                    doctor_id = <cfqueryparam value="#arguments.appointmentDetails.doctor_id#" cfsqltype="cf_sql_int"/>,
                    patient_id  = <cfqueryparam value="#arguments.appointmentDetails.patient_id#" cfsqltype="cf_sql_int"/>,
                    status = <cfqueryparam value="#arguments.appointmentDetails.status#" cfsqltype="cf_sql_varchar"/>,
                    appointment_charges = <cfqueryparam value="#arguments.appointmentDetails.appointment_charges#" cfsqltype="cf_sql_varchar"/>,
                    timeslot_id = <cfqueryparam value="#arguments.appointmentDetails.timeslot_id#" cfsqltype="cf_sql_int"/>,
                    slot_date = <cfqueryparam value="#arguments.appointmentDetails.slot_date#" cfsqltype="cf_sql_date"/>
                WHERE appointment_id = <cfqueryparam value="#arguments.appointmentDetails.appointment_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
        <cfcatch>
            <cfdump var=#cfcatch#/>
            <cfabort/>
            <cfset success = false/>
        </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="insertPatientData" returntype="boolean">
        <cfargument name="patientData" type="struct"/>
        <cfset success = true/>

        <cftry>
            <cfquery name="qryInsert">
                INSERT INTO Users (first_name, last_name, email, phone, role_id, password, gender)
                VALUES (
                    <cfqueryparam value="#arguments.patientData.firstName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.patientData.lastName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.patientData.email#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.patientData.phone#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.patientData.role_id#" cfsqltype="cf_sql_integer"/>,
                    <cfqueryparam value="#arguments.patientData.password#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.patientData.gender#" cfsqltype="cf_sql_char"/>
                )
            </cfquery>
        <cfcatch>
            <cfdump var=#cfcatch#/>
            <cfset success = false/>
        </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="insertDoctorData" returntype="boolean">
        <cfargument name="doctorData" type="struct"/>
        <cfset success = true/>

        <cftry>
            <cfquery name="qryInsert">
                INSERT INTO Users (first_name, last_name, email, phone, role_id, password, gender, department_id)
                VALUES (
                    <cfqueryparam value="#arguments.doctorData.firstName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.doctorData.lastName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.doctorData.email#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.doctorData.phone#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.doctorData.role_id#" cfsqltype="cf_sql_integer"/>,
                    <cfqueryparam value="#arguments.doctorData.password#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.doctorData.gender#" cfsqltype="cf_sql_char"/>,
                    <cfqueryparam value="#arguments.doctorData.department_id#" cfsqltype="cf_sql_integer"/>
                )
            </cfquery>
        <cfcatch>
            <cfdump var=#cfcatch#/>
            <cfset success = false/>
            <cfabort/>
        </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="insertAppointment" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>
        <cfset success = true/>

        <cftry>
            <cfquery name="qryInsertAppointment">
                INSERT INTO Appointments
                (doctor_id, patient_id, status, appointment_charges, timeslot_id, slot_date)
                VALUES
                (
                    <cfqueryparam value=#arguments.appointmentDetails.doctor_id# cfsqltype="cf_sql_integer"/>,
                    <cfqueryparam value=#arguments.appointmentDetails.patient_id# cfsqltype="cf_sql_integer"/>,
                    <cfqueryparam value=#arguments.appointmentDetails.status# cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value=#arguments.appointmentDetails.appointment_charges# cfsqltype="cf_sql_decimal"/>,
                    <cfqueryparam value=#arguments.appointmentDetails.timeslot_id# cfsqltype="cf_sql_integer"/>,
                    <cfqueryparam value=#arguments.appointmentDetails.slot_date# cfsqltype="cf_sql_date"/>
                )
            </cfquery>
        <cfcatch>
            <cfset success = false/>
            <cfdump var=#cfcatch# label="inserting appointment"/>
        </cfcatch>
        </cftry>

        <cfreturn success/>
    </cffunction>

    <cffunction name="isDoctorAvailable" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>
        <cfset success = true/>

        <cftry>
            <cfquery name="qryDoctorAvailable">
                SELECT 1 
                FROM Appointments 
                WHERE doctor_id = <cfqueryparam value=#arguments.appointmentDetails.doctor_id#/>
                AND slot_date = <cfqueryparam value=#arguments.appointmentDetails.slot_date#/>
                AND timeslot_id = <cfqueryparam value=#arguments.appointmentDetails.timeslot_id#/> 
                AND status = <cfqueryparam value="Booked" cfsqltype="cf_sql_varchar"/>
            </cfquery>
            <cfreturn qryDoctorAvailable.recordCount EQ 0/>
        <cfcatch>
            <cfset success = false/>
            <cfdump var=#cfcatch# label="qryDoctorAvailable"/>
        </cfcatch>
        </cftry>

        <cfreturn success/>
    </cffunction>

    <cffunction name="getTimeSlots" returntype="query">
        <cftry>
            <cfquery name="qryTimeSlots">
                SELECT * FROM Time_Slots;
            </cfquery>
            <cfreturn qryTimeSlots/>
        <cfcatch>
            <cfdump var=#cfcatch#/>
        </cfcatch>
        </cftry>
    </cffunction>


        <cffunction name="getMedicines" returntype="query">
        <cftry>
            <cfquery name="qryMedicines">
                SELECT * FROM Medicines
            </cfquery>
            <cfreturn qryMedicines>
            <cfcatch>
                <cfdump var=#cfcatch#/>
            </cfcatch>
        </cftry>
    </cffunction>

        <cffunction name="doesPrescriptionExists" returntype="boolean">
        <cfargument name="appointment_id" type="numeric"/>
        <cftry>
            <cfquery name="qryPrescExists">
                SELECT 1 FROM Prescriptions 
                WHERE appointment_id = <cfqueryparam value="#arguments.appointment_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfreturn qryPrescExists.recordCount GTE 1>
            <cfcatch>
                <cfdump var=#cfcatch#/>
                <cfreturn false/>
            </cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="addPrescription" returntype="any">
        <cfargument name="prescription_data" type="struct"/>
        <cftry>
            <cfquery name="qryInsertPrescription" result="res">
                INSERT INTO Prescriptions (appointment_id, diagnosis, diagnosis_notes, digital_signature)
                VALUES (
                    <cfqueryparam value="#arguments.prescription_data.appointment_id#" cfsqltype="cf_sql_integer">,
                    <cfqueryparam value="#arguments.prescription_data.diagnosis#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.prescription_data.diagnosis_notes#" cfsqltype="cf_sql_varchar">,
                    <cfqueryparam value="#arguments.prescription_data.digital_signature#" cfsqltype="cf_sql_varchar">
                );
            </cfquery>

            <cfquery name="updateStatus">
                UPDATE Appointments 
                SET status = <cfqueryparam value="Completed" cfsqltype="cf_sql_varchar"/>
                WHERE appointment_id =  <cfqueryparam value="#arguments.prescription_data.appointment_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>

            <cfif arguments.prescription_data.medicine_id NEQ "">

                <cfset newPrescriptionId = res.generatedKey>
                
                <cfquery name="qryInsertMedicinePrescription">
                    INSERT INTO Medicine_Prescriptions (medicine_id, prescription_id, dosage_info, quantity
                    )
                    VALUES (
                        <cfqueryparam value="#arguments.prescription_data.medicine_id#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#newPrescriptionId#" cfsqltype="cf_sql_integer">,
                        <cfqueryparam value="#arguments.prescription_data.dosage_info#" cfsqltype="cf_sql_varchar">,
                        <cfqueryparam value="#arguments.prescription_data.medicine_qty#" cfsqltype="cf_sql_integer">
                    );
                </cfquery>
            </cfif>           

            <cfreturn true/>
            <cfcatch>
                <cfdump var=#cfcatch#/>
            </cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="getPrescriptionData" returntype="query">
        <cfargument name="appointment_id" type="numeric"/>
        <cftry>
            <cfquery name="qryPrescription">
                SELECT
                 Prescriptions.prescription_id,
                 Prescriptions.diagnosis, 
                 Prescriptions.diagnosis_notes, 
                 Medicine_Prescriptions.quantity, 
                 Medicine_Prescriptions.medicine_id, 
                 Medicine_Prescriptions.dosage_info
                FROM Prescriptions JOIN Medicine_Prescriptions
                ON Medicine_Prescriptions.prescription_id = Prescriptions.prescription_id
                WHERE Prescriptions.appointment_id = <cfqueryparam value="#arguments.appointment_id#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfreturn qryPrescription/>
            <cfcatch>
                <cfdump var=#cfcatch#/>
            </cfcatch>
        </cftry> 
    </cffunction>

    <cffunction name="getPrescriptionDataByPrescriptionId" returntype="query">
        <cfargument name="prescription_id" type="numeric"/>
        <cftry>
            <cfquery name="qryPrescription">
                SELECT
                 Prescriptions.prescription_id,
                 Prescriptions.appointment_id,
                 Prescriptions.diagnosis, 
                 Prescriptions.diagnosis_notes, 
                 Medicine_Prescriptions.quantity, 
                 Medicine_Prescriptions.medicine_id, 
                 Medicine_Prescriptions.dosage_info
                FROM Prescriptions JOIN Medicine_Prescriptions
                ON Medicine_Prescriptions.prescription_id = Prescriptions.prescription_id
                WHERE Prescriptions.prescription_id = <cfqueryparam value="#arguments.prescription_id#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfreturn qryPrescription/>
            <cfcatch>
                <cfdump var=#cfcatch#/>
            </cfcatch>
        </cftry> 
    </cffunction>

    <cffunction name="updatePrescriptionData" returntype="boolean">
        <cfargument name="prescriptionData" type="struct"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryUpdatePrescription">
                UPDATE Prescriptions
                SET 
                diagnosis = <cfqueryparam value="#arguments.prescriptionData.diagnosis#" cfsqltype="cf_sql_varchar"/>,
                diagnosis_notes = <cfqueryparam value="#arguments.prescriptionData.diagnosis_notes#" cfsqltype="cf_sql_varchar"/>
                WHERE prescription_id = <cfqueryparam value="#arguments.prescriptionData.btn_update_prescriptionid#"/>
            </cfquery>

            <cfquery name="qerUpdateMedicinePrescription">
                UPDATE Medicine_Prescriptions
                SET 
                medicine_id = <cfqueryparam value="#arguments.prescriptionData.medicine_id#" cfsqltype="cf_sql_integer"/>,
                quantity = <cfqueryparam value="#arguments.prescriptionData.medicine_qty#" cfsqltype="cf_sql_integer"/>,
                dosage_info = <cfqueryparam value="#arguments.prescriptionData.dosage_info#" cfsqltype="cf_sql_varchar"/>
                WHERE prescription_id = <cfqueryparam value="#arguments.prescriptionData.btn_update_prescriptionid#"/>
            </cfquery>

            <cfcatch>
                <cfset success = false/>
                <cfdump var=#cfcatch#/>
            </cfcatch>
            </cftry>
            <cfreturn success/>
    </cffunction>


    <cffunction name="deletePrescription">
        <cfargument name="prescription_id" type="numeric"/>
        <cfargument name="appointment_id" type="numeric"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryDeletePrescription">
                DELETE FROM Prescriptions 
                WHERE prescription_id = <cfqueryparam value="#arguments.prescription_id#" cfsqltype="cf_sql_integer"/>

                UPDATE Appointments 
                SET status = 'Booked' 
                WHERE appointment_id = <cfqueryparam value="#arguments.appointment_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
        <cfcatch>
            <cfdump var=#cfcatch#/>
            <cfset success = false/>
            <cfabort/>
        </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="getMedicines" returntype="query">
        <cfquery name="qryMedicines">
            SELECT * FROM Medicines;
        </cfquery>
        <cfreturn qryMedicines/>
    </cffunction>

    <cffunction name="addMedicine" returntype="boolean">
        <cfargument name="medicineData" type="struct"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryInsertMedicine">
                INSERT INTO Medicines (medicine_name, unit_price)
                VALUES(
                    <cfqueryparam value="#arguments.medicineData.medicineName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.medicineData.unitPrice#" cfsqltype="cf_sql_integer"/>
                )
            </cfquery>
            <cfcatch>
                <cfset success = true/>
                <cfdump var=#cfcatch#/>
                <cfabort/>
            </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="medicineExists" returntype="boolean">
        <cfargument name="medicineName" type="string">
        <cfquery name="qryMedicineExists">
            SELECT 1 FROM Medicines
            WHERE medicine_name = <cfqueryparam value="#arguments.medicineName#" cfsqltype="cf_sql_varchar"/>
        </cfquery>
        <cfreturn qryMedicineExists.recordCount GT 0/>
    </cffunction>

    <cffunction name="getMedicineDataById" returntype="query">
        <cfargument name="medicineId" type="numeric">
        <cfquery name="qeyMedicineData">
            SELECT medicine_name, unit_price FROM Medicines
            WHERE medicine_id = <cfqueryparam value="#arguments.medicineId#" cfsqltype="cf_sql_integer"/>
        </cfquery>
        <cfreturn qeyMedicineData/>
    </cffunction>

    <cffunction name="updateMedicine" returntype="boolean">
        <cfargument name="medicineData" type="struct"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryUpdateMedicine">
                UPDATE  Medicines 
                SET
                medicine_name = <cfqueryparam value="#arguments.medicineData.medicineName#" cfsqltype="cf_sql_varchar"/>,
                unit_price =   <cfqueryparam value="#arguments.medicineData.unitPrice#" cfsqltype="cf_sql_integer"/>
                WHERE medicine_id = <cfqueryparam value="#arguments.medicineData.medicineId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset success = true/>
                <cfdump var=#cfcatch#/>
                <cfabort/>
            </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="deleteMedicine" returntype="boolean">
        <cfargument name="medicineId" type="numeric"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryUpdateMedicine">
                DELETE FROM Medicines
                WHERE medicine_id = <cfqueryparam value="#arguments.medicineId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset success = true/>
                <cfdump var=#cfcatch#/>
                <cfabort/>
            </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>


    <cffunction name="getTimeSlots">
        <cfquery name="qryTimeSlots">
            SELECT * FROM Time_Slots;
        </cfquery>
        <cfreturn qryTimeSlots/>
    </cffunction>

    
    <cffunction name="getAvailableTimeSlots">
        <cfquery name="qryAvailableTimeSlots">
            SELECT * FROM ALL_Slots
            WHERE start_time NOT IN (SELECT start_time FROM Time_Slots);
        </cfquery>
        <cfreturn qryAvailableTimeSlots/>
    </cffunction>

    <cffunction name="addTimeSlot" returntype="boolean">
        <cfargument name="availableTimeSlotId" type="numeric"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryInsertTimeSlot">
                INSERT INTO Time_Slots (start_time, end_time)
                VALUES(
                    (SELECT start_time FROM All_Slots WHERE slot_id = <cfqueryparam value="#arguments.availableTimeSlotId#" cfsqltype="cf_sql_integer"/>),
                    (SELECT end_time FROM All_Slots WHERE slot_id = <cfqueryparam value="#arguments.availableTimeSlotId#" cfsqltype="cf_sql_integer"/>)
                )
            </cfquery>
            <cfcatch>
                <cfset success = false/>
                <cfdump var=#cfcatch#/>
                <cfabort/>
            </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="deleteTimeSlot" returntype="boolean">
        <cfargument name="timeSlotId" type="numeric">
        <cfset success = true/>
        <cftry>
            <cfquery name="qryDeleteTimeSlot">
                DELETE FROM Time_Slots
                WHERE timeslot_id = <cfqueryparam value="#timeSlotId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset success = false/>
                <cfdump var=#cfcatch#/>
                <cfabort/>
            </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>


    <cffunction name="getDepartments" returntype="query">
        <cfquery name="qryDepartmens">
            SELECT * FROM Departments;
        </cfquery>
        <cfreturn qryDepartmens/>
    </cffunction>

    <cffunction name="addDepartment" returntype="boolean">
        <cfargument name="departmentData" type="struct"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryInsertMedicine">
                INSERT INTO Departments (department_name)
                VALUES(
                    <cfqueryparam value="#arguments.departmentData.departmentName#" cfsqltype="cf_sql_varchar"/>
                )
            </cfquery>
            <cfcatch>
                <cfset success = true/>
                <cfdump var=#cfcatch#/>
                <cfabort/>
            </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="departmentExists" returntype="boolean">
        <cfargument name="departmentName" type="string">
        <cfquery name="qryDepartmentExists">
            SELECT 1 FROM Departments
            WHERE department_name = <cfqueryparam value="#arguments.departmentName#" cfsqltype="cf_sql_varchar"/>
        </cfquery>
        <cfreturn qryDepartmentExists.recordCount GT 0/>
    </cffunction>

    <cffunction name="getDepartmentDataById" returntype="query">
        <cfargument name="departmentId" type="numeric">
        <cfquery name="qryDepartmentData">
            SELECT department_name FROM Departments
            WHERE department_id = <cfqueryparam value="#arguments.departmentId#" cfsqltype="cf_sql_integer"/>
        </cfquery>
        <cfreturn qryDepartmentData/>
    </cffunction>

    <cffunction name="updateDepartment" returntype="boolean">
        <cfargument name="departmentData" type="struct"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryUpdateDepartment">
                UPDATE  Departments 
                SET
                department_name = <cfqueryparam value="#arguments.departmentData.departmentName#" cfsqltype="cf_sql_varchar"/>
                WHERE department_id = <cfqueryparam value="#arguments.departmentData.departmentId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset success = true/>
                <cfdump var=#cfcatch#/>
                <cfabort/>
            </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="deleteDepartment" returntype="boolean">
        <cfargument name="departmentId" type="numeric"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qeyDeleteDepartment">
                DELETE FROM Departments
                WHERE department_id = <cfqueryparam value="#arguments.departmentId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset success = true/>
                <cfdump var=#cfcatch#/>
                <cfabort/>
            </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>


</cfcomponent>






