<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getMedicines" returnvariable="medicineList"/>

<cftry>
    <style>
        #medicineList td, #medicineList th {
            white-space: normal;
            word-break: break-word;
            vertical-align: middle;
            text-align: center;
            padding: 0.75rem 0.5rem;
        }

        #medicineList tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }

        #medicineList tbody tr:hover {
            background-color: #f2f2f2;
        }

        #medicineList thead {
            background-color: #0d6efd;
            color: white;
            font-weight: 600;
        }

        #medicineList .btn {
            min-width: 80px;
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        #medicineList {
            border-collapse: collapse;
            width: 100%;
        }

        #medicineList, #medicineList th, #medicineList td {
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
        <a href="home.cfm?reqPage=addMedicine" class="btn btn-primary" style="width: 8rem;">Add Medicine</a>
        <table id="medicineList"  class="display">
            <thead>
                <tr>
                    <th>Medicine Name</th>
                    <th>Unit Price</th>
                    <th class="no-sort">Actions</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#medicineList#>
                    <tr style="width: 10rem;">
                        <td>#medicineList.medicine_name#</td>
                        <td>#medicineList.unit_price#</td>
                        <td>
                            <button class="btn btn-primary" name="updateMedicineId" value=#medicineList.medicine_id# type="submit">Update</button>
                            <button type="button" class="btn btn-danger" onclick="openConfirm('#medicineList.medicine_id#')">Delete</button>
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
        $('table#medicineList').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
            columnDefs: [
                {orderable: false, targets: 'no-sort'}
            ]
        });
    })
</script>


<cfif structKeyExists(form, "updateMedicineId")>
    <cflocation url="home.cfm?reqPage=updateMedicine&medicineId=#form.updateMedicineId#"/>
</cfif>

<cfif structKeyExists(form, "idToDelete")>
     <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteMedicine" returnvariable="success">
        <cfinvokeargument name="medicineId" value=#form.idToDelete#/>
    </cfinvoke> 

   <cfif success EQ true>
        <script>
            showToast('Medicine record deleted successfully.', 'success')
        </script>
    <cfelse>
        <script>
            showToast('Failed to delete Medicine record. Please try again.', 'danger')
        </script>
    </cfif>
</cfif>

<cfif structKeyExists(form, "idToDelete")>
     <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteMedicine" returnvariable="success">
        <cfinvokeargument name="medicineId" value=#form.idToDelete#/>
    </cfinvoke> 
</cfif>