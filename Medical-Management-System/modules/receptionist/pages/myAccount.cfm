<cfinvoke component="../../../services/adminServices/adminQueries.cfc" method="getDepartments" returnvariable="departmentList"/>

<cfinvoke method="getReceptionistData" component="../../../services/adminServices/adminQueries.cfc" returnvariable="receptionistData">
    <cfinvokeargument name="receptionistId" value=#session.currUser.user_id#/>
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
                                <input readonly name="firstName" class="form-control" value="#receptionistData.first_name#" type="text" id="firstName" required placeholder="First Name*"/>
                                <span id="firstNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Last Name:</label>
                                <input readonly name="lastName" class="form-control" value=#receptionistData.last_name# type="text" id="lastName" placeholder="Last Name"/>
                                <span id="lastNameError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>
                            <div>
                                <label class="form-label fw-semibold">Department:</label>
                                <div>
                                    <cfoutput query="#departmentList#">
                                        <cfif departmentList.department_id EQ receptionistData.department_id>
                                            <input class="form-control" readonly value="#departmentList.department_name#"/>
                                        </cfif>
                                    </cfoutput>
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
                                <input readonly name="phone" class="form-control" value=#receptionistData.phone# type="phone" id="phone" required placeholder="Phone*"/>
                                <span id="phoneError" class="invalid-feedback d-block invisible">&nbsp;</span>
                            </div>

                            <div class="d-flex flex-column">
                                <label class="form-label fw-semibold">Gender:</label>
                                <div class="d-flex">
                                    <cfif receptionistData.gender EQ 'M'>
                                        <input readonly name="gender" class="form-control" value='Male' type="phone" id="gender" required/>
                                    <cfelseif receptionistData.gender EQ 'F'>
                                        <input readonly name="gender" class="form-control" value='Female' type="phone" id="gender" required />
                                    <cfelse>
                                        <input readonly name="gender" class="form-control" value='Other' type="phone" id="gender" required />
                                    </cfif>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </form>
        </div>
    </cfoutput>
</html>
