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

</cfcomponent>

