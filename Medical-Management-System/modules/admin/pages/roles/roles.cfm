<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getRoles" returnvariable="rolesList"/>

<cftry>
    <style>
        #rolesList {
            width: 100%;
            table-layout: fixed;
        }
        #rolesList td {
    white-space: normal;
    word-break: break-word;
}
    </style>
    
    <form method="POST" class="py-3 px-5 d-flex flex-column gap-4">
        <a href="home.cfm?reqPage=addRole" class="btn btn-primary" style="width: 10rem;">Add Role</a>
        <table id="rolesList"  class="display">
            <thead>
                <tr>
                    <th>Role Name</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#rolesList#>
                    <cfif rolesList.role_name NEQ 'Admin'>
                        <tr style="width: 10rem;">
                            <td>#rolesList.role_name#</td>
                            <td>
                                <button class="btn btn-primary" name="updateRoleId" value=#rolesList.role_id# type="submit">Update</button>
                            </td>
                            <td>
                                <button class="btn btn-danger" name="deleteRoleId" value=#rolesList.role_id# type="submit">Delete</button>
                            </td>
                        </tr>
                    </cfif>
                </cfoutput>
            </tbody>
        </table>
    </form>
        
    <cfcatch>
        <cfoutput>#cfcatch#</cfoutput>
    </cfcatch>
</cftry>

<script>
    $(document).ready(function(){
        $('table#rolesList').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
        });
    })
</script>

<cfif structKeyExists(form, "updateRoleId")>
    <cflocation url="home.cfm?reqPage=updateRole&roleId=#form.updateRoleId#"/>
</cfif>

<cfif structKeyExists(form, "deleteRoleId")>
     <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteRole" returnvariable="success">
        <cfinvokeargument name="roleId" value=#form.deleteRoleId#/>
    </cfinvoke> 

   <cfif success EQ true>
        <script>alert("Role record deleted successfully.");</script>
    <cfelse>
        <script>alert("Failed to delete Role record. Please try again.");</script>
    </cfif>
</cfif>

<cfif structKeyExists(form, "deleteRoleId")>
     <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteRole" returnvariable="success">
        <cfinvokeargument name="roleId" value=#form.deleteRoleId#/>
    </cfinvoke> 
</cfif>