<cfcomponent>
        <cffunction name="getAppointmentList" returntype="query">
            <cfargument name="doctor_id" type="numeric"/>
        <cfquery name="qryAppointmentList">

            SELECT Appointments.*,
            (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = Appointments.patient_id) AS 'patient_name',
            (SELECT start_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'start_time',
            (SELECT end_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'end_time'
            FROM Appointments 
            WHERE Appointments.doctor_id = <cfqueryparam value="#doctor_id#" cfsqltype="cf_sql_integer"/>;
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
                quantity = <cfqueryparam value="#arguments.prescriptionData.medicine_qty#" cfsqltype="cf_sql_integer"/>
                WHERE prescription_id = <cfqueryparam value="#arguments.prescriptionData.btn_update_prescriptionid#"/>
            </cfquery>

            <cfcatch>
                <cfset success = false/>
                <cfdump var=#cfcatch#/>
            </cfcatch>
            </cftry>
            <cfreturn success/>
    </cffunction>

</cfcomponent>