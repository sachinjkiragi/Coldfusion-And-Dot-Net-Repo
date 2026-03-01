<cftry>
    <cfinvoke component="../../../../services/receptionistServices/receptionistQueries.cfc" method="getPatientList" returnvariable="patientList">
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
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.8/css/jquery.dataTables.min.css"/>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.8/js/jquery.dataTables.min.js"></script>
    
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
                        <td data-order=#first_name#>
                            <input readonly style="all: unset;" name="firstName" value=#patientList.first_name#>
                        </td>
                        <td>#patientList.last_name#</td>
                        <td> #patientList.email#</td>
                        <td>#patientList.phone#</td>
                        <td>#patientList.gender#</td>
                        <td>
                            <button class="btn btn-primary" name="update-userid" value=#patientList.user_id# type="submit">Update</button>
                        </td>
                        <td data-order=#patientList.gender#>
                            <button class="btn btn-danger" name="delete-userid" value=#patientList.user_id# type="submit">Delete</button>
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

<cfif structKeyExists(form, "update-userid")>
</cfif>

<cfif structKeyExists(form, "delete-userid")>
</cfif>