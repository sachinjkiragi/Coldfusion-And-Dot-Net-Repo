<cfcomponent>

    <cffunction name="isNameValid" returntype="boolean" access="private">
        <cfargument name="name" required="true" type="string"/>
        <cfreturn reFindNoCase("^[a-z][a-z ]{0,19}$", arguments.name)/>
    </cffunction>

    <cffunction name = "isPhoneValid" returntype="boolean" access="private">
        <cfargument name="phone" required="true" type="string">
        <cfreturn reFind("^[0-9]{10}$", arguments.phone)/>
    </cffunction>

    <cffunction name = "isAgeValid" returntype="boolean" access="private">
        <cfargument name="age" required="true" type="numeric">
        <cfreturn arguments.age GTE 18 AND arguments.age LTE 150/>
    </cffunction>

    <cffunction name = "isUserDetailsValid" returntype="struct" access="public">
        <cfargument name="formData" required="true" type="struct"/>
        <cfset var errors = {}/>

        <cfif isNameValid(arguments.formData.name) EQ false>
            <cfset var errors.name = true/>
        </cfif>

        <cfif isPhoneValid(arguments.formData.phone) EQ false>
            <cfset var errors.phone = true/>
        </cfif>
        
        <cfif isAgeValid(arguments.formData.age) EQ false>
            <cfset var errors.age = true/>
        </cfif>

        <cfreturn errors/>
    </cffunction>
</cfcomponent>