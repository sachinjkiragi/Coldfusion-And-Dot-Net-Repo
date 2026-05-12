<cfinvoke component="../../../../services/doctorServices/doctorQueries.cfc" method="getMedicines" returnvariable="medicineList"/>
<cfset noOfMedicines = 0/>
<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <cfinclude template = "../../../../includes/toast.cfm"/>
    <div class="h-100 w-100  d-flex justify-content-center">
        <form class="p-2 needs-validation" method="POST" novalidate>
            <div class="d-flex flex-column gap-3 align-items-center justify-content-center">
                <div>
                    <h2 class="text-primary text-center">Add Prescription</h2>
                </div>

                <div class="d-flex gap-4">
                    <div class="form-check d-flex gap-4 p-0">
                        <div class="w-50">
                            <label class="form-label fw-semibold">Diagnosis:</label>
                            <input required name="diagnosis" class="form-control" type="text" id="diagnosis" required placeholder="Diagnosis*"/>
                            <div class="invalid-feedback">
                                Please enter a diagnosis.
                            </div>
                        </div>
                        <div class="w-50">
                            <label class="form-label fw-semibold">Diagnosis Notes:</label>
                            <textarea required rows="1" cols="40" name="diagnosis_notes" class="form-control" type="text" id="diagnosis_notes" placeholder="Diagnosis Notes"></textarea>
                            <div class="invalid-feedback">
                                Please enter diagnosis notes.
                            </div>
                        </div>
                    </div>
                </div>
                
                <div id="availableMedicines" class="d-flex justify-content-between w-100 gap-4 p-0">
                    <div class="w-50">
                        <label class="form-label fw-semibold">Medicine:</label>
                        <select required id="medicineList" class="form-control d-block form-select" name="medicine_id">
                            <option value="">Select Medicine</option>
                            <cfoutput query="#medicineList#">
                                <option value="#medicineList.medicine_id#">#medicine_name#</option>
                            </cfoutput>
                        </select>
                        <div class="invalid-feedback">
                            Please select a medicine or choose "No Medicine".
                        </div>
                    </div>
                    <div class="form-check p-0 w-50">
                        <label class="form-label fw-semibold">Quantity:</label>
                        <input required type="number" min="0" class="form-control" name="medicine_qty" placeholder="Quantity"/>
                        <div class="invalid-feedback">
                            Please enter a valid quantity (0 or more).
                        </div>
                    </div>
                </div>
                <div class="w-100">
                    <label class="form-label fw-semibold">Dosage Info.:</label>
                    <textarea required rows="1" cols="70" name="dosage_info" class="form-control" type="text" id="dosage_info" placeholder="Dosage Information"></textarea>
                    <div class="invalid-feedback">
                        Please enter dosage information.
                    </div>
                </div>
                
                <span title="Please complete all required fields">
                    <button class="btn btn-primary" type="submit" name="btn-create-prescription">Create Prescription</button>
                </span>
                
                <a href="home.cfm?reqPage=appointments" class="text-primary text-decoration-none">Go Back</a>

            </div>
        </form>
    </div>

</html>

<script>
    const formEle = document.querySelector('.needs-validation')
    formEle.addEventListener('submit', (e)=>{
        if(!formEle.checkValidity()){
            e.preventDefault();
        }
        formEle.classList.add('was-validated')
    })
</script>


<cfif structKeyExists(form, 'btn-create-prescription')>
    <cfset form.appointment_id = url.appointment_id/>
    <cfset form.digital_signature = '#session.currUser.email# #session.currUser.password#'/>
    <cfinvoke component="../../../../services/doctorServices/doctorQueries.cfc" method="doesPrescriptionExists" returnvariable="doesExists">
        <cfinvokeargument name="appointment_id" value="#form.appointment_id#"/>
    </cfinvoke>

    <cfif doesExists EQ true>
        <script>
            showToast('Prescription Already Exists for this Appointment', 'warning');
        </script>
        <cfabort/>
    </cfif>

    <cfinvoke component="../../../../services/doctorServices/doctorQueries.cfc" method="addPrescription" returnvariable="success">
        <cfinvokeargument name="prescription_data" value="#form#"/>
    </cfinvoke>
    <cfif success EQ true>
        <script>
            showToast('Prescription added successfully', 'success');
        </script>
    </cfif>
</cfif>