<cftry>
    <cfinvoke component="../../../../services/receptionistServices/receptionistQueries.cfc" method="getUserList" returnvariable="patientList">
        <cfinvokeargument name="role" value="Patient"/>
    </cfinvoke>
    <!--- <cfdump var=#patientList#/> --->
    <style>
        #patientList {
            width: 100%;
            table-layout: fixed;
        }
        #patientList td {
    white-space: normal;
    word-break: break-word;
}
    </style>
    
    <form method="POST" class="p-5">
        <table id="patientList"  class="display">
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Gender</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#patientList#>
                    <tr style="width: 10rem;">
                        <td>#patientList.first_name#</td>
                        <td>#patientList.last_name#</td>
                        <td> #patientList.email#</td>
                        <td>#patientList.phone#</td>
                        <td>#patientList.gender#</td>
                        <td>
                            <button class="btn btn-primary" name="updatePatientId" value=#patientList.user_id# type="submit">Update</button>
                        </td>
                        <td data-order=#patientList.gender#>
                            <button class="btn btn-danger" name="deletePatientId" value=#patientList.user_id# type="submit">Delete</button>
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
        $('table#patientList').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
        });
    })
</script>

<cfif structKeyExists(form, "updatePatientId")>
    <cfdump var=#form#/>
    <cfdump var=#form.updatePatientId#/>
    <cflocation url="home.cfm?reqPage=updatePatient&patientId=#form.updatePatientId#"/>
</cfif>

<cfif structKeyExists(form, "deletePatientId")>
     <cfinvoke component="../../../../services/receptionistServices/receptionistQueries.cfc" method="deletePatient" returnvariable="success">
        <cfinvokeargument name="patient_id" value=#form.deletePatientId#/>
    </cfinvoke> 

   <cfif success EQ true>
        <script>alert("Patient record deleted successfully.");</script>
    <cfelse>
        <script>alert("Failed to delete patient record. Please try again.");</script>
    </cfif>

</cfif>