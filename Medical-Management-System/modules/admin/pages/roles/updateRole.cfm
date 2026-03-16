<cfset roleIdToUpdate = url.roleId/>

<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getroleDataById" returnvariable="roleData">
    <cfinvokeargument name="roleId" value="#roleIdToUpdate#"/>
</cfinvoke>


<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <div class="h-100 w-100 d-flex justify-content-center align-items-center">
        <cfoutput>
            <form class="p-5" method="POST">
                <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                    <div>
                        <h2 class="text-primary">Update Role</h2>
                    </div>
                    
                    <div class="d-flex gap-4">
                        <div class="form-check d-flex flex-column gap-4 align-items-center">
                        <div>
                            <label class="form-label fw-semibold">Role Name:</label>
                            <input name="roleName" class="form-control" type="text" id="roleName" required placeholder="Role Name*" value="#roleData.role_name#"/>
                        </div>
                        <span title="Please complete all required fields">
                            <button class="btn btn-primary" type="submit" name="updateroleId"> Update </button>
                        </span>
                        <a href="home.cfm?reqPage=Roles" class="text-decoration-none">Go Back</a>
                    </div>
                </div>
            </form>
        </cfoutput>
    </div>

    <script src="pages/patients/addPatient/addPatient.js"></script>
</html>

<cfif structKeyExists(form, "updateroleId")>
    <cfset roleExists = false/>
    
    <cfif roleData.role_name NEQ form.roleName>
        <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="roleExists" returnvariable="flag">
            <cfinvokeargument name="roleName" value="#form.roleName#"/>
        </cfinvoke>        
        <cfif flag EQ true>    
            <cfset roleExists = true/>
        </cfif>
    </cfif>

    <cfif roleExists EQ false>
        <cfset form.roleId = roleIdToUpdate/>
        <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="updateRole" returnvariable="success">
            <cfinvokeargument name="roleId" value="#updateroleId#"/>,
            <cfinvokeargument name="roleData" value="#form#"/>
        </cfinvoke>
        
        <cfif success EQ true>
            <script>
                alert('Role Updated successfully');
            </script>
            <cfelse>
            <script>
                alert('Failed to update role. Please try again.');
            </script>
        </cfif>
    </cfif>
</cfif>
