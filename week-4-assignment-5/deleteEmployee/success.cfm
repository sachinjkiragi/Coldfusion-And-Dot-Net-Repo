<html>
    <head>
        <title>Assignment-5</title>
        <link rel="stylesheet" type="text/css" href="../styles/style.css"/>
    </head>
</html>
<body>
    <h1>Employee Management System (EMS)</h1>
    <cfif url.error EQ false>
        <h3>Employee Deleted Successfully.</h3>
    <cfelse>
        <h3>Error Occurred While Deleting An Employee</h3>
    </cfif>
    <a href="../viewEmployees/view.cfm">Go Back</a>
</body>