<cfset error = false/>
<cfif structKeyExists(url, "deleteUsingQuery")>
    <cftry>
        <cfquery name="deleteEmp" datasource="DSEms">
            DELETE FROM Employee
            WHERE emp_id = <cfqueryparam value="#url.emp_id#" cfsqltype="cf_sql_varchar"/>
        </cfquery>
    <cfcatch>
        <cfset error = true/>
    </cfcatch>
    </cftry>
</cfif>

<cfif structKeyExists(url, "deleteUsingProc")>
    <cfstoredproc datasource="DSEms" procedure="spEmployeeCrud">
        <cfprocparam value="#url.emp_id#" cfsqltype="CF_SQL_INTEGER"/>
        <cfprocparam value="" cfsqltype="CF_SQL_VARCHAR"/>
        <cfprocparam value="" cfsqltype="CF_SQL_VARCHAR"/>
        <cfprocparam value="" cfsqltype="CF_SQL_INTEGER"/>
        <cfprocparam value="" cfsqltype="CF_SQL_DECIMAL"/>
        <cfprocparam value="" cfsqltype="CF_SQL_VARCHAR"/>
        <cfprocparam value="" cfsqltype="CF_SQL_DATE"/>
        <cfprocparam value="#4#" cfsqltype="CF_SQL_INTEGER"/>
    </cfstoredproc>
</cfif>


<cflocation url="success.cfm?error=#error#"/>
