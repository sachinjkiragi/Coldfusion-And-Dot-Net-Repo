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
            SELECT 1 
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

</cfcomponent>