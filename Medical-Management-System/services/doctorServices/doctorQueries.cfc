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

            <cfinvoke method="getAppointmentList" component="../commonServices/commonServices.cfc" returnvariable="appointmentList">
                <cfinvokeargument name="doctor_id" value="#arguments.doctor_id#"/>
            </cfinvoke>
            <cfreturn appointmentList/>
    </cffunction>

    <cffunction name="getMedicines" returntype="query">
        <cfinvoke method="getMedicines" component="../commonServices/commonServices.cfc" returnvariable="medicineList"/>
        <cfreturn medicineList/>
    </cffunction>

    <cffunction name="doesPrescriptionExists" returntype="boolean">
        <cfargument name="appointment_id" type="numeric"/>
        <cfinvoke method="doesPrescriptionExists" component="../commonServices/commonServices.cfc" returnvariable="doesExists">
            <cfinvokeargument name="appointment_id" value="#arguments.appointment_id#"/>
        </cfinvoke>
        <cfreturn doesExists/>
    </cffunction>

    <cffunction name="addPrescription" returntype="any">
        <cfargument name="prescription_data" type="struct"/>
        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Create_Prescriptions"/>
        </cfinvoke>
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        <cfinvoke method="addPrescription" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="prescription_data" value="#arguments.prescription_data#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>

    <cffunction name="getPrescriptionData" returntype="query">
        <cfargument name="appointment_id" type="numeric"/>

        <cfquery name="qryIsValidFetch">
            SELECT * FROM Appointments 
            WHERE appointment_id = <cfqueryparam value="#arguments.appointment_id#" cfsqltype="cf_sql_integer"/>
            AND doctor_id = <cfqueryparam value="#session.currUser.user_id#" cfsqltype="cf_sql_integer"/>
        </cfquery>

        <cfif qryIsValidFetch.recordCount EQ 0>
            <cfreturn qryIsValidFetch/>
        </cfif>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Prescriptions"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        <cfinvoke method="getPrescriptionData" component="../commonServices/commonServices.cfc"  returnvariable="prescriptionData">
            <cfinvokeargument name="appointment_id" value="#arguments.appointment_id#"/>
        </cfinvoke>
        <cfreturn prescriptionData/>
    </cffunction>

    <cffunction name="getPrescriptionDataByPrescriptionId" returntype="query">
        <cfargument name="prescription_id" type="numeric"/>

        <cfquery name="qryIsValidFetch">
            SELECT * FROM 
            Appointments WHERE
            appointment_id = (SELECT appointment_id 
                              FROM Prescriptions
                              WHERE prescription_id = <cfqueryparam value="#arguments.prescription_id#" cfsqltype="cf_sql_integer"/>)
            AND doctor_id = <cfqueryparam value="#session.currUser.user_id#" cfsqltype="cf_sql_integer"/>
        </cfquery>

        <cfif qryIsValidFetch.recordCount EQ 0>
            <cfreturn qryIsValidFetch/>
        </cfif>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Prescriptions"/>
        </cfinvoke>
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfinvoke method="getPrescriptionDataByPrescriptionId" component="../commonServices/commonServices.cfc"  returnvariable="prescriptionData">
            <cfinvokeargument name="prescription_id" value="#arguments.prescription_id#"/>
        </cfinvoke>
        <cfreturn prescriptionData/>
    </cffunction>

    <cffunction name="updatePrescriptionData" returntype="boolean">
        <cfargument name="prescriptionData" type="struct"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Update_Prescriptions"/>
        </cfinvoke>
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfinvoke method="updatePrescriptionData" component="../commonServices/commonServices.cfc"  returnvariable="success">
            <cfinvokeargument name="prescriptionData" value="#arguments.prescriptionData#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>

    <cffunction name="getPatientHistory">
        <cfargument name="patientId" type="numeric"/>
        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Appointments"/>
        </cfinvoke>

        <cfquery name="qryIsValidFetch">
            SELECT * FROM 
            Appointments WHERE
            patient_id = <cfqueryparam value="#arguments.patientId#" cfsqltype="cf_sql_integer"/>
            AND doctor_id = <cfqueryparam value="#session.currUser.user_id#" cfsqltype="cf_sql_integer"/>
        </cfquery>

        <cfif qryIsValidFetch.recordCount EQ 0>
            <cfreturn qryIsValidFetch/>
        </cfif>

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
                ) SELECT* FROM patientHistory;
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