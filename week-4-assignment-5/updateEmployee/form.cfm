<cfquery name="getDeptInfo" datasource="DSEms">
    SELECT * FROM Department;
</cfquery>

<cfquery name="empDetails" datasource="DSEms">
    SELECT * FROM Employee
    WHERE emp_id = <cfqueryparam value="#url.emp_id#" cfsqltype="cf_sql_integer"/>
</cfquery>

<html>
    <head>
        <title>Assignment-5</title>
        <link rel="stylesheet" type="text/css" href="../styles/style.css"/>
    </head>
</html>
<body>
    <h3>Update Employee With Id <cfoutput>#empDetails.emp_id#</cfoutput> </h3>
    <form method="POST" action = "update.cfm">
        <table border="1">
            <th>First Name</th>
            <th>Last Name</th>
            <th>Department Id</th>
            <th>Salary</th>
            <th>Email</th>
            <th>Hired Date</th>
            <cfoutput>
                <tr>
                    <input type="hidden" name="emp_id" value="#empDetails.emp_id#">
                    <td><input type="text" name="first_name" value="#empDetails.first_name#"></td>
                    <td><input type="text" name="last_name" value="#empDetails.last_name#"></td>
                    <td>
                        <select name="dept_id">
                            <cfloop query="#getDeptInfo#">
                                <cfoutput>
                                    <option value="#getDeptInfo.dept_id#" <cfif empDetails.dept_id EQ getDeptInfo.dept_id>selected</cfif>>#getDeptInfo.dept_name#</option>
                                </cfoutput>
                            </cfloop>
                        </select>
                    </td>
                    <td><input type="number" name="salary" value="#empDetails.salary#"/></td>
                    <td><input type="email" name="email" value="#empDetails.email#"/></td>
                    <td><input type="date" name="hire_date" value="#dateFormat(empDetails.hire_date, "YYYY-MM-DD")#"/></td>
                </tr>
            </cfoutput>
        </table>
        <div>
            <button type="submit" name="updateUsingQuery">Update(Uses cfquery)</button>
            <button type="submit" name="updateUsingProc">Update(Uses procedure)</button>
        </div>
    </form>
    <a href="../index.cfm">Go Back</a>
</body>