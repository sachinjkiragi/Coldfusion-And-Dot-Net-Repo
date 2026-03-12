<cfinvoke component="../../../../../services/adminServices/adminQueries.cfc" method="getDepartments" returnvariable="departmentList"/>

<cfinvoke method="getRoles" component="../../../../../services/UserServices/userQueries.cfc" returnvariable="roles"/>

<html>
    <cfinclude template = "../../../../../includes/header.cfm"/>
    <cfoutput>
        <div class="h-100 w-100 border border-black d-flex justify-content-center align-items-center">
            <form class="py-1" method="POST">
                <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                    <div>
                        <h2 class="text-primary">Add Doctor</h2>
                    </div>
                    <div class="d-flex gap-4">
                    <div class="p-2 d-flex gap-4 justify-content-center align-items-center">
                        <cfoutput query=#roles#>
                            <cfif roles.role_name EQ "Doctor">
                                <input type="hidden" readonly class="form-check" type="text" name="role_id" value=#roles.role_id# id=#roles.role_id# required>
                            </cfif>
                        </cfoutput>
                    </div>
                        <div class="form-check d-flex flex-column gap-2">
                            <div>
                                <label class="form-label fw-semibold">First Name:</label>
                                <input name="firstName" class="form-control" type="text" id="firstName" required placeholder="First Name *"/>
                                <span id="firstNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Last Name:</label>
                                <input name="lastName" class="form-control" type="text" id="lastName" placeholder="Last Name"/>
                                <span id="lastNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Department:</label>
                                <div>
                                    <select id="departmentList" class="form-control d-block form-select" name="department_id" style="width: fit-content;">
                                        <option value="">Select Department</option>
                                        <cfoutput query="#departmentList#">
                                            <option value="#departmentList.department_id#">#department_name#</option>
                                        </cfoutput>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-check d-flex flex-column gap-2">
                            <div>
                                <label class="form-label fw-semibold">Email:</label>
                                <input name="email" class="form-control" type="email" id="email" required placeholder="Email *"/>
                                <span id="emailError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Phone:</label>
                                <input name="phone" class="form-control" type="phone" id="phone" required placeholder="Phone *"/>
                                <span id="phoneError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            
                        </div>
                    </div>
                    <div class="d-flex gap-3">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="m" id="male" required/>
                            <label class="form-check-label" for="male">Male</label>
                        </div>

                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="f" id="female" required/>
                            <label class="form-check-label" for="female">Female</label>
                        </div>

                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="o" id="other" required />
                            <label class="form-check-label" for="other">Other</label>
                        </div>
                    </div>
                    
                    <span title="Please complete all required fields">
                        <button class="btn btn-primary" type="submit" name="register-btn"> Register </button>
                    </span>
                    <a href="home.cfm?reqPage=doctors" class="text-decoration-none">Go Back</a>
                </div>
            </form>
        </div>
    </cfoutput>
    <script src="pages/doctors/addDoctor/addDoctor.js"></script>
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
        <cfinvoke component="../../../../../services/adminServices/adminQueries" method="insertDoctorData" returnvariable="success">
            <cfinvokeargument name="doctorData" value=#form#/>
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
