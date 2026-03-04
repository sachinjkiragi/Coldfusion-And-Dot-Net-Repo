<cfset appointment_id = url.appointment_id/>
<cfinvoke component="../../../../services/doctorServices/doctorQueries.cfc" method="getPrescriptionData" returnvariable="prescriptionData">
    <cfinvokeargument name="appointment_id" value="#appointment_id#"/>
</cfinvoke>

<cfinvoke component="../../../../services/doctorServices/doctorQueries.cfc" method="getMedicines" returnvariable="medicineList"/>

<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <div class="h-100 w-100  d-flex justify-content-center">
        <cfoutput>
            <form class="p-5" method="POST">
                <div class="d-flex flex-column gap-3 align-items-center justify-content-center">
                    <div>
                        <h2 class="text-primary text-center">Prescription Details</h2>
                    </div>
                    
                    <div class="d-flex gap-4">
                        <div class="form-check d-flex gap-4 p-0">
                            <div>
                                <input disabled value="#prescriptionData.diagnosis#" name="diagnosis" class="form-control" type="text" id="diagnosis" required placeholder="Diagnosis *"/>
                            </div>
                            <div>
                                <textarea disabled readonly rows="1" cols="40" name="diagnosis_notes" class="form-control" type="text" id="diagnosis_notes" placeholder="Diagnosis Notes">#prescriptionData.diagnosis_notes#</textarea>
                            </div>
                        </div>
                    </div>
                    
                    <div id="availableMedicines" class="d-flex justify-content-between w-100 gap-4 p-0">
                        <div>
                            <select disabled id="medicineList" class="form-control d-block form-select" name="medicine_id" style="width: fit-content;">
                                <option value="">Select Medicine</option>
                                <cfoutput query="#medicineList#">
                                    <cfif medicineList.medicine_id EQ prescriptionData.medicine_id>
                                        <option selected value="#medicineList.medicine_id#">#medicine_name#</option>
                                    <cfelse>
                                        <option value="#medicineList.medicine_id#">#medicine_name#</option>
                                    </cfif>
                                </cfoutput>
                            </select>
                        </div>
                        <div class="form-check">
                            <input disabled type="number" min="0" class="form-control" name="medicine_qty" placeholder="Quantity" value="#prescriptionData.quantity#"/>
                        </div>
                    </div>
                    <div>
                        <textarea disabled rows="1" cols="70" name="dosage_info" class="form-control" type="text" id="dosage_info" placeholder="Dosage Information">#prescriptionData.dosage_info#</textarea>
                    </div>
                    
                    <span title="Please complete all required fields">
                        <button class="btn btn-primary" type="submit" name="btn-create-prescription">Update Prescription</button>
                    </span>
                    
                    <a href="home.cfm?reqPage=appointments" class="text-primary text-decoration-none">Go Back</a>
                    
                </div>
            </form>
        </cfoutput>
    </div>

</html>
