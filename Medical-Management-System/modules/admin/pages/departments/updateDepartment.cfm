<cfset departmentIdToUpdate = url.departmentId/>

<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getdepartmentDataById" returnvariable="departmentData">
    <cfinvokeargument name="departmentId" value="#departmentIdToUpdate#"/>
</cfinvoke>


<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <div class="h-100 w-100 border border-black d-flex justify-content-center align-items-center">
        <cfoutput>
            <form class="p-5" method="POST">
                <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                    <div>
                        <h2 class="text-primary">Update Department</h2>
                    </div>
                    
                    <div class="d-flex gap-4">
                        <div class="form-check d-flex flex-column gap-4 align-items-center">
                        <div>
                            <input name="departmentName" class="form-control" type="text" id="departmentName" required placeholder="Department Name *" value="#departmentData.department_name#"/>
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

    <script src="pages/patients/addPatient/addPatient.js"></script>
</html>

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
                alert('Department Updated successfully');
            </script>
            <cfelse>
            <script>
                alert('Failed to update department. Please try again.');
            </script>
        </cfif>
    </cfif>
</cfif>
