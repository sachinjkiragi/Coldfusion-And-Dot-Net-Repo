<cfcomponent>

        <cffunction name="checkPermission" returntype="boolean">
            <cfargument name="permissionTag" type="string"/>
            <cfquery name="qryPermission">
                SELECT Roles.role_name, Permissions.permission_tag
                FROM Role_Permissions
                JOIN Roles ON Role_Permissions.role_id = Roles.role_id
                JOIN Permissions ON Role_Permissions.permission_id = Permissions.permission_id
                WHERE Roles.role_name = 'Doctor'
                AND permission_tag = <cfqueryparam value="#arguments.permissionTag#" cfsqltype="cf_sql_varchar"/>
            </cfquery> 
            <cfreturn qryPermission.recordCount EQ 1/>
        </cffunction>       

        <cffunction name="getAppointmentList" returntype="query">
            <cfargument name="doctor_id" type="numeric"/>

            <cfinvoke method="checkPermission" returnvariable="hasPermission">
                <cfinvokeargument name="permissionTag" value="View_Appointments"/>
            </cfinvoke>
            <cfif hasPermission EQ false>
                <cflocation url="../../noPermission.cfm"/>
            </cfif>

            <cfquery name="qryAppointmentList">
                SELECT Appointments.*,
                (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = Appointments.patient_id) AS 'patient_name',
                (SELECT start_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'start_time',
                (SELECT end_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'end_time'
                FROM Appointments 
                WHERE 
                Appointments.doctor_id = <cfqueryparam value="#doctor_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfreturn qryAppointmentList/>
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
                <cflog file="MedManageLogs" text="#cfcatch.message#" type="error"/>
                <cfreturn true/>
            </cfcatch>
        </cftry>
    </cffunction>

    <cffunction name="addPrescription" returntype="any">
        <cfargument name="prescription_data" type="struct"/>
            <cfinvoke method="checkPermission" returnvariable="hasPermission">
                <cfinvokeargument name="permissionTag" value="Create_Prescriptions"/>
            </cfinvoke>
            <cfif hasPermission EQ false>
                <cflocation url="../../noPermission.cfm"/>
            </cfif>
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

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Prescriptions"/>
        </cfinvoke>
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        
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
        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Prescriptions"/>
        </cfinvoke>
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
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

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Update_Prescriptions"/>
        </cfinvoke>
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

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
                <cflog file="MedManageLogs" text="#cfcatch.message#" type="error"/>
            </cfcatch>
            </cftry>
            <cfreturn local.success/>
    </cffunction>

    <cffunction name="getPatientHistory">
        <cfargument name="patientId" type="numeric"/>
        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Appointments"/>
        </cfinvoke>
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
            <cfquery name="qryPatientHistory">
                WITH cte1 AS
                (
                    SELECT 
                        Appointments.doctor_id, Appointments.patient_id, Appointments.appointment_charges, Appointments.timeslot_id, Appointments.slot_date,
                        Prescriptions.diagnosis, Prescriptions.diagnosis_notes,
                        Medicine_Prescriptions.medicine_id, Medicine_Prescriptions.dosage_info, Medicine_Prescriptions.quantity
                        FROM
                        Appointments LEFT JOIN Prescriptions
                        ON Appointments.appointment_id = Prescriptions.appointment_id
                        LEFT JOIN Medicine_Prescriptions
                        ON Prescriptions.prescription_id = Medicine_Prescriptions.prescription_id
                        WHERE
                        Appointments.patient_id = <cfqueryparam value="#arguments.patientId#" cfsqltype="cf_sql_integer"/>
                        AND
                        Appointments.status = <cfqueryparam value="Completed" cfsqltype="cf_sql_varchar"/>
                ), cte2 AS (
                    SELECT cte1.*,
                        (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = cte1.doctor_id) AS doctor_name,
                        (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = cte1.patient_id) AS patient_name
                    FROM cte1
                ), cte3 AS (
                    SELECT cte2.*,
                        Time_Slots.start_time, Time_Slots.end_time,
                        Medicines.medicine_name
                    FROM cte2 JOIN Time_Slots
                    ON cte2.timeslot_id = Time_Slots.timeslot_id
                    LEFT JOIN Medicines
                    ON cte2.medicine_id = Medicines.medicine_id
                ), patientHistory AS (
                    SELECT cte3.patient_name,
                    cte3.doctor_name,
                    cte3.slot_date,
                    cte3.start_time,
                    cte3.end_time,
                    cte3.medicine_name,
                    cte3.diagnosis,
                    cte3.diagnosis_notes,
                    cte3.dosage_info,
                    cte3.quantity
                    FROM cte3
                ) SELECT * FROM patientHistory;
            </cfquery>
            <cfreturn qryPatientHistory/>
    </cffunction>

    <cffunction name="cancelAppointment" returntype="boolean">
        <cfargument name="appointmentId" type="string"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Update_Appointments"/>
        </cfinvoke>
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryCancelAppointment">
                UPDATE Appointments
                SET status = <cfqueryparam value="Cancelled" cfsqltype="cf_sql_varchar"/>
                WHERE appointment_id = <cfqueryparam value="#arguments.appointmentId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset local.success = false/>
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

</cfcomponent>