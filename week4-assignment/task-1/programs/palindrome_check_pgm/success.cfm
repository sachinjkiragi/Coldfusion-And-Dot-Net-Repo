<html>
    <head>
        <title>Prime or Not</title>
        <link rel="stylesheet" type="text/css" href="../../styles/style.css"/>
    </head>
    <body>
        <main class="main-container">
            <cfif structKeyExists(url, "isPalindrome") && structKeyExists(url, "inputString")>
                <cfif url.isPalindrome EQ true>
                    <cfoutput><h3>#url.inputString# Is Palindrome</h3></cfoutput>
                <cfelse>
                    <cfoutput><h3>#url.inputString# Is Not Palindrome</h3></cfoutput>
                </cfif>
            </cfif>
            <br/>
            <br/>
            <a href="form.cfm">Go Back To Form</a>
        </main>
    </body>
</html>