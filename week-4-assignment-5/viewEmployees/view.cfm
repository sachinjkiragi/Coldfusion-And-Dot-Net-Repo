<cfif structKeyExists(url, "usingProcedure") AND url.usingProcedure EQ 1>
    <cfstoredproc datasource="DSEms" procedure="spEmployeeCrud">
        <cfprocparam value="" cfsqltype="CF_SQL_INTEGER"/>
        <cfprocparam value="" cfsqltype="CF_SQL_VARCHAR"/>
        <cfprocparam value="" cfsqltype="CF_SQL_VARCHAR"/>
        <cfprocparam value="" cfsqltype="CF_SQL_INTEGER"/>
        <cfprocparam value="" cfsqltype="CF_SQL_DECIMAL"/>
        <cfprocparam value="" cfsqltype="CF_SQL_VARCHAR"/>
        <cfprocparam value="" cfsqltype="CF_SQL_DATE"/>
        <cfprocparam value="#0#" cfsqltype="CF_SQL_INTEGER"/>
        <cfprocresult name="employees"/>
    </cfstoredproc>
<cfelse>
    <cfquery name="employees" datasource="DSEms">
        SELECT 
            emp_id,
            first_name,
            last_name,
            dept_name,
            salary,
            email,
            hire_date
        FROM Employee JOIN Department
        ON employee.dept_id = Department.dept_id;
    </cfquery>
</cfif>

<html>
    <head>
        <title>Assignment-5</title>
        <link rel="stylesheet" type="text/css" href="../styles/style.css"/>
    </head>
    <style>
        table a{
            all: unset;
            cursor: pointer;
            text-decoration: underline;
            color: blue;
        }
    </style>
</html>
<body>
    <h1>Employee Management System (EMS)</h1>
    <h3>Employees </h3>
    <table border="1">
        <th>Id</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Department Id</th>
        <th>Salary</th>
        <th>Email</th>
        <th>Hired Date</th>
        <cfoutput query="employees">
            <form method="POST">
                <tr>
                    <td>#employees.emp_id#</td>
                    <td>#employees.first_name#</td>
                    <td>#employees.last_name#</td>
                    <td>#employees.dept_name#</td>
                    <td>#employees.salary#</td>
                    <td>#employees.email#</td>
                    <td>#dateFormat(employees.hire_date, 'DD-MM-YYYY')#</td>
                    <td><a href="../updateEmployee/form.cfm?emp_id=#employees.emp_id#">Update</a></td>
                    <td><a href="../deleteEmployee/delete.cfm?emp_id=#employees.emp_id#&deletUsingcfquery=1">Delete(Uses cfquery)</a></td>
                    <td><a href="../deleteEmployee/delete.cfm?emp_id=#employees.emp_id#&deletUsingProc=1">Delete(Uses procedures)</a></td>
                </tr>
            </form>
        </cfoutput>
    </table>
    <a href="../index.cfm">Go Back</a>
</body>