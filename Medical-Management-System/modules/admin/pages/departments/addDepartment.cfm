<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <cfinclude template = "../../../../includes/toast.cfm"/>
    <div class="h-100 w-100 d-flex justify-content-center align-items-center">
        <form class="p-5 needs-validation" novalidate method="POST">
            <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Add Department</h2>
                </div>

                <div class="d-flex gap-4">
                    <div class="form-check d-flex flex-column gap-4 align-items-center">
                        <div>
                            <label class="form-label fw-semibold">Department Name:</label>
                            <input name="departmentName" class="form-control" type="text" id="departmentName" required placeholder="Department Name*"/>
                            <div class="invalid-feedback">
                                Please enter a department name.
                            </div>
                        </div>
                        <span title="Please complete all required fields">
                            <button class="btn btn-primary" type="submit" name="addBtn"> Add </button>
                        </span>
                        <a href="home.cfm?reqPage=Departments" class="text-decoration-none">Go Back</a>
                    </div>
            </div>
        </form>
    </div>

</html>

<script>
    const formEle = document.querySelector('.needs-validation')
    formEle.addEventListener('submit', (e)=>{
        if(!formEle.checkValidity()){
            e.preventDefault();
        }
        formEle.classList.add('was-validated');
    })
</script>

<cfif structKeyExists(form, "addbtn")>

    <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="DepartmentExists" returnvariable="flag">
        <cfinvokeargument name="departmentName" value="#form.departmentName#"/>
    </cfinvoke>

    <cfif flag EQ true>
        <script>
            showToast('Department already exists.', 'warning');
        </script>
    <cfelse>
        <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="addDepartment" returnvariable="success">
            <cfinvokeargument name="DepartmentData" value="#form#"/>
        </cfinvoke>
        
        <cfif success EQ true>
            <script>
                showToast('Department added successfully.', 'success');
            </script>
        <cfelse>
            <script>
                showToast('Failed to add Department. Please try again.', 'warning');
            </script>
        </cfif>
    </cfif>
</cfif>
