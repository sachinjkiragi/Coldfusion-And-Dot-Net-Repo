<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getDepartments" returnvariable="departmentList"/>

<cftry>
    <style>
        #departmentList {
            width: 100%;
            table-layout: fixed;
        }
        #departmentList td {
    white-space: normal;
    word-break: break-word;
}
    </style>
    
    <form method="POST" class="py-3 px-5 d-flex flex-column gap-4">
        <a href="home.cfm?reqPage=addDepartment" class="btn btn-primary" style="width: 10rem;">Add Department</a>
        <table id="departmentList"  class="display">
            <thead>
                <tr>
                    <th>Department Name</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#departmentList#>
                    <tr style="width: 10rem;">
                        <td>#departmentList.department_name#</td>
                        <td>
                            <button class="btn btn-primary" name="updateDepartmentId" value=#departmentList.department_id# type="submit">Update</button>
                        </td>
                        <td>
                            <button class="btn btn-danger" name="deleteDepartmentId" value=#departmentList.department_id# type="submit">Delete</button>
                        </td>
                    </tr>
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
        $('table#departmentList').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
        });
    })
</script>

<cfif structKeyExists(form, "updateDepartmentId")>
    <cflocation url="home.cfm?reqPage=updateDepartment&departmentId=#form.updateDepartmentId#"/>
</cfif>

<cfif structKeyExists(form, "deleteDepartmentId")>
     <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteDepartment" returnvariable="success">
        <cfinvokeargument name="departmentId" value=#form.deleteDepartmentId#/>
    </cfinvoke> 

   <cfif success EQ true>
        <script>alert("Department record deleted successfully.");</script>
    <cfelse>
        <script>alert("Failed to delete Department record. Please try again.");</script>
    </cfif>
</cfif>

<cfif structKeyExists(form, "deleteDepartmentId")>
     <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteDepartment" returnvariable="success">
        <cfinvokeargument name="departmentId" value=#form.deleteDepartmentId#/>
    </cfinvoke> 
</cfif>