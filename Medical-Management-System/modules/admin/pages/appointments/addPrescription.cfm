<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getMedicines" returnvariable="medicineList"/>

<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <div class="h-100 w-100  d-flex justify-content-center">
        <form class="p-5" method="POST">
            <div class="d-flex flex-column gap-3 align-items-center justify-content-center">
                <div>
                    <h2 class="text-primary text-center">Add Prescription</h2>
                </div>

                <div class="d-flex gap-4">
                    <div class="form-check d-flex gap-4 p-0">
                        <div>
                            <label class="form-label fw-semibold">Diagnosis:</label>
                            <input required name="diagnosis" class="form-control" type="text" id="diagnosis" required placeholder="Diagnosis*"/>
                        </div>
                        <div>
                            <label class="form-label fw-semibold">Diagnosis Notes:</label>
                            <textarea required rows="1" cols="40" name="diagnosis_notes" class="form-control" type="text" id="diagnosis_notes" placeholder="Diagnosis Notes"></textarea>
                        </div>
                    </div>
                </div>
                
                <div id="availableMedicines" class="d-flex justify-content-between w-100 gap-4 p-0">
                    <div>
                        <label class="form-label fw-semibold">Medicine:</label>
                        <select required id="medicineList" class="form-control d-block form-select" name="medicine_id" style="width: fit-content;">
                            <option value="">Select Medicine</option>
                            <cfoutput query="#medicineList#">
                                <option value="#medicineList.medicine_id#">#medicine_name#</option>
                            </cfoutput>
                        </select>
                    </div>
                    <div class="form-check">
                        <label class="form-label fw-semibold">Quantity:</label>
                        <input required type="number" min="0" class="form-control" name="medicine_qty" placeholder="Quantity"/>
                    </div>
                </div>
                <div>
                    <label class="form-label fw-semibold">Dosage Info.:</label>
                    <textarea required rows="1" cols="70" name="dosage_info" class="form-control" type="text" id="dosage_info" placeholder="Dosage Information"></textarea>
                </div>
                
                <span title="Please complete all required fields">
                    <button class="btn btn-primary" type="submit" name="btn-create-prescription">Create Prescription</button>
                </span>
                
                <a href="home.cfm?reqPage=appointments" class="text-primary text-decoration-none">Go Back</a>

            </div>
        </form>
    </div>

    <script src="pages/addPatient/addPatient.js"></script>
</html>


<cfif structKeyExists(form, 'btn-create-prescription')>
    <cfset form.appointment_id = url.appointment_id/>
    <cfset form.digital_signature = '#session.currUser.email# #session.currUser.password#'/>
    <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="doesPrescriptionExists" returnvariable="doesExists">
        <cfinvokeargument name="appointment_id" value="#form.appointment_id#"/>
    </cfinvoke>

    <cfif doesExists EQ true>
        <script>
            alert('Prescription Already Exists for this Appointment');
        </script>
        <cfabort/>
    </cfif>

    <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="addPrescription" returnvariable="success">
        <cfinvokeargument name="prescription_data" value="#form#"/>
    </cfinvoke>
    <cfif success EQ true>
        <script>alert('Prescription added successfully')</script>
    </cfif>
</cfif>