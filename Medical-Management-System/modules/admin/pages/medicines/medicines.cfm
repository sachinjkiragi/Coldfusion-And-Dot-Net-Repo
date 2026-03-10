<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getMedicines" returnvariable="medicineList"/>

<cftry>
    <style>
        #medicineList {
            width: 100%;
            table-layout: fixed;
        }
        #medicineList td {
    white-space: normal;
    word-break: break-word;
}
    </style>
    
    <form method="POST" class="py-3 px-5 d-flex flex-column gap-4">
        <a href="home.cfm?reqPage=addMedicine" class="btn btn-primary" style="width: 8rem;">Add Medicine</a>
        <table id="medicineList"  class="display">
            <thead>
                <tr>
                    <th>Medicine Name</th>
                    <th>Unit Price</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#medicineList#>
                    <tr style="width: 10rem;">
                        <td>#medicineList.medicine_name#</td>
                        <td>#medicineList.unit_price#</td>
                        <td>
                            <button class="btn btn-primary" name="updateMedicineId" value=#medicineList.medicine_id# type="submit">Update</button>
                        </td>
                        <td>
                            <button class="btn btn-danger" name="deleteMedicineId" value=#medicineList.medicine_id# type="submit">Delete</button>
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
        $('table#medicineList').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
        });
    })
</script>

<cfif structKeyExists(form, "updateMedicineId")>
    <cflocation url="home.cfm?reqPage=updateMedicine&medicineId=#form.updateMedicineId#"/>
</cfif>

<cfif structKeyExists(form, "deleteMedicineId")>
     <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteMedicine" returnvariable="success">
        <cfinvokeargument name="medicineId" value=#form.deleteMedicineId#/>
    </cfinvoke> 

   <cfif success EQ true>
        <script>alert("Medicine record deleted successfully.");</script>
    <cfelse>
        <script>alert("Failed to delete Medicine record. Please try again.");</script>
    </cfif>
</cfif>

<cfif structKeyExists(form, "deleteMedicineId")>
     <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteMedicine" returnvariable="success">
        <cfinvokeargument name="medicineId" value=#form.deleteMedicineId#/>
    </cfinvoke> 
</cfif>