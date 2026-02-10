<cfquery name="getDeptInfo" datasource="DSEms">
    SELECT * FROM Department;
</cfquery>

<head>
    <title>Assignment-5</title>
    <link rel="stylesheet" type="text/css" href="../styles/style.css"/>
</head>
<body>
    <h1>Employee Management System (EMS)</h1>
    <main class="main-container">
        <form method="POST" action="insert.cfm">
            <h4>Add New Employee</h4>
            <div>
                <label for="first_name">First Name: </label>
                <input name="first_name" type="text"/>
            </div>
            <div>
                <label for="last_name">Last Name: </label>
                <input name="last_name" type="text"/>
            </div>
            <div>
                <label for="dept_id">Department</label>
            <select name="dept_id">
                <cfloop query="#getDeptInfo#">
                    <cfoutput>
                        <option value="#getDeptInfo.dept_id#">#getDeptInfo.dept_name#</option>
                    </cfoutput>
                </cfloop>
            </select>
            </div>
            <div>
                <label for="salary">Salary(min-10,001): </label>
                <input name="salary" type="number"/>
            </div>
            <div>
                <label for="email">Email: </label>
                <input name="email" type="email"/>
            </div>
            <div>
                <label for="hire_date">Hire Date: </label>
                <input name="hire_date" type="date"/>
            </div>
            <div>
                <button type="submit" name="insertUsingcfquery">Add(Uses cfquery)</button>
                <button type="submit" name="insertUsingproc">Add(Uses stored procesure)</button>
            </div>
            <a href="../index.cfm">Go Back</a>
        </form>
    </main>
    
</body>