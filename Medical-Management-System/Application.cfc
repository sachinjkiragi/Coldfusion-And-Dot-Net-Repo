<cfcomponent>
    <cfset this.name = "MedicalManagementSystem">
    <cfset this.datasource = "DSMms">
    <cfset this.sessionManagement = true>

    <cffunction name="onRequestStart">
        <cfargument name="targetPage" type="string" required="true">
        <cfsetting showdebugoutput="false">

        <cfif listContains(targetPage, "modules", "/") NEQ 0 AND structKeyExists(session, "currUser") EQ false>
            <cflocation url="../../index.cfm"/>
        </cfif>

    </cffunction>
</cfcomponent>