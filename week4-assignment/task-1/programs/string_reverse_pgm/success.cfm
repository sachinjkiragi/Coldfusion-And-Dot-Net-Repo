<html>
    <head>
        <title>Prime or Not</title>
        <link rel="stylesheet" type="text/css" href="../../styles/style.css"/>
    </head>
    <body>
        <main class="main-container">
            <cfif structKeyExists(url, "originalString") && structKeyExists(url, "reversedString")>
                <cfoutput><h3>
                    Original string: #url.originalString#
                    <br/>
                    Reversed String: #url.reversedString# 
                </h3></cfoutput>
            </cfif>
            <br/>
            <br/>
            <a href="form.cfm">Go Back To Form</a>
        </main>
    </body>
</html>