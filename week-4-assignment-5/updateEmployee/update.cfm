<cfdump var="#form#"/>
<cfset error = false/>

<cfif structKeyExists(form, "updateUsingcfquery")>
    <cftry>
        <cfquery name="updateEmp" datasource="DSEms">
            UPDATE Employee
            SET 
            first_name = <cfqueryparam value="#form.first_name#" cfsqltype="cf_sql_varchar"/>,
            last_name = <cfqueryparam value="#form.last_name#" cfsqltype="cf_sql_varchar"/>,
            dept_id = <cfqueryparam value="#form.dept_id#" cfsqltype="integer"/>,
            salary = <cfqueryparam value="#form.salary#" cfsqltype="cf_sql_decimal"/>,
            email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar"/>,
            hire_date = <cfqueryparam value="#form.hire_date#" cfsqltype="cf_sql_date"/>
            WHERE emp_id = <cfqueryparam value="#form.emp_id#" cfsqltype="cf_sql_integer"/>
        </cfquery>
        <cfcatch>
            <cfset error = true/>
        </cfcatch>   
    </cftry>
</cfif>

<cfif structKeyExists(form, "updateUsingProc")>
    <h3>Hello</h3>
    <cftry>
        <cfstoredproc datasource="DSEms" procedure="spEmployeeCrud">
            <cfprocparam value="#form.emp_id#" cfsqltype="CF_SQL_INTEGER"/>
            <cfprocparam value="#form.first_name#" cfsqltype="CF_SQL_VARCHAR"/>
            <cfprocparam value="#form.last_name#" cfsqltype="CF_SQL_VARCHAR"/>
            <cfprocparam value="#form.dept_id#" cfsqltype="CF_SQL_INTEGER"/>
            <cfprocparam value="#form.salary#" cfsqltype="CF_SQL_DECIMAL"/>
            <cfprocparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR"/>
            <cfprocparam value="#form.hire_date#" cfsqltype="CF_SQL_DATE"/>
            <cfprocparam value="#2#" cfsqltype="CF_SQL_INTEGER"/>
        </cfstoredproc>
    <cfcatch>
        <cfset error = true/>
    </cfcatch>   
    </cftry>
</cfif>

<cflocation url="success.cfm?error=#error#"/>