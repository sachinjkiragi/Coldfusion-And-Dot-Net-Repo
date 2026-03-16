<cfinvoke method="getRoles" component="../../../../services/UserServices/userQueries.cfc" returnvariable="roles"/>
<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
        <div class="h-100 w-100  d-flex justify-content-center align-items-center">
            <form class="p-5" method="POST">
                <div class="d-flex flex-column gap-3 align-items-center">
                    <div class="toast-container position-fixed top-0 end-0" style="padding: 5rem 1rem;">
                        <div class="toast p-2" id="toast" role="alert" data-bs-delay="4000">
                            <div class="toast-body">
                                <div class="d-flex flex-column flex-grow-1 gap-2">
                                    <div class="d-flex align-items-center">
                                        <span id="alertMsg" class="fw-semibold text-white"></span>
                                        <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="toast"></button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
                            <label class="form-label fw-semibold">First Name:</label>
                            <input name="firstName" class="form-control" type="text" id="firstName" required placeholder="First Name*"/>
                            <span id="firstNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                        <div>
                            <label class="form-label fw-semibold">Last Name:</label>
                            <input name="lastName" class="form-control" type="text" id="lastName" placeholder="Last Name"/>
                            <span id="lastNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                    </div>
                    <div class="form-check d-flex flex-column gap-2">
                        <div>
                            <label class="form-label fw-semibold">Email:</label>
                            <input name="email" class="form-control" type="email" id="email" required placeholder="Email*"/>
                            <span id="emailError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                        <div>
                            <label class="form-label fw-semibold">Phone:</label>
                            <input name="phone" class="form-control" type="phone" id="phone" required placeholder="Phone*"/>
                            <span id="phoneError" class="invalid-feedback d-block invisible">&nbsp;</span>
                        </div>
                    </div>
                </div>
                <div class="d-flex">
                    <label class="form-label fw-semibold">Gender:</label> <br>
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
                </div>
                
                <span title="Please complete all required fields">
                    <button class="btn btn-primary" type="submit" name="register-btn"> Register </button>
                </span>
            </div>
        </form>
    </div>

    <script src="pages/addPatient/addPatient.js"></script>
</html>

<script>
    const alertEle = document.getElementById('alertMsg');
    const toastEle = document.getElementById("toast");
</script>

<cfif structKeyExists(form, "register-btn")>
    <cfinvoke method="doesMailExists" component="../../../../services/receptionistServices/receptionistQueries" returnvariable="flag">
        <cfinvokeargument name="email" value=#form.email#/>
    </cfinvoke>
    <cfif flag EQ true>
        <script>
            toastEle.classList.add('text-bg-warning');
            alertEle.innerText = 'Provided email exists already!';
            const toast = new bootstrap.Toast(toastEle);
            toast.show();
        </script>
    <cfelse>
        <cfset form.password = randRange(100000, 999999)/>
        <cfinvoke component="../../../../services/receptionistServices/receptionistQueries" method="insertPatientData" returnvariable="success">
            <cfinvokeargument name="patientData" value=#form#/>
        </cfinvoke>
        
        <cfif success EQ true>
            <cfmail to="#form.email#" from="noreply@med.com" subject="temporary Passoword for MedManage Login">Your temporary Passoword for MedManage LogIn is #form.password#
            </cfmail> 
            <script>
                toastEle.classList.add('text-bg-success');
                alertEle.innerText = 'Registeration Done Successfully';
                const toast = new bootstrap.Toast(toastEle);
                toast.show();
            </script>
        <cfelse>
            <script>
                toastEle.classList.add('text-bg-danger');
                alertEle.innerText = 'Registration failed. Please try again.';
                const toast = new bootstrap.Toast(toastEle);
                toast.show();
            </script>
        </cfif>

    </cfif>
</cfif>


<script>

</script>