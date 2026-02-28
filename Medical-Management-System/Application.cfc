<cfcomponent>
    <cfset this.name = "MedicalManagementSystem">
    <cfset this.datasource = "DSMms">
    <cfset this.sessionManagement = true>

    <cffunction name="onRequestStart">
        <cfargument name="targetPage" type="string" required="true">
        <cfsetting showdebugoutput="false">
    </cffunction>
</cfcomponent>