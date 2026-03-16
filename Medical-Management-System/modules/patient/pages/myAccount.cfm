<cfinvoke component="../../../services/adminServices/adminQueries.cfc" method="getDepartments" returnvariable="departmentList"/>

<cfinvoke method="getPatientData" component="../../../services/adminServices/adminQueries.cfc" returnvariable="doctorData">
    <cfinvokeargument name="patient_id" value=#session.currUser.user_id#/>
</cfinvoke>


<html>
    <cfinclude template = "../../../includes/header.cfm"/>
    <cfoutput>
        <div class="h-100 w-100 d-flex" style="margin: 0 0 0 12rem">
            <form class="py-1" method="POST">
                <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                    <div>
                        <h2 class="text-primary">Hello!</h2>
                    </div>
                    <div class="d-flex gap-4">
                        <div class="form-check d-flex flex-column gap-2">
                            <div>
                                <label class="form-label fw-semibold">First Name:</label>
                                <input readonly name="firstName" class="form-control" value="#doctorData.first_name#" type="text" id="firstName" required placeholder="First Name*"/>
                                <span id="firstNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Last Name:</label>
                                <input readonly name="lastName" class="form-control" value=#doctorData.last_name# type="text" id="lastName" placeholder="Last Name"/>
                                <span id="lastNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                        </div>
                        <div class="form-check d-flex flex-column gap-2">
                            <div>
                                <label class="form-label fw-semibold">Email:</label>
                                <input readonly name="email" class="form-control" value=#doctorData.email# type="email" id="email" required placeholder="Email*"/>
                                <span id="emailError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Phone:</label>
                                <input readonly name="phone" class="form-control" value=#doctorData.phone# type="phone" id="phone" required placeholder="Phone*"/>
                                <span id="phoneError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex gap-3">
                        <label class="form-label fw-semibold">Gender:</label>
                        <div class="form-check">
                            <input  readonly class="form-check-input" type="radio" name="gender" value="m" id="male" required <cfif doctorData.gender EQ 'M'>checked</cfif> >
                            <label class="form-check-label" for="male">Male</label>
                        </div>

                        <div class="form-check">
                            <input readonly class="form-check-input" type="radio" name="gender" value="f" id="female" required <cfif doctorData.gender EQ 'F'>checked</cfif>>
                            <label class="form-check-label" for="female">Female</label>
                        </div>

                        <div class="form-check">
                            <input readonly class="form-check-input" type="radio" name="gender" value="o" id="other" required <cfif doctorData.gender EQ 'O'>checked</cfif>>
                            <label class="form-check-label" for="other">Other</label>
                        </div>
                    </div>

                </div>
            </form>
        </div>
    </cfoutput>
</html>

<cfif structKeyExists(form, "update-btn")>
    <cfset mailExists = false/>
    <cfif doctorData.email NEQ form.email>
        <cfinvoke method="doesMailExists" component="../../../../services/adminServices/adminQueries" returnvariable="flag">
            <cfinvokeargument name="email" value=#form.email#/>
        </cfinvoke>
        <cfif flag EQ true>
            <cfset mailExists = true/>
        </cfif>
    </cfif>
    
    <cfif mailExists EQ false>
        <cfset form.doctor_id = patientIdToUpdate/>
        <cfinvoke component="../../../../services/adminServices/adminQueries" method="updatedoctorData" returnvariable="success">
            <cfinvokeargument name="doctorData" value=#form#/>
        </cfinvoke>
        
        <cfif success EQ true>
            <cfmail to="#form.email#" from="noreply@med.com" subject="temporary Passoword for MedManage Login">Your temporary Passoword for MedManage LogIn is #form.password#
            </cfmail> 
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