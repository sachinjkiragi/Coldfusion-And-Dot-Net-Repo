<cfparam name = "form.inputString" default="0" type="string"/>

<cfset inputString = form.inputString/>
<cfset isPalindrome = true/>
<cfset i = 1/>
<cfset j = len(inputString)/>

<cfloop condition =  "#i < j#">
    <cfif inputString[i] EQ inputString[j]>
        <cfset i++/>
        <cfset j--/>
    <cfelse>
        <cfset isPalindrome = false/>
        <cfbreak/>
    </cfif>
</cfloop>

<cflocation url = "success.cfm?isPalindrome=#isPalindrome#&inputString=#inputString#"/>