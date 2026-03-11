<cfcomponent>
    <cffunction name="getDepartments" returntype="query">
        <cfquery name="departments">
            SELECT * FROM Departments;
        </cfquery>
        <cfreturn departments/>
    </cffunction>

    <cffunction name="getRoles" returntype="query">
        <cfquery name="roles">
            SELECT * FROM roles;
        </cfquery>
        <cfreturn roles/>
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


    <cffunction name="insertUserData" returntype="boolean">
        <cfargument name="userData" type="struct"/>
        <cfset success = true/>

        <cftry>
            <cfquery name="qryInsert">
                INSERT INTO Users (first_name, last_name, email, phone, password, role_id, gender, department_id)
                VALUES (
                    <cfqueryparam value="#arguments.userData.firstName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.userData.lastName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.userData.email#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.userData.phone#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.userData.password#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.userData.role_id#" cfsqltype="cf_sql_integer"/>,
                    <cfqueryparam value="#arguments.userData.gender#" cfsqltype="cf_sql_char"/>,
                    <cfqueryparam value="#arguments.userData.department_id#" cfsqltype="cf_sql_integer"/>
                )
            </cfquery>
        <cfcatch>
            <cfset success = false/>
        </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

    <cffunction name="isUserValid" returntype="query">
        <cfargument name="credentials" type="struct"/>
        <cfquery name="qryValidUser">
            SELECT *
            FROM Users 
            WHERE
            email = <cfqueryparam value=#credentials.email# cfsqltype="cf_sql_varchar"/>
            AND
            password = <cfqueryparam value=#credentials.password# cfsqltype="cf_sql_varchar"/>
        </cfquery>
        <cfreturn qryValidUser/>
    </cffunction>

    <cffunction name="resetPassword" returntype="boolean">
        <cfargument name="email" type="string"/>
        <cfargument name="password" type="string"/>
        <cfdump var=#arguments.email#/>
        <cfdump var=#arguments.password#/>
        <cfset success = true/>
        <cftry>
            <cfquery name="qryResetPassword">
                UPDATE Users 
                SET password = <cfqueryparam value="#arguments.password#" cfsqltype="cf_sql_varchar"/>
                WHERE email = <cfqueryparam value="#arguments.email#" cfsqltype="cf_sql_varchar"/>
            </cfquery>
            <cfcatch>
                <cfset success = false/>
            </cfcatch>
        </cftry>
        <cfreturn success/>
    </cffunction>

</cfcomponent>