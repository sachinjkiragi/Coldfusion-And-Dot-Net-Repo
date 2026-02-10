<cfparam name = "form.value1" default="0" type="numeric"/>
<cfparam name = "form.value2" default="0" type="numeric"/>
<cfparam name = "form.operator" default="" type="string"/>

<cfset num1 = form.value1/>
<cfset num2 = form.value2/>
<cfset operator = form.operator/>
<cfset result = ""/>

<cfswitch expression="#operator#">
    <cfcase value="+">
        <cfset result = num1 & " + " & num2 & " = " & (num1 + num2)/>
    </cfcase>
    <cfcase value="-">
        <cfset result = num1 & " - " & num2 & " = " & (num1 - num2)/>
    </cfcase>
    <cfcase value="*">
        <cfset result = num1 & " * " & num2 & " = " & (num1 * num2)/>
    </cfcase>
    <cfcase value="/">
        <cfif num2 EQ 0>
            <cfset result = "Divisor can not be 0"/>
        <cfelse>
            <cfset result = num1 & " / " & num2 & " = " & (num1 / num2)/>
        </cfif>
    </cfcase>
    <cfdefaultcase>
        <cfset result = "Invalid Input"/>
    </cfdefaultcase>
</cfswitch>

<cflocation url = "success.cfm?result=#urlEncodedFormat(result)#"/>