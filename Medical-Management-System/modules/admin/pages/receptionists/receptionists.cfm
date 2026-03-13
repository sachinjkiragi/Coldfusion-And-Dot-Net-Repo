<cftry>
    <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getUserList" returnvariable="receptionistList">
        <cfinvokeargument name="role" value="Receptionist"/>
    </cfinvoke>
    <style>
        #receptionistList td, #receptionistList th {
            white-space: normal;
            word-break: break-word;
            vertical-align: middle;
            text-align: center;
            padding: 0.75rem 0.5rem;
        }

        #receptionistList tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }

        #receptionistList tbody tr:hover {
            background-color: #f2f2f2;
        }

        #receptionistList thead {
            background-color: #0d6efd;
            color: white;
            font-weight: 600;
        }

        #receptionistList .btn {
            min-width: 80px;
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        #receptionistList {
            border-collapse: collapse;
            width: 100%;
        }

        #receptionistList, #receptionistList th, #receptionistList td {
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
        <a href="home.cfm?reqPage=addReceptionist" class="btn btn-primary" style="width: 10rem;">Add Receptionist</a>
        <table id="receptionistList"  class="display">
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Department</th>
                    <th>Gender</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#receptionistList#>
                    <tr style="width: 10rem;">
                        <td>#receptionistList.first_name#</td>
                        <td>#receptionistList.last_name#</td>
                        <td> #receptionistList.email#</td>
                        <td>#receptionistList.phone#</td>
                        <td>#receptionistList.department_name#</td>
                        <td>#receptionistList.gender#</td>
                        <td>
                            <button class="btn btn-primary" name="updateReceptionistId" value=#receptionistList.user_id# type="submit">Update</button>
                        </td>
                        <td data-order=#receptionistList.gender#>
                            <button class="btn btn-danger" name="deleteReceptionistId" value=#receptionistList.user_id# type="submit">Delete</button>
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
        $('table#receptionistList').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
        });
    })
</script>


<cfif structKeyExists(form, "updateReceptionistId")>
    <cfdump var=#form#/>
    <cfdump var=#form.updateReceptionistId#/>
    <cflocation url="home.cfm?reqPage=updateReceptionist&receptionistId=#form.updateReceptionistId#"/>
</cfif>

<cfif structKeyExists(form, "deleteReceptionistId")>
     <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteReceptionist" returnvariable="success">
        <cfinvokeargument name="receptionist_id" value=#form.deleteReceptionistId#/>
    </cfinvoke> 

   <cfif success EQ true>
        <script>alert("receptionist record deleted successfully.");</script>
    <cfelse>
        <script>alert("Failed to delete receptionist record. Please try again.");</script>
    </cfif>

</cfif>