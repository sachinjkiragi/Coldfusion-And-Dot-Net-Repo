<cfcomponent>

    <cffunction name="isNameValid" returntype="boolean" access="private">
        <cfargument name="name" required="true" type="string"/>
        <cfif len(name) EQ 0>
            <cfreturn false/>
        <cfelse>
            <cfreturn true/>
        </cfif>
    </cffunction>

    <cffunction name = "isEmailValid" returntype="boolean" access="private">
        <cfargument name="email" required="true" type="string">
        <cfif len(email) EQ 0>
            <cfreturn false/>
        <cfelse>
            <cfreturn true/>
        </cfif>
    </cffunction>

    <cffunction name = "isPhoneValid" returntype="boolean" access="private">
        <cfargument name="phone" required="true" type="string">
        <cfif len(phone) NEQ 10>
            <cfreturn false/>
        <cfelse>
            <cfreturn true/>
        </cfif>
    </cffunction>

    <cffunction name = "isAgeValid" returntype="boolean" access="private">
        <cfargument name="pagehone" required="true" type="string">
        <cfif age LTE 18>
            <cfreturn false/>
        <cfelse>
            <cfreturn true/>
        </cfif>
    </cffunction>

    <cffunction name = "isUserDetailsValid" returntype="struct" access="public">
        <cfargument name="formData" required="true" type="struct"/>
        <cfset errors = {}/>
        
        <cfif isNameValid(formData.name) EQ false>
            <cfset errors.name = "Invalid Name"/>
        </cfif>

        <cfif isEmailValid(formData.name) EQ false>
            <cfset errors.email = "Invalid Email"/>
        </cfif>
        
        <cfif isPhoneValid(formData.phone) EQ false>
            <cfset errors.phone = "Invalid Phone"/>
        </cfif>
        
        <cfif isAgeValid(formData.age) EQ false>
            <cfset errors.age = "Invalid Age (must be greater than 18)"/>
        </cfif>

        <cfreturn errors/>
    </cffunction>
</cfcomponent>