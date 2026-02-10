<html>
    <head>
        <title>Assignment-5</title>
        <link rel="stylesheet" type="text/css" href="../styles/style.css"/>
    </head>
<body>
    <h1>Employee Management System (EMS)</h1>
    <cfif structKeyExists(url, "error")>
        <cfif url.error EQ true>
            <h3>Error Occurred While Inserting A Employee.</h3>
        <cfelse>
            <h3>Employee Inserted Successfully.</h3>
        </cfif>
    </cfif>
    <a href="form.cfm">Go Back</a>
</body>
</html>