<cfcomponent>
    <cfset this.name = "localBlog"/>

    <cffunction name="onError">
        <cfargument name="Exception" required=true/>
        <cfargument type="String" name="EventName" required=true/>
        <cflog file="#This.Name#" type="error" text="Event Name: #Arguments.Eventname#" >
        <cflog file="#This.Name#" type="error" text="Message: #Arguments.Exception.message#">
        <cfoutput>
            <h4>Unexpected Error Occurred, Please Contact Admin.</h4>
        </cfoutput>
    </cffunction>

</cfcomponent>