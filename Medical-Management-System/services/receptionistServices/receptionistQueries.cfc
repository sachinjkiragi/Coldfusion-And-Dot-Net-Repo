<cfcomponent>
    <cffunction name="getUserList" returntype="query">
        <cfargument name="role" type="string"/>
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
            SELECT * 
            FROM Users 
            WHERE email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar">
        </cfquery>
        <cfreturn query.recordCount GT 0/>
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
                    gender = <cfqueryparam value="#arguments.patientData.gender#" cfsqltype="cf_sql_char"/>
                WHERE user_id = <cfqueryparam value="#arguments.patientData.patient_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
        <cfcatch>
            <cfset success = false/>
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

    <cffunction name="getPatientData" returntype="query">
        <cfargument name="patient_id" type="numeric"/>
        <cftry>
            <cfquery name="qryPatientData">
                SELECT first_name, last_name, email, phone, gender
                FROM Users 
                WHERE user_id = <cfqueryparam value=#arguments.patient_id# cfsqltype="cf_sql_integer"/> 
            </cfquery>
            <cfreturn qryPatientData/>
            <cfcatch>
                <cfdump var=#cfcatch#/>
            </cfcatch>
        </cftry> 
    </cffunction>

    <cffunction name="deletePatient" returntype="boolean">
        <cfargument name="patient_id" type="numeric"/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryPatientData">
                DELETE FROM
                Users
                WHERE user_id = <cfqueryparam value="#patient_id#" cfsqltype="cf_sql_varchar"/> 
            </cfquery>
            <cfcatch>
                <cfdump var=#cfcatch#/>
                <cfset success = false/>
            </cfcatch>
        </cftry> 
        <cfreturn success/>
    </cffunction>


    <cffunction name="getAppointmentList" returntype="query">
        <cfargument name="role" type="string"/>
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


</cfcomponent>