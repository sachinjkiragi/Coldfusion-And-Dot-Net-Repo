<cfparam name = "form.inputNumber" default="0" type="numeric"/>

<cfset numToCheckForPrime = #form.inputNumber#/>
<cfset isPrime = true/>
<cfset i = 2/>

<cfif numToCheckForPrime LTE 0>
    <cflocation url = "form.cfm?isPrime=#false#&inputNumber=#numToCheckForPrime#"/>
</cfif>

<cfloop condition = "#i * i LTE numToCheckForPrime#">
    <cfif numToCheckForPrime % i EQ 0>
        <cfset isPrime = false/>
        <cfbreak/>
    </cfif>
    <cfset i++/>
</cfloop>

<cflocation url = "success.cfm?isPrime=#isPrime#&inputNumber=#numToCheckForPrime#"/>