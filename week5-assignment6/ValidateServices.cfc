<cfcomponent>

    <cffunction name="isNameValid" returntype="boolean" access="private">
        <cfargument name="name" required="true" type="string"/>
        <cfif len(arguments.name) EQ 0>
            <cfreturn false/>
        <cfelse>
            <cfreturn true/>
        </cfif>
    </cffunction>

    <cffunction name = "isEmailValid" returntype="boolean" access="private">
        <cfargument name="email" required="true" type="string">
        <cfif len(arguments.email) EQ 0>
            <cfreturn false/>
        <cfelse>
            <cfreturn true/>
        </cfif>
    </cffunction>

    <cffunction name = "isPhoneValid" returntype="boolean" access="private">
        <cfargument name="phone" required="true" type="string">
        <cfif len(arguments.phone) NEQ 10>
            <cfreturn false/>
        <cfelse>
            <cfreturn true/>
        </cfif>
    </cffunction>

    <cffunction name = "isAgeValid" returntype="boolean" access="private">
        <cfargument name="age" required="true" type="string">
        <cfif arguments.age LTE 18>
            <cfreturn false/>
        <cfelse>
            <cfreturn true/>
        </cfif>
    </cffunction>

    <cffunction name = "isUserDetailsValid" returntype="struct" access="public">
        <cfargument name="formData" required="true" type="struct"/>
        <cfset var errors = {}/>
        
        <cfif isNameValid(arguments.formData.name) EQ false>
            <cfset errors.name = "Invalid Name"/>
        </cfif>

        <cfif isEmailValid(arguments.formData.name) EQ false>
            <cfset errors.email = "Invalid Email"/>
        </cfif>
        
        <cfif isPhoneValid(arguments.formData.phone) EQ false>
            <cfset errors.phone = "Invalid Phone"/>
        </cfif>
        
        <cfif isAgeValid(arguments.formData.age) EQ false>
            <cfset errors.age = "Invalid Age (must be greater than 18)"/>
        </cfif>

        <cfreturn errors/>
    </cffunction>
</cfcomponent>

