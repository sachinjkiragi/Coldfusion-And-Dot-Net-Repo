<cfset medicineIdToUpdate = url.medicineId/>

<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getMedicineDataById" returnvariable="medicineData">
    <cfinvokeargument name="medicineId" value="#medicineIdToUpdate#"/>
</cfinvoke>


<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <div class="h-100 w-100 d-flex justify-content-center align-items-center">
        <cfoutput>
            <form class="p-5" method="POST">
                <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                    <div>
                        <h2 class="text-primary">Update Medicine</h2>
                    </div>
                    
                    <div class="d-flex gap-4">
                        <div class="form-check d-flex flex-column gap-4 align-items-center">
                        <div>
                            <label class="form-label fw-semibold">Medicine Name:</label>
                            <input name="medicineName" class="form-control" type="text" id="medicineName" required placeholder="Medicine Name*" value="#medicineData.medicine_name#"/>
                        </div>
                        <div>
                            <label class="form-label fw-semibold">Unit Price:</label>
                            <input name="unitPrice" class="form-control" type="text" id="unitPrice" placeholder="Unit Price*" required value="#medicineData.unit_price#"/>
                            <span id="unitPriceError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                        <span title="Please complete all required fields">
                            <button class="btn btn-primary" type="submit" name="updateMedicineId"> Update </button>
                        </span>
                        <a href="home.cfm?reqPage=medicines" class="text-decoration-none">Go Back</a>
                    </div>
                </div>
            </form>
        </cfoutput>
    </div>

    <script src="pages/patients/addPatient/addPatient.js"></script>
</html>

<cfif structKeyExists(form, "updateMedicineId")>
    <cfset medicineExists = false/>
    
    <cfif medicineData.medicine_name NEQ form.medicineName>
        <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="medicineExists" returnvariable="flag">
            <cfinvokeargument name="medicineName" value="#form.medicineName#"/>
        </cfinvoke>        
        <cfif flag EQ true>    
            <cfset medicineExists = true/>
        </cfif>
    </cfif>

    <cfif medicineExists EQ false>
        <cfset form.medicineId = medicineIdToUpdate/>
        <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="updateMedicine" returnvariable="success">
            <cfinvokeargument name="medicineId" value="#updateMedicineId#"/>,
            <cfinvokeargument name="medicineData" value="#form#"/>
        </cfinvoke>
        
        <cfif success EQ true>
            <script>
                alert('Medicine Updated successfully');
            </script>
            <cfelse>
            <script>
                alert('Failed to update medicine. Please try again.');
                </script>
        </cfif>
    </cfif>
</cfif>
