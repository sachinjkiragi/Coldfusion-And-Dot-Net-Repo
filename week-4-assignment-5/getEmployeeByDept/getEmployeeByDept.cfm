<cfquery name="getDeptInfo" datasource="DSEms">
    SELECT * FROM Department;
</cfquery>

<cfif structKeyExists(form, "getByDeptIdUsingQuery")>
    <cfquery name="employeesByDept" datasource="DSEms">
        SELECT 
            emp_id,
            first_name,
            last_name,
            dept_name,
            salary,
            email,
            hire_date
        FROM Employee JOIN Department
        ON employee.dept_id = Department.dept_id
        WHERE employee.dept_id = <cfqueryparam value="#form.dept_id#" cfsqltype="cf_sql_integer"/>
    </cfquery>
</cfif>

<cfif structKeyExists(form, "getByDeptIdUsingProc")>
    <cfstoredproc datasource="DSEms" procedure="spGetEmployeeByDept">
        <cfprocparam value="#form.dept_id#" cfsqltype="cf_sql_integer"/>
        <cfprocresult name="employeesByDept"/>
    </cfstoredproc>
</cfif>


<html>
    <head>
        <title>Assignment-5</title>
        <link rel="stylesheet" type="text/css" href="../styles/style.css"/>
    </head>
</html>
<body>
    <h1>Employee Management System (EMS)</h1>
        <h4>Select Department</h4>
        <form method="POST">
            <select name="dept_id">
                <cfloop query="#getDeptInfo#">
                <cfoutput>
                        <option value="#getDeptInfo.dept_id#">#getDeptInfo.dept_name#</option>
                    </cfoutput>
                </cfloop>
            </select>
            <div>
                <button name="getByDeptIdUsingQuery">Get Employees (Uses cfquery)</button>
                <button name="getByDeptIdUsingProc">Get Employees (Uses Procedures)</button>
            </div>
        </form>

        <cfif structKeyExists(variables, "employeesByDept")>
            <h3>Employees From <cfoutput>#employeesByDept.dept_name# Department</cfoutput> </h3>
            <table border="1">
                <th>Id</th>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Department Id</th>
                <th>Salary</th>
                <th>Email</th>
                <th>Hired Date</th>
                <cfoutput query="employeesByDept">
                    <form method="POST">
                        <tr>
                            <td>#employeesByDept.emp_id#</td>
                            <td>#employeesByDept.first_name#</td>
                            <td>#employeesByDept.last_name#</td>
                            <td>#employeesByDept.dept_name#</td>
                            <td>#employeesByDept.salary#</td>
                            <td>#employeesByDept.email#</td>
                            <td>#dateFormat(employeesByDept.hire_date, 'DD-MM-YYYY')#</td>
                        </tr>
                    </form>
                </cfoutput>
            </table>
            <h4>Record Count: <cfoutput>#employeesByDept.recordCount#</cfoutput> </h4>
        </cfif>
    <a href="../index.cfm">Go Back</a>
</body>


