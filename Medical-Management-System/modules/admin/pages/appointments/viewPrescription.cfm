<cfset appointment_id = url.appointment_id/>
<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getPrescriptionData" returnvariable="prescriptionData">
    <cfinvokeargument name="appointment_id" value="#appointment_id#"/>
</cfinvoke>

<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getMedicines" returnvariable="medicineList"/>

<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <cfinclude template = "../../../../includes/toast.cfm"/>
    <div class="h-100 w-100  d-flex justify-content-center">
        <cfoutput>
            <form class="p-5" method="POST" id="form">
                <input type="hidden" name="idToDelete" id="idToDelete">
                <div class="d-flex flex-column gap-3 align-items-center justify-content-center">
                    <div>
                        <h2 class="text-primary text-center">Prescription Details</h2>
                    </div>
                    
                    <div class="d-flex gap-4 p-0">
                        <div class="form-check d-flex gap-4 p-0">
                            <div class="w-50">
                                <label class="form-label fw-semibold">Diagnosis:</label>
                                <input readonly value="#prescriptionData.diagnosis#" class="form-control" type="text" id="diagnosis" required placeholder="Diagnosis*"/>
                            </div>
                            <div class="w-50">
                                <label class="form-label fw-semibold">Diagnosis Notes:</label>
                                <textarea readonly rows="1" cols="40" class="form-control" type="text" id="diagnosis_notes" placeholder="Diagnosis Notes">#prescriptionData.diagnosis_notes#</textarea>
                            </div>
                        </div>
                    </div>
                    
                    <div id="availableMedicines" class="d-flex justify-content-between w-100 gap-4 p-0">
                        <div class="w-50">
                            <cfoutput query="#medicineList#">
                                <cfif medicineList.medicine_id EQ prescriptionData.medicine_id>
                                    <label class="form-label fw-semibold">Medicine:</label>
                                    <input class="form-control" readonly value="#medicineList.medicine_name#"/>
                                    <input type="hidden" value="#medicineList.medicine_id#"/>
                                </cfif>
                            </cfoutput>
                        </div>
                        <div class="form-check p-0 w-50">
                            <label class="form-label fw-semibold">Quantity:</label>
                            <input readonly type="number" min="0" class="form-control"  placeholder="Quantity" value="#prescriptionData.quantity#"/>
                        </div>
                    </div>
                    <div>
                        <label class="form-label fw-semibold">Dosage Info:</label>
                        <textarea readonly rows="1" cols="71" class="form-control" type="text" id="dosage_info" placeholder="Dosage Information">#prescriptionData.dosage_info#</textarea>
                    </div>
                    
                    <span title="Please complete all required fields">
                        <button class="btn btn-primary" type="submit" name="update_prescription_id" value="#prescriptionData.prescription_id#">Update</button>
                       <button type="button" class="btn btn-danger" onclick="openConfirm('#prescriptionData.prescription_id#')">Delete</button>
                    </span>
                    
                    <a href="home.cfm?reqPage=appointments" class="text-primary text-decoration-none">Go Back</a>
                    
                </div>
            </form>
        </cfoutput>
    </div>
</html>

<cfinclude template="../../../../includes/confirm.cfm"/>

<cfif structKeyExists(form, "update_prescription_id")>
    <cflocation url="home.cfm?reqPage=updatePrescription&prescription_id=#form.update_prescription_id#"/>
</cfif>

<cfif structKeyExists(form, "idToDelete")>
    <cfdump var=#form#/>
    
    <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deletePrescription" returnvariable="success">
        <cfinvokeargument name="prescription_id" value="#form.idToDelete#"/>
        <cfinvokeargument name="appointment_id" value="#appointment_id#"/>
    </cfinvoke>

    <cfif success EQ true>
        <script>
            showToast('Prescription record deleted successfully', 'success')
        </script>
    <cfelse>
        <script>
            showToast('Deleting prescription failed. Try again.', 'danger')
        </script>
    </cfif>

</cfif>
