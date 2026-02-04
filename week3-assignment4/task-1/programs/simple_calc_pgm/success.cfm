<html>
    <head>
        <title>Simple Calculator</title>
        <link rel="stylesheet" type="text/css" href="../../styles/style.css"/>
    </head>
    <body>
        <main class="main-container">
            <cfif structKeyExists(url, "result")>
                <cfoutput><h3>#url.result#</h3></cfoutput>
            </cfif>
            <br/>
            <br/>
            <a href="form.cfm">Go Back To Form</a>

        </main>
    </body>
</html>