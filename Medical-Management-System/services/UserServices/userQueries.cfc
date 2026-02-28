<cfcomponent>
    <cffunction name="getDepartments" returntype="query">
        <cfquery name="departments">
            SELECT * FROM Departments;
        </cfquery>
        <cfreturn departments/>
    </cffunction>
</cfcomponent>