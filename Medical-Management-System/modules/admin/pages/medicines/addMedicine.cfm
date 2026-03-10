<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <div class="h-100 w-100 border border-black d-flex justify-content-center align-items-center">
        <form class="p-5" method="POST">
            <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Add Medicine</h2>
                </div>

                <div class="d-flex gap-4">
                    <div class="form-check d-flex flex-column gap-4 align-items-center">
                        <div>
                            <input name="medicineName" class="form-control" type="text" id="medicineName" required placeholder="Medicine Name *"/>
                        </div>
                        <div>
                            <input name="unitPrice" class="form-control" type="text" id="unitPrice" placeholder="Unit Price *" required/>
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
            alert('Medicine Exists Already')
        </script>
    <cfelse>
        <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="addMedicine" returnvariable="success">
            <cfinvokeargument name="medicineData" value="#form#"/>
        </cfinvoke>
        
        <cfif success EQ true>
            <script>
            alert('Medicine added successfully');
            </script>
        <cfelse>
            <script>
                alert('Failed to add medicine. Please try again.');
            </script>
        </cfif>
    </cfif>
</cfif>
