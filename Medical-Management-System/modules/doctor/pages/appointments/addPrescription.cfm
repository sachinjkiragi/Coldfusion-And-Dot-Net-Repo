<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <div class="h-100 w-100 border border-black d-flex">
        <form class="p-5" method="POST">
            <div class="border border-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary text-center">Add Prescription</h2>
                </div>

                <div class="d-flex gap-4">
                    <div class="form-check d-flex gap-4 p-0">
                        <div>
                            <input name="diagnosis" class="form-control" type="text" id="diagnosis" required placeholder="Diagnosis *"/>
                        </div>
                        <div>
                            <textarea rows="1" cols="80" name="diagnosis_notes" class="form-control" type="text" id="diagnosis_notes" placeholder="Diagnosis Notes"></textarea>
                        </div>
                    </div>
                </div>
                
                <span title="Please complete all required fields">
                    <button class="btn btn-primary" type="submit" name="add-btn">Create Prescription</button>
                </span>

            </div>
        </form>
    </div>

    <script src="pages/addPatient/addPatient.js"></script>
</html>

<cfif structKeyExists(form, "register-btn")>
    <cfinvoke method="doesMailExists" component="../../../../services/receptionistServices/receptionistQueries" returnvariable="flag">
        <cfinvokeargument name="email" value=#form.email#/>
    </cfinvoke>
    <cfif flag EQ true>
        <script>
            alert('Given Email Already Exists!')
        </script>
    <cfelse>
        <cfset form.password = randRange(100000, 999999)/>
        <cfinvoke component="../../../../services/receptionistServices/receptionistQueries" method="insertPatientData" returnvariable="success">
            <cfinvokeargument name="patientData" value=#form#/>
        </cfinvoke>
        
        <cfif success EQ true>
            <!--- <cfmail from="noreply@mms.com" to=#form.email# subject="temporary Passowrd for MMS Login">
                Your temporary Passowrd for MMS Login #form.password#
            </cfmail> --->
            <script>alert('Registeration Done Successfully');</script>
        <cfelse>
            <script>alert('Registration failed. Please try again.');</script>
        </cfif>

    </cfif>
</cfif>
