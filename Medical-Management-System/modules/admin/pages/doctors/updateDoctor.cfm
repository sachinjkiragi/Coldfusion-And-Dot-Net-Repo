<cfset doctorIdToUpdate = url.doctorId/>
<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getDepartments" returnvariable="departmentList"/>

<cfinvoke method="getDoctorData" component="../../../../services/adminServices/adminQueries.cfc" returnvariable="doctorData">
    <cfinvokeargument name="doctorId" value=#doctorIdToUpdate#/>
</cfinvoke>


<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <cfinclude template = "../../../../includes/toast.cfm"/>
    <cfoutput>
        <div class="h-100 w-100 d-flex justify-content-center align-items-center">
            <form class="py-1" method="POST">
                <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                    <div>
                        <h2 class="text-primary">Update Doctor</h2>
                    </div>
                    <div class="d-flex gap-4">
                        <div class="form-check d-flex flex-column gap-2">
                            <div>
                                <label class="form-label fw-semibold">First Name:</label>
                                <input name="firstName" class="form-control" value="#doctorData.first_name#" type="text" id="firstName" required placeholder="First Name*"/>
                                <span id="firstNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Last Name:</label>
                                <input name="lastName" class="form-control" value=#doctorData.last_name# type="text" id="lastName" placeholder="Last Name"/>
                                <span id="lastNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Department:</label>
                                <div>
                                    <select id="departmentList" class="form-control d-block form-select" name="department_id" style="width: fit-content;">
                                        <option value="">Select Department</option>
                                        <cfoutput query="#departmentList#">
                                            <cfif departmentList.department_id EQ doctorData.department_id>
                                                <option selected value="#departmentList.department_id#">#department_name#</option>
                                            <cfelse>
                                                <option value="#departmentList.department_id#">#department_name#</option>
                                            </cfif>
                                        </cfoutput>
                                    </select>
                                </div>
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
                                <input name="phone" class="form-control" value=#doctorData.phone# type="phone" id="phone" required placeholder="Phone*"/>
                                <span id="phoneError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex gap-3">
                        <label class="form-label fw-semibold">Gender:</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="m" id="male" required <cfif doctorData.gender EQ 'M'>checked</cfif> >
                            <label class="form-check-label" for="male">Male</label>
                        </div>

                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="f" id="female" required <cfif doctorData.gender EQ 'F'>checked</cfif>>
                            <label class="form-check-label" for="female">Female</label>
                        </div>

                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="o" id="other" required <cfif doctorData.gender EQ 'O'>checked</cfif>>
                            <label class="form-check-label" for="other">Other</label>
                        </div>
                    </div>
                    
                    <span title="Please complete all required fields">
                        <button class="btn btn-primary" type="submit" name="update-btn"> Update </button>
                    </span>
                    <a href="home.cfm?reqPage=doctors" class="text-decoration-none">Go Back</a>
                </div>
            </form>
        </div>
    </cfoutput>
</html>

<cfif structKeyExists(form, "update-btn")>
    <cfset form.doctor_id = doctorIdToUpdate/>
    <cfinvoke component="../../../../services/adminServices/adminQueries" method="updatedoctorData" returnvariable="success">
        <cfinvokeargument name="doctorData" value=#form#/>
    </cfinvoke>
    
    <cfif success EQ true>
        <script>
            showToast('Update Done Successfully', 'success');
        </script>
    <cfelse>
        <script>
            showToast('Update failed. Please try again.', 'danger');
        </script>
    </cfif>
</cfif>