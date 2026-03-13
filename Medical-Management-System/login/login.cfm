<html>
    <cfinclude template = "../includes/header.cfm"/>
    <nav class="d-flex align-items-center px-4 py-3 text-white shadow-sm"
        style="background: linear-gradient(90deg, #0d6efd, #0dcaf0);">
        <div class="d-flex align-items-center gap-3">
            <i class="bi bi-heart-pulse fs-1"></i>
            <h2 class="m-0 fw-bold">
                MedManage
            </h2>
        </div>
    </nav>
    <div class="h-100 w-100 d-flex justify-content-center align-items-center">
        <form style="width: fit-content;" class="card shadow  p-5" method="POST">
            <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Log In</h2>
                </div>
                <div class="form-check">
                    <input name="email" class="form-control" type="email" id="email" required placeholder="Your Email *"/>
                </div>
                <div class="form-check">
                    <input name="password" class="form-control" type="password" id="password" required placeholder="Password *"/>
                </div>
                
                <span title="Please complete all required fields">
                    <button class="btn btn-primary" type="submit" name="submit-btn"> Log In </button>
                </span>
                <span id="logInErrorMsg" class="text-danger d-none"></span>
                <a href="../register/register.cfm" class="text-primary text-decoration-none">Register</a>
                <a href="resetPassword.cfm" class="text-primary text-decoration-none">Reset Password</a>
            </div>
        </form>
    </div>
</html>

<cfif structKeyExists(form, "submit-btn")>
    <cfinvoke component="../services/UserServices/userQueries" method="isUserValid" returnvariable="qryCurrUser">
        <cfinvokeargument name="credentials" value=#form#/>
    </cfinvoke>
    <cfif qryCurrUser.recordCount EQ 0>
        <script>
            var logInErrorEle = document.getElementById('logInErrorMsg');
            logInErrorEle.classList.remove('d-none');
            logInErrorEle.textContent = "Invalid email or password";
        </script>
    <cfelse>
        <cfdump var=#qryCurrUser# label="qryCurrUser"/>
        <cfset session.currUser = qryCurrUser/>
        <cfdump var=#session# label="session"/>
        <script>
            alert('User Logged In Successfully');
            <cfif session.currUser.role_id EQ 1>
                window.location.href = "../modules/admin/home.cfm";
            <cfelseif session.currUser.role_id EQ 2>
                window.location.href = "../modules/doctor/home.cfm";
            <cfelseif session.currUser.role_id EQ 3>
                window.location.href = "../modules/receptionist/home.cfm";
            <cfelseif session.currUser.role_id EQ 4>
                window.location.href = "../modules/patient/home.cfm";
            </cfif>
        </script>
    </cfif>
</cfif>