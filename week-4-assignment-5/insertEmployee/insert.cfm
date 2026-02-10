<cfset error = false/>

<cfif form.salary EQ "" OR form.salary LTE 10000>
    <cflocation url="success.cfm?error=#true#&salaryError=#true#"/>
</cfif>

<cfif structKeyExists(form, "insertUsingcfquery")>
    <cftry>
        <cfquery name="inserted" datasource="DSEms">
            INSERT INTO Employee
            VALUES (
                <cfqueryparam value=#form.first_name# cfsqltype="cf_sql_varchar"/>,
                <cfqueryparam value=#form.last_name# cfsqltype="cf_sql_varchar"/>,
                <cfqueryparam value=#form.dept_id# cfsqltype="cf_sql_integer"/>,
                <cfqueryparam value=#form.salary# cfsqltype="cf_sql_decimal"/>,
                <cfqueryparam value=#form.email# cfsqltype="cf_sql_varchar"/>,
                <cfqueryparam value=#form.hire_date# cfsqltype="cf_sql_date"/>
            )
        </cfquery>
        <cfcatch>
            <cfset error = true/>
        </cfcatch>
    </cftry>
</cfif>
    

<cfif structKeyExists(form, "insertUsingproc")>
<cftry>
    <cfstoredproc datasource="DSEms" procedure="spEmployeeCrud">
        <cfprocparam value="" cfsqltype="CF_SQL_INTEGER"/>
        <cfprocparam value="#form.first_name#" cfsqltype="CF_SQL_VARCHAR"/>
        <cfprocparam value="#form.last_name#" cfsqltype="CF_SQL_VARCHAR"/>
        <cfprocparam value="#form.dept_id#" cfsqltype="CF_SQL_INTEGER"/>
        <cfprocparam value="#form.salary#" cfsqltype="CF_SQL_DECIMAL"/>
        <cfprocparam value="#form.email#" cfsqltype="CF_SQL_VARCHAR"/>
        <cfprocparam value="#form.hire_date#" cfsqltype="CF_SQL_DATE"/>
        <cfprocparam value="#1#" cfsqltype="CF_SQL_INTEGER"/>
    </cfstoredproc>
<cfcatch>
    <cfset error = true/>
</cfcatch>
</cftry>
</cfif>

<cflocation url="success.cfm?error=#error#"/>