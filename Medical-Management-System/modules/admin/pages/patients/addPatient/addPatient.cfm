<cfinvoke method="getRoles" component="../../../../../services/UserServices/userQueries.cfc" returnvariable="roles"/>
<html>
    <cfinclude template = "../../../../../includes/header.cfm"/>
    <div class="h-100 w-100 d-flex justify-content-center align-items-center">
        <form class="p-5" method="POST">
            <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Register Patient</h2>
                </div>
                <div class="p-2 d-flex gap-4 justify-content-center align-items-center">
                    <cfoutput query=#roles#>
                        <cfif roles.role_name EQ "Patient">
                            <input type="hidden" readonly class="form-check" type="text" name="role_id" value=#roles.role_id# id=#roles.role_id# required>
                        </cfif>
                    </cfoutput>
                </div>

                <div class="d-flex gap-4">
                    <div class="form-check d-flex flex-column gap-2">
                        <div>
                            <input name="firstName" class="form-control" type="text" id="firstName" required placeholder="First Name *"/>
                            <span id="firstNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                        <div>
                            <input name="lastName" class="form-control" type="text" id="lastName" placeholder="Last Name"/>
                            <span id="lastNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                    </div>
                    <div class="form-check d-flex flex-column gap-2">
                        <div>
                            <input name="email" class="form-control" type="email" id="email" required placeholder="Email *"/>
                            <span id="emailError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                        <div>
                            <input name="phone" class="form-control" type="phone" id="phone" required placeholder="Phone *"/>
                            <span id="phoneError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                    </div>
                </div>
                <div class="d-flex gap-3">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="m" id="male" required>
                        <label class="form-check-label" for="male">Male</label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="f" id="female" required>
                        <label class="form-check-label" for="female">Female</label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="gender" value="o" id="other" required checked>
                        <label class="form-check-label" for="other">Other</label>
                    </div>
                </div>
                
                <span title="Please complete all required fields">
                    <button class="btn btn-primary" type="submit" name="register-btn"> Register </button>
                </span>
            </div>
        </form>
    </div>

    <script src="pages/patients/addPatient/addPatient.js"></script>
</html>

<cfif structKeyExists(form, "register-btn")>
    <cfinvoke method="doesMailExists" component="../../../../../services/adminServices/adminQueries" returnvariable="flag">
        <cfinvokeargument name="email" value=#form.email#/>
    </cfinvoke>
    <cfif flag EQ true>
        <script>
            alert('Given Email Already Exists!')
        </script>
    <cfelse>
        <cfset form.password = randRange(100000, 999999)/>
        <cfinvoke component="../../../../../services/adminServices/adminQueries" method="insertPatientData" returnvariable="success">
            <cfinvokeargument name="patientData" value=#form#/>
        </cfinvoke>
        
        <cfif success EQ true>
            <cfmail to="#form.email#" from="noreply@med.com" subject="temporary Passoword for MedManage Login">Your temporary Passoword for MedManage LogIn is #form.password#
            </cfmail> 
            <script>alert('Registeration Done Successfully');</script>
        <cfelse>
            <script>alert('Registration failed. Please try again.');</script>
        </cfif>

    </cfif>
</cfif>
