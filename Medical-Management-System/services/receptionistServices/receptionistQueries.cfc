<cfcomponent>
    <cffunction name="getPatientList" returntype="query">
        <cfargument name="role" type="string"/>
        <cfquery name="qryPatientList">
            SELECT
                Users.user_id, Users.first_name, Users.last_name, Users.email, Users.phone,
                CASE 
                    WHEN Users.gender = 'M' THEN 'Male'
                    WHEN Users.gender = 'F' then 'Female'
                    ELSE 'Other'
                END
                AS gender
                FROM
                Users JOIN roles
                ON Users.role_id = roles.role_id
                WHERE roles.role_name = <cfqueryparam value=#role# cfsqltype="cf_sql_varchar"/>
        </cfquery>
        <cfreturn qryPatientList/>
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

</cfcomponent>