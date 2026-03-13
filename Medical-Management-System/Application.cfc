<cfcomponent>
    <cfset this.name = "MedicalManagementSystem">
    <cfset this.datasource = "DSMms">
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimeSpan(0,0,30,0)/>

    <cffunction name="onRequestStart">
        <cfargument name="targetPage" type="string" required="true">
        <cfsetting showdebugoutput="false">
        
        <cfif listContains(targetPage, "modules", "/") NEQ 0 AND structKeyExists(session, "currUser") EQ false>
            <cfset structClear(session)/>
            <cflog file="medManageLogs" text="Unauthorized Access By User" type="error"/>
            <cflocation url="/Coldfusion-And-Dot-Net-Repo/Medical-Management-System/noPermission.cfm">
        </cfif>
    </cffunction>


    <!---<cffunction name="onError" returntype="void">
        <cfargument name="exception" required="true">
        <cfargument name="eventName" required="true">
        <cfset errorMessage = " Error Message: #arguments.exception.message#
        Detail: #arguments.exception.detail#
        Event: #arguments.eventName#
        Time: #now()#">
        <cflog file="medManageLogs" text="#errorMessage#" type="error">
        <cflocation url="/Coldfusion-And-Dot-Net-Repo/Medical-Management-System/error.cfm">
    </cffunction>--->

</cfcomponent>