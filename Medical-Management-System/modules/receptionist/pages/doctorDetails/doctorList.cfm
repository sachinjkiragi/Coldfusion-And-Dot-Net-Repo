<cftry>
    <cfinvoke component="../../../../services/receptionistServices/receptionistQueries.cfc" method="getUserList" returnvariable="doctorList">
        <cfinvokeargument name="role" value="Doctor"/>
    </cfinvoke>
    <style>
        #doctorList td, #doctorList th {
            white-space: normal;
            word-break: break-word;
            vertical-align: middle;
            text-align: center;
            padding: 0.75rem 0.5rem;
        }

        #doctorList tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }

        #doctorList tbody tr:hover {
            background-color: #f2f2f2;
        }

        #doctorList thead {
            background-color: #0d6efd;
            color: white;
            font-weight: 600;
        }

        #doctorList .btn {
            min-width: 80px;
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        #doctorList {
            border-collapse: collapse;
            width: 100%;
        }

        #doctorList, #doctorList th, #doctorList td {
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