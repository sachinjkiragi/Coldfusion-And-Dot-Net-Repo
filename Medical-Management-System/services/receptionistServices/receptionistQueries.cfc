<cfcomponent>

    <cffunction name="checkPermission" returntype="boolean">
        <cfargument name="permissionTag" type="string"/>
        <cfquery name="qryPermission">
            SELECT Roles.role_name, Permissions.permission_tag
            FROM Role_Permissions
            JOIN Roles ON Role_Permissions.role_id = Roles.role_id
            JOIN Permissions ON Role_Permissions.permission_id = Permissions.permission_id
            WHERE Roles.role_name = 'Receptionist'
            AND permission_tag = <cfqueryparam value="#arguments.permissionTag#" cfsqltype="cf_sql_varchar"/>
        </cfquery> 
        <cfreturn qryPermission.recordCount EQ 1/>
    </cffunction>

    <cffunction name="getUserList" returntype="query">
        <cfargument name="role" type="string"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Users"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfquery name="qryUserList">
            SELECT
                Users.user_id, Users.first_name, Users.last_name, Users.email, Users.phone, Departments.department_name,
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

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Create_Users"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

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

    <cffunction name="updatePatientData" returntype="boolean">
        <cfargument name="patientData" type="struct"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Update_Users"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

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
            <cflog file="MedManageLogs" text="#cfcatch.message#" type="error"/>
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

    <cffunction name="insertAppointment" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Create_Appointments"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        
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

    <cffunction name="isDoctorAvailable" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Appointments"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        
        <cfquery name="qryDoctorAvailable">
            SELECT *
            FROM Appointments 
            WHERE doctor_id = <cfqueryparam value=#arguments.appointmentDetails.doctor_id# cfsqltype="cf_sql_integer"/>
            AND slot_date = <cfqueryparam value=#arguments.appointmentDetails.slot_date# cfsqltype="cf_sql_date"/>
            AND timeslot_id = <cfqueryparam value=#arguments.appointmentDetails.timeslot_id#/> 
            AND status = <cfqueryparam value="Booked" cfsqltype="cf_sql_varchar"/>
            <cfif structKeyExists(arguments.appointmentDetails, "appointment_id")>
                AND appointment_id != <cfqueryparam value="#arguments.appointmentDetails.appointment_id#" cfsqltype="cf_sql_integer"/>
            </cfif>
        </cfquery>
        <cfreturn qryDoctorAvailable.recordCount EQ 0/>
    </cffunction>

    <cffunction name="getPatientData" returntype="query">
        <cfargument name="patient_id" type="numeric"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Users"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfquery name="qryPatientData">
            SELECT first_name, last_name, email, phone, gender
            FROM Users 
            WHERE user_id = <cfqueryparam value=#arguments.patient_id# cfsqltype="cf_sql_integer"/> 
        </cfquery>
        <cfreturn qryPatientData/>
    </cffunction>

    <cffunction name="deletePatient" returntype="boolean">
        <cfargument name="patient_id" type="numeric"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Delete_Users"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

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
                <cflog file="MedManageLogs" text="#cfcatch.message#" type="error"/>
                <cfset local.success = false/>
            </cfcatch>
        </cftry> 
        <cfreturn local.success/>
    </cffunction>


    <cffunction name="getAppointmentList" returntype="query">

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Appointments"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

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

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Appointments"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

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
        
        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Update_Appointments"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
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
            <cflog file="MedManageLogs" text="#cfcatch.message#" type="error"/>
            <cfset local.success = false/>
        </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>


    <cffunction name="getDoctorsAvailability" returntype="query">
        <cfargument name="doctor_id" type="string"/>
        <cfargument name="slot_date" type="string"/>
        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Appointments"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        <cfquery name="qryAvailabilityList">
            WITH cte AS(
                SELECT* 
                FROM Appointments
                WHERE Appointments.doctor_id = <cfqueryparam value="#doctor_id#" cfsqltype="cf_sql_integer"/> AND Appointments.slot_date = <cfqueryparam value="#form.slot_date#" cfsqltype="date"/>
                ),
                res AS(
                    SELECT Time_Slots.start_time, Time_Slots.end_time
                    FROM Time_Slots LEFT JOIN cte
                    ON Time_Slots.timeslot_id = cte.timeslot_id
                    WHERE cte.appointment_id IS NULL
                ) SELECT* FROM res;
        </cfquery>
        <cfreturn qryAvailabilityList/>
    </cffunction>
</cfcomponent>