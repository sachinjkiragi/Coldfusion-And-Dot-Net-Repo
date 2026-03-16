<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <cfinclude template = "../../../../includes/toast.cfm"/>
    <div class="h-100 w-100 d-flex justify-content-center align-items-center">
        <form class="p-5" method="POST">
            <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Add Medicine</h2>
                </div>

                <div class="d-flex gap-4">
                    <div class="form-check d-flex flex-column gap-4 align-items-center">
                        <div>
                            <label class="form-label fw-semibold">Medicine Name:</label>
                            <input name="medicineName" class="form-control" type="text" id="medicineName" required placeholder="Medicine Name*"/>
                        </div>
                        <div>
                            <label class="form-label fw-semibold">Unit Price:</label>
                            <input name="unitPrice" class="form-control" type="text" id="unitPrice" placeholder="Unit Price*" required/>
                            <span id="unitPriceError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                        <span title="Please complete all required fields">
                            <button class="btn btn-primary" type="submit" name="addBtn"> Add </button>
                        </span>
                        <a href="home.cfm?reqPage=medicines" class="text-decoration-none">Go Back</a>
                    </div>
            </div>
        </form>
    </div>

    <script src="pages/patients/addPatient/addPatient.js"></script>
</html>

<cfif structKeyExists(form, "addbtn")>

    <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="medicineExists" returnvariable="flag">
        <cfinvokeargument name="medicineName" value="#form.medicineName#"/>
    </cfinvoke>

    <cfif flag EQ true>
        <script>
            showToast('Medicine Exists Already', 'warning')
        </script>
    <cfelse>
        <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="addMedicine" returnvariable="success">
            <cfinvokeargument name="medicineData" value="#form#"/>
        </cfinvoke>
        
        <cfif success EQ true>
            <script>
                showToast('Medicine added successfully', 'success')
            </script>
        <cfelse>
            <script>
                showToast('Failed to add medicine. Please try again.', 'danger')
            </script>
        </cfif>
    </cfif>
</cfif>
