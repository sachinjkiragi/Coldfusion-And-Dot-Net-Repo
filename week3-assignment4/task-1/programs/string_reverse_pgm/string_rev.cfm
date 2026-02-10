<cfparam name = "form.inputString" default="0" type="string"/>

<cfset originalString = toString(form.inputString)/>
<cfset reversedString = ""/>
<cfset isPalindrome = true/>
<cfset i = len(originalString)/>

<cfloop condition="#i >= 1#">
    <cfset reversedString = insert(originalString[i], reversedString, len(reversedString))/> <br/>
    <cfset i--/>
</cfloop>

<cflocation url = "success.cfm?originalString=#originalString#&reversedString=#reversedString#"/>