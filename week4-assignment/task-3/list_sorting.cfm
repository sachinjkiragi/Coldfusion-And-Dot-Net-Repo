<cfset list = "4,6,5,3,2,1"/>
<cfset delimeter = ','/>
<cfset val1 = -1/>
<cfset val2 = -1/>

<cfset arr = [5, 7, 3, 2, 4]/>
<cfset temp = 0/>

<html>
    <head>
        <title>List Sorting</title>
        <link rel="stylesheet" type="text/css" href="styles/style.css"/>
    </head>
</html>
<body>
    <main class="main-container">
        
        <h3>List Before Sorting: </h3>
        <br/>

        <cfloop index="i" from=#1# to=#listLen(list)#>
            <cfoutput>
                #listGetAt(list, i, delimeter)#
            </cfoutput>
        </cfloop>

        <br/>

        <cfloop index="i" from=#1# to=#listLen(list)#>
            <cfloop index="j" from=#1# to=#listLen(list)-1#>
                <cfset val1 = listGetAt(list, j, delimeter)/>
                <cfset val2 = listGetAt(list, j+1, delimeter)/>
                <cfif val1 GT val2>
                    <cfset list = listSetAt(list, j+1, val1, delimeter)/>
                    <cfset list = listSetAt(list, j, val2, delimeter)/>
                </cfif>
            </cfloop>
        </cfloop>

        <br/>
        <h3>List After Sorting: </h3>
        <br/>

        <cfloop index="i" from=#1# to=#listLen(list)#>
            <cfoutput>
                #listGetAt(list, i, delimeter)#
            </cfoutput>
        </cfloop>

        <br/>
        <br/>

        <a href="index.cfm">Go Back</a>
    </main> 
</body>
