<cftry>
    <cfinvoke component="../../../../services/receptionistServices/receptionistQueries.cfc" method="getUserList" returnvariable="patientList">
        <cfinvokeargument name="role" value="Patient"/>
    </cfinvoke>
    <!--- <cfdump var=#patientList#/> --->
    <style>
        #patientList td, #patientList th {
            white-space: normal;
            word-break: break-word;
            vertical-align: middle;
            text-align: center;
            padding: 0.75rem 0.5rem;
        }

        #patientList tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }

        #patientList tbody tr:hover {
            background-color: #f2f2f2;
        }

        #patientList thead {
            background-color: #0d6efd;
            color: white;
            font-weight: 600;
        }

        #patientList .btn {
            min-width: 80px;
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        #patientList {
            border-collapse: collapse;
            width: 100%;
        }

        #patientList, #patientList th, #patientList td {
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
    
    <form method="POST">
        <table id="patientList"  class="display">
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Gender</th>
                    <th>Actions</th>
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
                            <button onclick="return confirm('Are you sure you want to delete this patient record?');" class="btn btn-danger" name="deletePatientId" value=#patientList.user_id# type="submit">Delete</button>
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