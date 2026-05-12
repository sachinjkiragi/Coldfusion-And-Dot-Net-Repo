<cfset departmentIdToUpdate = url.departmentId/>

<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getdepartmentDataById" returnvariable="departmentData">
    <cfinvokeargument name="departmentId" value="#departmentIdToUpdate#"/>
</cfinvoke>


<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <cfinclude template = "../../../../includes/toast.cfm"/>
    <div class="h-100 w-100 d-flex justify-content-center align-items-center">
        <cfoutput>
            <form class="p-5 needs-validation" novalidate method="POST">
                <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                    <div>
                        <h2 class="text-primary">Update Department</h2>
                    </div>
                    
                    <div class="d-flex gap-4">
                        <div class="form-check d-flex flex-column gap-4 align-items-center">
                        <div>
                            <label class="form-label fw-semibold">Department Name:</label>
                            <input name="departmentName" class="form-control" type="text" id="departmentName" required placeholder="Department Name*" value="#departmentData.department_name#"/>
                            <div class="invalid-feedback">
                                Please enter a department name.
                            </div>
                        </div>
                        <span title="Please complete all required fields">
                            <button class="btn btn-primary" type="submit" name="updatedepartmentId"> Update </button>
                        </span>
                        <a href="home.cfm?reqPage=Departments" class="text-decoration-none">Go Back</a>
                    </div>
                </div>
            </form>
        </cfoutput>
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

<cfif structKeyExists(form, "updatedepartmentId")>
    <cfset departmentExists = false/>
    
    <cfif departmentData.department_name NEQ form.departmentName>
        <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="departmentExists" returnvariable="flag">
            <cfinvokeargument name="departmentName" value="#form.departmentName#"/>
        </cfinvoke>        
        <cfif flag EQ true>    
            <cfset departmentExists = true/>
        </cfif>
    </cfif>

    <cfif departmentExists EQ false>
        <cfset form.departmentId = departmentIdToUpdate/>
        <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="updateDepartment" returnvariable="success">
            <cfinvokeargument name="departmentId" value="#updatedepartmentId#"/>,
            <cfinvokeargument name="departmentData" value="#form#"/>
        </cfinvoke>
        
        <cfif success EQ true>
            <script>
                showToast('Department updated successfully.', 'success');
            </script>
        <cfelse>
            <script>
                showToast('Failed to update department. Please try again.', 'warning');
            </script>
        </cfif>
    </cfif>
</cfif>
