<cftry>
    <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getUserList" returnvariable="doctorList">
        <cfinvokeargument name="role" value="Doctor"/>
    </cfinvoke>
    <style>
        #doctorList {
            width: 100%;
            table-layout: fixed;
        }
        #doctorList td {
            white-space: normal;
            word-break: break-word;
        }
    </style>
    
    <form method="POST" class="p-5">
        <table id="doctorList"  class="display">
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Department</th>
                    <th>Gender</th>
                    <th>Password</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#doctorList#>
                    <tr style="width: 10rem;">
                        <td>#doctorList.first_name#</td>
                        <td>#doctorList.last_name#</td>
                        <td> #doctorList.email#</td>
                        <td>#doctorList.phone#</td>
                        <td>#doctorList.department_name#</td>
                        <td>#doctorList.gender#</td>
                        <td>#doctorList.password#</td>
                        <td>
                            <button class="btn btn-primary" name="updateDoctorId" value=#doctorList.user_id# type="submit">Update</button>
                        </td>
                        <td data-order=#doctorList.gender#>
                            <button class="btn btn-danger" name="deleteDoctorId" value=#doctorList.user_id# type="submit">Delete</button>
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
        $('table#doctorList').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
        });
    })
</script>


<cfif structKeyExists(form, "updateDoctorId")>
    <cfdump var=#form#/>
    <cfdump var=#form.updateDoctorId#/>
    <cflocation url="home.cfm?reqPage=updateDoctor&doctorId=#form.updateDoctorId#"/>
</cfif>

<cfif structKeyExists(form, "deleteDoctorId")>
     <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteDoctor" returnvariable="success">
        <cfinvokeargument name="doctor_id" value=#form.deleteDoctorId#/>
    </cfinvoke> 

   <cfif success EQ true>
        <script>alert("doctor record deleted successfully.");</script>
    <cfelse>
        <script>alert("Failed to delete doctor record. Please try again.");</script>
    </cfif>

</cfif>