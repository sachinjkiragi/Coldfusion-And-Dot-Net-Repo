<cfcomponent>
    <cffunction name="getDepartments" returntype="query">
        <cfquery name="departments">
            SELECT * FROM Departments;
        </cfquery>
        <cfreturn departments/>
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

</cfcomponent>