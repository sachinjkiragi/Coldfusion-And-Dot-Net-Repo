<cfcomponent>

        <cffunction name="checkPermission" returntype="boolean">
            <cfargument name="permissionTag" type="string"/>
            <cfquery name="qryPermission">
                SELECT Roles.role_name, Permissions.permission_tag
                FROM Role_Permissions
                JOIN Roles ON Role_Permissions.role_id = Roles.role_id
                JOIN Permissions ON Role_Permissions.permission_id = Permissions.permission_id
                WHERE Roles.role_name = 'Patient'
                AND permission_tag = <cfqueryparam value="#arguments.permissionTag#" cfsqltype="cf_sql_varchar"/>
            </cfquery> 
            <cfreturn qryPermission.recordCount EQ 1/>
        </cffunction>

        <cffunction name="getAppointmentList" returntype="query">
            <cfargument name="patientId" type="numeric"/>

            <cfinvoke method="checkPermission" returnvariable="hasPermission">
                <cfinvokeargument name="permissionTag" value="View_Appointments"/>
            </cfinvoke>
            <cfif hasPermission EQ false>
                <cflocation url="../../noPermission.cfm"/>
            </cfif>

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
    </cffunction>

    <cffunction name="getMedicines" returntype="query">
        <cfquery name="qryMedicines">
            SELECT* FROM Medicines
        </cfquery>
        <cfreturn qryMedicines>
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

    <cffunction name="getBillingHistory">
        <cfargument name="patientId" type="numeric"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Appointments"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Prescriptions"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        
        <cfquery name="qryBillingHistory">
            WITH cte1 AS
            (
                SELECT 
                    Appointments.doctor_id, Appointments.patient_id, Appointments.status, Appointments.appointment_charges, Appointments.timeslot_id, Appointments.slot_date,
                    Prescriptions.diagnosis, Prescriptions.diagnosis_notes,
                    Medicine_Prescriptions.medicine_id, Medicine_Prescriptions.dosage_info, Medicine_Prescriptions.quantity
                    FROM
                    Appointments LEFT JOIN Prescriptions
                    ON Appointments.appointment_id = Prescriptions.appointment_id
                    LEFT JOIN Medicine_Prescriptions
                    ON Prescriptions.prescription_id = Medicine_Prescriptions.prescription_id
                    WHERE Appointments.status = 'Completed' AND
                    patient_id = <cfqueryparam value="#arguments.patientId#" cfsqltype="cf_sql_int"/>
            ),
            cte2 AS (
                SELECT cte1.*,
                    (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = cte1.doctor_id) AS doctor_name,
                    (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = cte1.patient_id) AS patient_name
                FROM cte1
            ),
            cte3 AS (
                SELECT cte2.*,
                    Time_Slots.start_time, Time_Slots.end_time,
                    Medicines.medicine_name, Medicines.unit_price
                FROM cte2 LEFT JOIN Time_Slots
                ON cte2.timeslot_id = Time_Slots.timeslot_id
                LEFT JOIN Medicines
                ON cte2.medicine_id = Medicines.medicine_id
            ),
            billingHistory AS (
                SELECT cte3.patient_name,
                cte3.doctor_name,
                cte3.slot_date,
                cte3.start_time,
                cte3.end_time,
                cte3.medicine_name,
                cte3.diagnosis,
                cte3.quantity,
                cte3.unit_price,
                cte3.appointment_charges,
                CASE
                    WHEN cte3.quantity IS NULL then cte3.appointment_charges
                    ELSE cte3.quantity* cte3.unit_price + cte3.appointment_charges
                END
                AS 'total_bill'
                FROM cte3
            ) SELECT* FROM billingHistory;
        </cfquery>
        <cfreturn qryBillingHistory/>
    </cffunction>

</cfcomponent>