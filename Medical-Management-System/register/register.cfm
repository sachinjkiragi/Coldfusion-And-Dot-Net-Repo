<cfinvoke method="getDepartments" component="../services/UserServices/userQueries" returnvariable="departments"/>

<html>
    <cfinclude template = "../includes/header.cfm"/>
    <div class="h-100 w-100 border border-black d-flex justify-content-center align-items-center">
        <form style="width: fit-content;" class="card shadow  p-5">
            <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Register Yourself As</h2>
                </div>
                <div class="p-2 d-flex gap-4 justify-content-center align-items-center">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="role" value="patient" id="patient" required>
                        <label class="form-check-label" for="patient">Patient</label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="role" value="doctor" id="doctor">
                        <label class="form-check-label" for="doctor">Doctor</label>
                    </div>
                </div>

                <div class="d-flex gap-4">
                    <div class="form-check d-flex flex-column gap-4">
                        <input class="form-control" type="text" id="first_name" required placeholder="First Name *"/>
                        <input class="form-control" type="text" id="last_name" required placeholder="Last Name"/>
                        <input class="form-control" type="password" id="password" required placeholder="Password *"/>
                    </div>
                    <div class="form-check d-flex flex-column gap-4">
                        <input class="form-control" type="email" id="email" required placeholder="Your Email *"/>
                        <input class="form-control" type="phone" id="phone" required placeholder="Your Phnoe *"/>
                        <select name="department" class="form-select">
                            <cfoutput query=#departments#>
                                <option value=#departments.department_id#>#departments.department_name#</option>
                            </cfoutput>
                        </select>
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
                    <button class="btn btn-primary" type="submit" name="register-btn" disabled> Register </button>
                </span>
            </div>
        </form>
    </div>
</html>