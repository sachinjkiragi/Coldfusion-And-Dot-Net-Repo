<cfset arr = [5, 7, 3, 2, 4]/>
<cfset temp = 0/>

<html>
    <head>
        <title>Array Sorting</title>
        <link rel="stylesheet" type="text/css" href="styles/style.css"/>
    </head>
</html>
<body>
    <main class="main-container">

        <h3>Array Before Sorting: </h3>
        <br/>

        <cfloop index="i" from=#1# to=#len(arr)#>
            <cfoutput>#arr[i]#</cfoutput>
        </cfloop>
        <br/>

        <cfloop index="i" from=#1# to=#len(arr)#>
            <cfloop index="j" from=#2# to=#len(arr)-i+1#>
                <cfif arr[j] LT arr[j-1]>
                    <cfset temp = arr[j]/>
                    <cfset arr[j] = arr[j-1]/>
                    <cfset arr[j-1] = temp/>
                </cfif>
            </cfloop>
        </cfloop>

        <br/>
        <h3>Array After Sorting: </h3>
        <br/>

        <cfloop index="i" from=#1# to=#len(arr)#>
            <cfoutput>#arr[i]#</cfoutput>
        </cfloop>

        <br/>
        <br/>
        <a href="index.cfm">Go Back</a>

    </main>
</body>