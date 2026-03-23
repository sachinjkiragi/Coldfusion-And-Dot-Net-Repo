<cfset appointment_id = url.appointment_id/>
<cfinvoke component="../../../../services/patientServices/patientQueries.cfc" method="getPrescriptionData" returnvariable="prescriptionData">
    <cfinvokeargument name="appointment_id" value="#appointment_id#"/>
</cfinvoke>

<cfinvoke component="../../../../services/patientServices/patientQueries.cfc" method="getMedicines" returnvariable="medicineList"/>

<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <div class="h-100 w-100  d-flex justify-content-center">
        <cfoutput>
            <form class="p-3" method="POST">
                <div class="d-flex flex-column gap-3 align-items-center justify-content-center">
                    <div>
                        <h2 class="text-primary text-center">Prescription Details</h2>
                    </div>
                    <div class="form-check p-0 d-flex gap-4 w-100">
                        <div class="w-100">
                            <label class="form-label fw-semibold">Doctor:</label>
                            <input readonly name="doctor_name" value="#prescriptionData.doctor_name#" class="form-control w-100" type="text" id="diagnosis" required placeholder="Diagnosis*"/>
                        </div>
                    </div>
                    <div class="d-flex gap-4">
                        <div class="form-check p-0 d-flex gap-4">
                            <div class="w-50">
                                <label class="form-label fw-semibold">Diagnosis:</label>
                                <input readonly name="diagnosis" value="#prescriptionData.diagnosis#" class="form-control" type="text" id="diagnosis" required placeholder="Diagnosis*"/>
                            </div>
                            <div class="w-50">
                                <label class="form-label fw-semibold">Diagnosis Notes:</label>
                                <textarea name="diagnosis_notes" readonly rows="1" cols="40" class="form-control" type="text" id="diagnosis_notes" placeholder="Diagnosis Notes">#prescriptionData.diagnosis_notes#</textarea>
                            </div>
                        </div>
                    </div>
                    
                    <div id="availableMedicines" class="d-flex justify-content-between w-100 gap-4 p-0">
                        <div class="w-50">
                            <cfoutput query="#medicineList#">
                                <cfif medicineList.medicine_id EQ prescriptionData.medicine_id>
                                    <label class="form-label fw-semibold">Medicine:</label>
                                    <input name="medicine_name" class="form-control" readonly value="#medicineList.medicine_name#"/>
                                    <input type="hidden" value="#medicineList.medicine_id#"/>
                                </cfif>
                            </cfoutput>
                        </div>
                        <div class="form-check p-0 w-50">
                            <label class="form-label fw-semibold">Quantity:</label>
                            <input name="medicine_quantity" readonly type="number" min="0" class="form-control"  placeholder="Quantity" value="#prescriptionData.quantity#"/>
                        </div>
                    </div>
                    <div class="w-100">
                        <label class="form-label fw-semibold">Dosage Info:</label>
                        <textarea readonly rows="1" cols="70" class="form-control" type="text" id="dosage_info" name="dosage_info" placeholder="Dosage Information">#prescriptionData.dosage_info#</textarea>
                    </div>
                    
                    <span title="Please complete all required fields">
                        <button class="btn btn-primary" type="submit" name="btn_download_prescription" value="#prescriptionData.prescription_id#">Download Prescription</button>
                    </span>
                    
                    <a href="home.cfm?reqPage=appointments" class="text-primary text-decoration-none">Go Back</a>
                </div>
            </form>
        </cfoutput>
    </div>
</html>

<cfif structKeyExists(form, "btn_download_prescription")>
<cfset fileContent = "
Prescription Details
Doctor: #form.doctor_name#
Diagnosis: #form.diagnosis#
Diagnosis Notes: #form.diagnosis_notes#
Medicine: #form.medicine_name#
Quantity: #form.medicine_quantity#
Dosage Info: #form.dosage_info#">

    <cfheader name="Content-Disposition" value="attachment; filename=prescription.txt">
    <cfcontent type="text/plain" reset="true">
    <cfoutput>#fileContent#</cfoutput>
    <cfabort/>
</cfif>