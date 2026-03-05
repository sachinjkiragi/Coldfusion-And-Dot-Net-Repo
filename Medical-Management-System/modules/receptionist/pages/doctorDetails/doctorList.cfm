<cftry>
    <cfinvoke component="../../../../services/receptionistServices/receptionistQueries.cfc" method="getUserList" returnvariable="doctorList">
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
                    <th>Check Availability</th>
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
                        <td>
                            <button class="btn btn-primary" name="checkDoctorId" value=#doctorList.user_id# type="submit">Check</button>
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


<cfif structKeyExists(form, "checkDoctorId")>
    <cfdump var=#form#/>
    <cflocation url="home.cfm?reqPage=doctorAvailability&doctorId=#form.checkDoctorId#"/>
</cfif>