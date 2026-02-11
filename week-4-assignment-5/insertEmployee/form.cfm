<cfquery name="getDeptInfo" datasource="DSEms">
    SELECT * FROM Department;
</cfquery>
<cfquery name="getEmails" datasource="DSEms">
    SELECT email FROM Employee;
</cfquery>

<cfscript>
    existingEmails = [];
    for (i = 1; i <= getEmails.recordCount; i++) {
        arrayAppend(existingEmails, getEmails.email[i]);
    }
</cfscript>

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
                <input name="first_name" type="text" required/>
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
                <input id="salary" name="salary" type="number"/>
            </div>
            <div>
                <label for="email">Email: </label>
                <input id='email' name="email" type="email" required/>
            </div>
            <div>
                <label for="hire_date">Hire Date: </label>
                <input name="hire_date" type="date" required/>
            </div>
            <div>
                <button class="btn" type="submit" name="insertUsingQuery">Add(Uses cfquery)</button>
                <button class="btn" type="submit" name="insertUsingproc">Add(Uses stored procesure)</button>
            </div>
            <a href="../index.cfm">Go Back</a>
        </form>
    </main>
    
    <cfoutput>
        <script>
            var btns = document.getElementsByClassName('btn');
            var salary = document.getElementById('salary');
            var email = document.getElementById('email');
            Array.from(btns).forEach(function(btn){
                btn.addEventListener('click', (e)=>{
                    if(salary.value <= 10000){
                        alert('salary must be greater than 10,000');
                        e.preventDefault();
                        return;
                    }
                    const jsonMails = #serializeJSON(existingEmails)#;
                    if(jsonMails.includes(email.value) == true){
                        alert('Email Exists Aleready! Enter different Email');
                        e.preventDefault();
                    }
                });
            })
        </script>
    </cfoutput>
</body>
