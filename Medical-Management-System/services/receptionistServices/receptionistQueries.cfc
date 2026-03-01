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
</cfcomponent>