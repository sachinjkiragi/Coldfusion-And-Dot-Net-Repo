<html>
    <head>
        <title>Prime or Not</title>
        <link rel="stylesheet" type="text/css" href="../../styles/style.css"/>
    </head>
    <body>
        <main class="main-container">
            <cfif structKeyExists(url, "isPrime") && structKeyExists(url, "inputNumber")>
                <cfif url.isPrime EQ true>
                    <cfoutput><h3>#url.inputNumber# Is Prime</h3></cfoutput>
                <cfelse>
                    <cfoutput><h3>#url.inputNumber# Is Not Prime</h3></cfoutput>
                </cfif>
            </cfif>
            <br/>
            <br/>
            <a href="form.cfm">Go Back To Form</a>
        </main>
    </body>
</html>