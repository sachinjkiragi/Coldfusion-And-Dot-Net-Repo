<cfinvoke method="getDepartments" component="../services/UserServices/userQueries" returnvariable="departments"/>
<cfinvoke method="getRoles" component="../services/UserServices/userQueries" returnvariable="roles"/>

<html>
    <cfinclude template = "../includes/header.cfm"/>
    <nav class="d-flex align-items-center px-4 py-3 text-white shadow-sm position-fixed w-100 z-1"
        style="background: linear-gradient(90deg, #0d6efd, #0dcaf0);">
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-heart-pulse fs-1"></i>
            <h2 class="m-0 fw-bold">
                MedManage
            </h2>
        </div>
    </nav>
    <div class="h-100 w-100 d-flex justify-content-center align-items-center ">
        <form style="width: fit-content; margin-top: 6rem;" class="card shadow-lg px-5 py-4" method="POST">
            <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Register Yourself As</h2>
                </div>
                <div class="p-2 d-flex gap-4 justify-content-center align-items-center">
                    <cfoutput query=#roles#>
                        <cfif roles.role_name EQ "Doctor" OR roles.role_name EQ "Receptionist">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="role_id" value=#roles.role_id# id=#roles.role_id# required>
                                <label class="form-check-label" for=#roles.role_id#>#roles.role_name#</label>
                            </div>
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
                            <input name="lastName" class="form-control" type="text" id="lastName" placeholder="Last Name *" required/>
                            <span id="lastNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                        <div>
                            <input name="password" class="form-control" type="password" id="password" required placeholder="Password *"/>
                            <span id="passwordError" class="valid-feedback d-block invisible">&nbsp;</span>
                        </div>
                    </div>
                    <div class="form-check d-flex flex-column gap-2">
                        <div>
                            <input name="email" class="form-control" type="email" id="email" required placeholder="Your Email *"/>
                            <span id="emailError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                        <div>
                            <input name="phone" class="form-control" type="phone" id="phone" required placeholder="Your Phone *"  pattern="\d{10}"/>
                            <span id="phoneError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                        <div>
                            <select name="department_id" class="form-select" id="department" required>
                                <option value="">Select Department *</option>
                                <cfoutput query=#departments#>
                                    <option value=#departments.department_id#>#departments.department_name#</option>
                                </cfoutput>
                            </select>
                            <span id="departmentError" class="invalid-feedback d-block invisible">&nbsp;</span>
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
                <a href="../login/login.cfm" class="text-primary text-decoration-none">Log In</a>
            </div>
        </form>
    </div>

    <script src="register.js"></script>
</html>

<cfif structKeyExists(form, "register-btn")>
    <cfinvoke method="doesMailExists" component="../services/UserServices/userQueries" returnvariable="flag">
        <cfinvokeargument name="email" value=#form.email#/>
    </cfinvoke>
    <cfif flag EQ true>
        <script>
            alert('Given Email Already Exists!')
        </script>
    <cfelse>
        <cfset session.userData = duplicate(form)>
        <cfdump var=#session.userData#/>
        <cflocation url="../utils/userValidator.cfm"/>
    </cfif>
</cfif>
