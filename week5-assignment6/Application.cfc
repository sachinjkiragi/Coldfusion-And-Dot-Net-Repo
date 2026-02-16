<cfcomponent>
    <cfset this.name = "MyApp"/>
    <cfset this.customTagPaths = "customtags">
    <cfset this.sessionManagement = true/>
    <cfset this.applicationTimeout = createTimespan(0, 1, 0, 0)/>
    <cfset this.sessionTimeOut = createTimespan(0, 0, 20, 0)/>
    <cfset this.datasource = "dstemp"/>

    <cffunction name="onApplicationStart" returntype="boolean">
        <cfset application.sessions = 0/>
        <cflog file=#this.name# text="Application Started"/>

        <cfset dbTestError = true/>
        <cfquery name="dbTest">
                SELECT TOP 2 id FROM Person;
            </cfquery>
        <cftry>
        <cfcatch>
            <cfset dbTestError = false/>
        </cfcatch>
        </cftry>

        <cfif dbTestError EQ true>
            <cflog file=#this.name# text="Database connected succesfully"/>
        <cfelse>
            <cflog file=#this.name# text="Error happened when trying to connect DB"/>
        </cfif>

        <cfreturn true/>
    </cffunction>

    <cffunction name="onApplicationEnd">
        <cfargument name="ApplicationScope" required="true"/>
        <cflog file=#this.name# text="Application Ended"/>
    </cffunction>

    <cffunction name="onSessionStart">
        <cfset session.started = now()/>

        <cflock scope="Application" timeout="5" type="Exclusive">
            <cfset application.sessions = application.sessions + 1>
        </cflock>

        <cflog file=#this.name# text="A new Session Satrted with session id: #session.sessionId#. No of sessions at #now()# = #application.sessions#"/>

        <cflog file=#session.sessionId# text="Session Started"/>
    </cffunction>

    <cffunction name="onSessionEnd">
        <cfargument name="SessionScope" required="true"/>
        <cfargument name="ApplicationScope" required="true"/>

        <cfset sessionLength = timeFormat(now() - SessionScope.started, "H:mm:ss")/>
        <cflock scope="Application" timeout="5" type="Exclusive">
            <cfset application.sessions = application.sessions - 1/>
        </cflock>

        <cflog file=#this.name# text="Session With session Id: #SessionScope.sessionId# Ended. Session Length = #sessionLength#"/>
    </cffunction>

    <cffunction name="onRequestStart" returntype="boolean">
        <cfargument type="string" name="targetPage" required="true"/>
        <cflog file="#session.sessionId#" text="Request for page #listLast(targetPage, '/')# Started"/>
        <cfreturn true/>
    </cffunction>

    <cffunction name="onRequestEnd">
        <cfargument type="string" name="targetPage" required="true"/>
        <cflog file="#session.sessionId#" text="Request for page #listLast(targetPage, '/')# Ended"/>
    </cffunction>

    <cffunction name="onMissingTemplate" returntype="boolean">
        <cfargument type="string" name="targetPage" required="true"/>
            <cfoutput>
                <h1>#listLast(targetPage, '/')# Not Found! <br/> The page you are trying to access does not exists </h1>
                <a href="/coldfusion-tutorial/week5-assignment6/index.cfm">Go Back To Initial Page</a>
            </cfoutput>
            <cflog type="error" file="#session.sessionId#" text="Request for a page (#targetPage#) which does not exists"/>
            <cfreturn true/>
        </cffunction>
</cfcomponent>