<cftry>
    <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getUserList" returnvariable="doctorList">
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
    <cfinclude template="../../../../includes/header.cfm"/>
    <cfinclude template="../../../../includes/toast.cfm"/>
    <form method="POST" class="py-3 px-5 d-flex flex-column gap-4" id="form">
        <input type="hidden" name="idToDelete" id="idToDelete">
        <a href="home.cfm?reqPage=addDoctor" class="btn btn-primary" style="width: 8rem;">Add Doctor</a>
        <table id="doctorList"  class="display">
            <thead>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Department</th>
                    <th>Gender</th>
                    <th class="no-sort">Actions</th>
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
                            <button class="btn btn-primary" name="updateDoctorId" value=#doctorList.user_id# type="submit">Update</button>
                            <button type="button"
                                    class="btn btn-danger"
                                    onclick="openConfirm('#doctorList.user_id#')">
                                Delete
                            </button>
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

<cfinclude template="../../../../includes/confirm.cfm"/>

<script>
    $(document).ready(function(){
        $('table#doctorList').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
            columnDefs: [
                {orderable: false, targets: 'no-sort'}
            ]
        });
    })
</script>


<cfif structKeyExists(form, "updateDoctorId")>
    <cfdump var=#form#/>
    <cfdump var=#form.updateDoctorId#/>
    <cflocation url="home.cfm?reqPage=updateDoctor&doctorId=#form.updateDoctorId#"/>
</cfif>

<cfif structKeyExists(form, "idToDelete")>
     <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteDoctor" returnvariable="success">
        <cfinvokeargument name="doctor_id" value=#form.idToDelete#/>
    </cfinvoke> 

   <cfif success EQ true>
        <script>
            showToast('doctor record deleted successfully.', 'success');
        </script>
    <cfelse>
        <script>
            showToast('Failed to delete doctor record. Please try again.', 'danger');
        </script>
    </cfif>

</cfif>