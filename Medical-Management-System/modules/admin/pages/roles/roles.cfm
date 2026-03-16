<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getRoles" returnvariable="rolesList"/>

<cftry>
    <style>
        #rolesList td, #rolesList th {
            white-space: normal;
            word-break: break-word;
            vertical-align: middle;
            text-align: center;
            padding: 0.75rem 0.5rem;
        }

        #rolesList tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }

        #rolesList tbody tr:hover {
            background-color: #f2f2f2;
        }

        #rolesList thead {
            background-color: #0d6efd;
            color: white;
            font-weight: 600;
        }

        #rolesList .btn {
            min-width: 80px;
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        #rolesList {
            border-collapse: collapse;
            width: 100%;
        }

        #rolesList, #rolesList th, #rolesList td {
            border: 1px solid #dee2e6;
        }

        div.dataTables_wrapper div.dataTables_length,
        div.dataTables_wrapper div.dataTables_filter {
            margin-bottom: 1rem;
            margin-top: 0.5rem;
        }

        div.dataTables_wrapper div.dataTables_paginate {
            margin-top: 1rem;
        }

        div.dataTables_wrapper div.dataTables_filter {
            float: right;
        }

        div.dataTables_wrapper div.dataTables_length {
            float: left;
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
                                <button onclick="return confirm('Are you sure you want to delete this patient record?');" class="btn btn-danger" name="deleteRoleId" value=#rolesList.role_id# type="submit">Delete</button>
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