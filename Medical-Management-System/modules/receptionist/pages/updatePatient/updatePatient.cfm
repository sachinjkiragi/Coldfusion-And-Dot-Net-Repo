<cfinvoke method="getPatientData" component="../../../../services/receptionistServices/receptionistQueries.cfc" returnvariable="patientData">
    <cfinvokeargument name="patient_id" value=#patientIdToUpdate#/>
</cfinvoke>

<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <cfoutput>
        <div class="h-100 w-100 border border-black d-flex justify-content-center align-items-center">
            <form class="p-5" method="POST">
                <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                    <div>
                        <h2 class="text-primary">Update Patient</h2>
                    </div>
                    <div class="d-flex gap-4">
                        <div class="form-check d-flex flex-column gap-2">
                            <div>
                                <input name="firstName" class="form-control" value=#patientData.first_name# type="text" id="firstName" required placeholder="First Name *"/>
                                <span id="firstNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <input required name="lastName" class="form-control" value=#patientData.last_name# type="text" id="lastName" placeholder="Last Name"/>
                                <span id="lastNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                        </div>
                        <div class="form-check d-flex flex-column gap-2">
                            <div>
                                <input name="email" class="form-control" value=#patientData.email# type="email" id="email" required placeholder="Email *"/>
                                <span id="emailError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <input name="phone" class="form-control" value=#patientData.phone# type="phone" id="phone" required placeholder="Phone *"/>
                                <span id="phoneError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex gap-3">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="m" id="male" required <cfif patientData.gender EQ 'M'>checked</cfif> >
                            <label class="form-check-label" for="male">Male</label>
                        </div>

                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="f" id="female" required <cfif patientData.gender EQ 'F'>checked</cfif>>
                            <label class="form-check-label" for="female">Female</label>
                        </div>

                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="o" id="other" required <cfif patientData.gender EQ 'O'>checked</cfif>>
                            <label class="form-check-label" for="other">Other</label>
                        </div>
                    </div>
                    
                    <span title="Please complete all required fields">
                        <button class="btn btn-primary" type="submit" name="update-btn"> Update </button>
                    </span>
                    <a href="home.cfm?reqPage=patients" class="text-decoration-none">Go Back</a>
                </div>
            </form>
        </div>
    </cfoutput>


    <script src="pages/addPatient/addPatient.js"></script>
</html>

<cfif structKeyExists(form, "update-btn")>
    <cfset mailFlag = false/>
    <cfif patientData.email NEQ form.email>
        <cfinvoke method="doesMailExists" component="../../../../services/receptionistServices/receptionistQueries" returnvariable="flag">
            <cfinvokeargument name="email" value=#form.email#/>
        </cfinvoke>
        <cfif flag EQ true>
            <cfset mailFlag = true/>
        </cfif>
    </cfif>
    
    <cfif mailFlag EQ false>
        <cfset form.patient_id = patientIdToUpdate/>
        <cfinvoke component="../../../../services/receptionistServices/receptionistQueries" method="updatePatientData" returnvariable="success">
            <cfinvokeargument name="patientData" value=#form#/>
        </cfinvoke>
        
        <cfif success EQ true>
            <!--- <cfmail from="noreply@mms.com" to=#form.email# subject="temporary Passoword for MMS Login">
                Your temporary Passoword for MMS Login #form.password#
            </cfmail> --->
            <script>alert('Update Done Successfully');</script>
        <cfelse>
            <script>alert('Update failed. Please try again.');</script>
        </cfif>
    <cfelse>
        <script>
            alert('Given Email Already Exists!')
        </script>
    </cfif>
</cfif>