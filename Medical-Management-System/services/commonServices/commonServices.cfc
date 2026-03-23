<cfcomponent>

    <cffunction name="getUserList" returntype="query">
        <cfargument name="role" type="string"/>
        <cfquery name="qryUserList">
            SELECT
                Users.user_id, Users.first_name, Users.last_name, Users.email, Users.phone, Users.qualification, Departments.department_name,
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


    <cffunction name="doesMailExists" returntype="boolean">
        <cfargument name="email" required="true" type="string"/>
        
        <cfquery result="query">
            SELECT* 
            FROM Users 
            WHERE email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn query.recordCount GT 0/>
    </cffunction>

    <cffunction name="insertPatientData" returntype="boolean">
        <cfargument name="patientData" type="struct"/>
        <cfset local.success = true/>

        <cfset local.hashedPassword = hash(arguments.patientData.password, "SHA-256")>
        <cftry>
            <cfquery name="qryInsert">
                INSERT INTO Users (first_name, last_name, email, phone, role_id, password, gender)
                VALUES (
                    <cfqueryparam value="#arguments.patientData.firstName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.patientData.lastName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.patientData.email#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.patientData.phone#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.patientData.role_id#" cfsqltype="cf_sql_integer"/>,
                    <cfqueryparam value="#local.hashedPassword#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.patientData.gender#" cfsqltype="cf_sql_char"/>
                )
            </cfquery>
        <cfcatch>
            <cflog file="MedManageLogs" text="#cfcatch.message#" type="error"/>
            <cfset local.success = false/>
        </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="getPatientData" returntype="query">
        <cfargument name="patient_id" type="numeric"/>

        <cfquery name="qryPatientData">
            SELECT first_name, last_name, email, phone, gender
            FROM Users 
            WHERE user_id = <cfqueryparam value=#arguments.patient_id# cfsqltype="cf_sql_integer"/> 
        </cfquery>
        <cfreturn qryPatientData/>
    </cffunction>

    <cffunction name="updatePatientData" returntype="boolean">
        <cfargument name="patientData" type="struct"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryUpdate">
                UPDATE Users
                 SET 
                    first_name = <cfqueryparam value="#arguments.patientData.firstName#" cfsqltype="cf_sql_varchar"/>,
                    last_name  = <cfqueryparam value="#arguments.patientData.lastName#" cfsqltype="cf_sql_varchar"/>,
                    email = <cfqueryparam value="#arguments.patientData.email#" cfsqltype="cf_sql_varchar"/>,
                    phone = <cfqueryparam value="#arguments.patientData.phone#" cfsqltype="cf_sql_varchar"/>,
                    gender = <cfqueryparam value="#arguments.patientData.gender#" cfsqltype="cf_sql_char"/>
                WHERE user_id = <cfqueryparam value="#arguments.patientData.patient_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
        <cfcatch>
            <cfset local.success = false/>
            <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
        </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="deletePatient" returntype="boolean">
        <cfargument name="patient_id" type="numeric"/>
        <cfset local.success = true/>
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
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
                <cfset local.success = false/>
            </cfcatch>
        </cftry> 
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="getAppointmentList" returntype="query">
        <cfargument name="doctor_id" type="numeric"/>
        <cfquery name="qryAppointmentList">
            SELECT Appointments.*,
            (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = Appointments.patient_id) AS 'patient_name',
            (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = Appointments.doctor_id) AS 'doctor_name',
            (SELECT start_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'start_time',
            (SELECT end_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'end_time'
            FROM Appointments 
            <cfif structKeyExists(arguments, "doctor_id")>
                WHERE 
                Appointments.doctor_id = <cfqueryparam value="#arguments.doctor_id#" cfsqltype="cf_sql_integer"/>
            </cfif>
        </cfquery>
        <cfreturn qryAppointmentList/>
    </cffunction>

    <cffunction name="getAppointmentData" returntype="query">
        <cfargument name="appointment_id" type="numeric"/>
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
    </cffunction>

    <cffunction name="updateAppointmentData" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>
        
        <cfset local.success = true/>
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
            <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            <cfset local.success = false/>
        </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="getMedicines" returntype="query">
        <cftry>
            <cfquery name="qryMedicines">
                SELECT* FROM Medicines
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
                <cflog file="MedManageLogs" text="#cfcatch.message#" type="error"/>
                <cfreturn true/>
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
            <cflog file="MedManageLogs" text="#cfcatch.message#" type="error"/>
            <cfreturn false/>
        </cfcatch>
    </cftry>
</cffunction>

    <cffunction name="getPrescriptionData" returntype="query">
        <cfargument name="appointment_id" type="numeric"/>
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
    </cffunction>

    <cffunction name="getPrescriptionDataByPrescriptionId" returntype="query">
        <cfargument name="prescription_id" type="numeric"/>
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
    </cffunction>

    <cffunction name="updatePrescriptionData" returntype="boolean">
        <cfargument name="prescriptionData" type="struct"/>
        <cfset local.success = true/>
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
                <cfset local.success = false/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
            </cftry>
            <cfreturn local.success/>
    </cffunction>


    <cffunction name="getTimeSlots" returntype="query">
        <cfquery name="qryTimeSlots">
            SELECT* FROM Time_Slots;
        </cfquery>
        <cfreturn qryTimeSlots/>
    </cffunction>

    <cffunction name="isDoctorAvailable" returntype="boolean">    
        <cfquery name="qryDoctorAvailable">
            SELECT *
            FROM Appointments 
            WHERE doctor_id = <cfqueryparam value=#arguments.appointmentDetails.doctor_id# cfsqltype="cf_sql_integer"/>
            AND slot_date = <cfqueryparam value=#arguments.appointmentDetails.slot_date# cfsqltype="cf_sql_date"/>
            AND timeslot_id = <cfqueryparam value=#arguments.appointmentDetails.timeslot_id# cfsqltype="cf_sql_integer"/> 
            AND status = <cfqueryparam value="Booked" cfsqltype="cf_sql_varchar"/>
            <cfif structKeyExists(arguments.appointmentDetails, "appointment_id")>
                AND appointment_id != <cfqueryparam value="#arguments.appointmentDetails.appointment_id#" cfsqltype="cf_sql_integer"/>
            </cfif>
        </cfquery>
        <cfreturn qryDoctorAvailable.recordCount EQ 0/>
    </cffunction>


    <cffunction name="insertAppointment" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>

        <cfset local.success = true/>
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
            <cfset local.success = false/>
            <cflog file="MedManageLogs" text="#cfcatch.message#" type="error"/> 
        </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

</cfcomponent>