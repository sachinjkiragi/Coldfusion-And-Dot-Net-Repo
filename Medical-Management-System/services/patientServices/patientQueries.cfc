<cfcomponent>
        <cffunction name="getAppointmentList" returntype="query">
            <cfargument name="patientId" type="numeric"/>
        <cfquery name="qryAppointmentList">

            SELECT Appointments.*,
            (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = Appointments.doctor_id) AS 'doctor_name',
            (SELECT start_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'start_time',
            (SELECT end_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'end_time'
            FROM Appointments 
            WHERE Appointments.patient_id = <cfqueryparam value="#patientId#" cfsqltype="cf_sql_integer"/>;
        </cfquery>
        <cfreturn qryAppointmentList/>
    </cffunction>

    <cffunction name="getPrescriptionData" returntype="query">
        <cfargument name="appointment_id" type="numeric"/>
        <cftry>
            <cfquery name="qryPrescription">
               SELECT
                    Prescriptions.prescription_id,
                    Prescriptions.diagnosis,
                    CONCAT(Users.first_name, ' ', Users.last_name) AS doctor_name,
                    Prescriptions.diagnosis_notes,
                    Medicine_Prescriptions.quantity,
                    Medicine_Prescriptions.medicine_id,
                    Medicine_Prescriptions.dosage_info
                FROM Prescriptions
                JOIN Medicine_Prescriptions
                    ON Medicine_Prescriptions.prescription_id = Prescriptions.prescription_id
                JOIN Appointments
                    ON Prescriptions.appointment_id = Appointments.appointment_id
                JOIN Users
                    ON Users.user_id = Appointments.doctor_id
                WHERE Prescriptions.appointment_id = <cfqueryparam value="#arguments.appointment_id#" cfsqltype="cf_sql_integer">
            </cfquery>
            <cfreturn qryPrescription/>
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

</cfcomponent>