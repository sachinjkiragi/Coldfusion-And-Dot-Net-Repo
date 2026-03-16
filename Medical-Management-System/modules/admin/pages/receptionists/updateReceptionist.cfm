<cfset receptionistIdToUpdate = url.receptionistId/>
<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getDepartments" returnvariable="departmentList"/>

<cfinvoke method="getReceptionistData" component="../../../../services/adminServices/adminQueries.cfc" returnvariable="receptionistData">
    <cfinvokeargument name="receptionistId" value=#receptionistIdToUpdate#/>
</cfinvoke>

<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <cfinclude template = "../../../../includes/toast.cfm"/>
    <cfoutput>
        <div class="h-100 w-100 d-flex justify-content-center align-items-center">
            <form class="py-1" method="POST">
                <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                    <div>
                        <h2 class="text-primary">Update Receptionist</h2>
                    </div>
                    <div class="d-flex gap-4">
                        <div class="form-check d-flex flex-column gap-2">
                            <div>
                                <label class="form-label fw-semibold">First Name:</label>
                                <input name="firstName" class="form-control" value="#receptionistData.first_name#" type="text" id="firstName" required placeholder="First Name*"/>
                                <span id="firstNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Last Name:</label>
                                <input name="lastName" class="form-control" value=#receptionistData.last_name# type="text" id="lastName" placeholder="Last Name"/>
                                <span id="lastNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Department:</label>
                                <div>
                                    <select id="departmentList" class="form-control d-block form-select" name="department_id" style="width: fit-content;">
                                        <cfoutput query="#departmentList#">
                                            <cfif departmentList.department_id EQ receptionistData.department_id>
                                                <option selected value="#departmentList.department_id#">#department_name#</option>
                                            </cfif>
                                        </cfoutput>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="form-check d-flex flex-column gap-2">
                            <div>
                                <label class="form-label fw-semibold">Email:</label>
                                <input readonly name="email" class="form-control" value=#receptionistData.email# type="email" id="email" required placeholder="Email*"/>
                                <span id="emailError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Phone:</label>
                                <input name="phone" class="form-control" value=#receptionistData.phone# type="phone" id="phone" required placeholder="Phone*"/>
                                <span id="phoneError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            
                        </div>
                    </div>
                    <div class="d-flex gap-3">
                        <label class="form-label fw-semibold">Gender:</label>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="m" id="male" required <cfif receptionistData.gender EQ 'M'>checked</cfif> >
                            <label class="form-check-label" for="male">Male</label>
                        </div>

                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="f" id="female" required <cfif receptionistData.gender EQ 'F'>checked</cfif>>
                            <label class="form-check-label" for="female">Female</label>
                        </div>

                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="gender" value="o" id="other" required <cfif receptionistData.gender EQ 'O'>checked</cfif>>
                            <label class="form-check-label" for="other">Other</label>
                        </div>
                    </div>
                    
                    <span title="Please complete all required fields">
                        <button class="btn btn-primary" type="submit" name="update-btn"> Update </button>
                    </span>
                    <a href="home.cfm?reqPage=receptionists" class="text-decoration-none">Go Back</a>
                </div>
            </form>
        </div>
    </cfoutput>
</html>

<cfif structKeyExists(form, "update-btn")>
    <cfset form.receptionist_id = receptionistIdToUpdate/>
    <cfinvoke component="../../../../services/adminServices/adminQueries" method="updatereceptionistData" returnvariable="success">
        <cfinvokeargument name="receptionistData" value=#form#/>
    </cfinvoke>
    
    <cfif success EQ true>
        <script>
            showToast('Update Done Successfully', 'success')
        </script>
    <cfelse>
        <script>
            showToast('Update failed. Please try again.', 'danger')
        </script>
    </cfif>
</cfif>