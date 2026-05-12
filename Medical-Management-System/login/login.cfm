<html>
<cfinclude template="../includes/header.cfm"/>

<nav class="d-flex align-items-center px-4 py-3 text-white shadow-sm position-fixed w-100 z-1"
    style="background: linear-gradient(90deg, #0d6efd, #0dcaf0);">
    <div class="d-flex align-items-center gap-3">
        <i class="bi bi-heart-pulse fs-1"></i>
        <h2 class="m-0 fw-bold">MedManage</h2>
    </div>
</nav>

<div class="h-100 w-100 d-flex justify-content-center align-items-center">
    <form class="card shadow-lg p-5 border-0 mt-5 needs-validation" style="width:360px;" method="POST" novalidate>
        <div class="d-flex flex-column gap-3 align-items-center">
            <div>
                <h2 class="text-primary">Log In</h2>
            </div>

            <div class="form-group w-100">
                <label class="form-label fw-semibold" for="email">Email:</label>
                <input name="email" class="form-control" type="email" id="email" required placeholder="Your Email*"/>
                <div class="invalid-feedback">
                    Please enter a valid email.
                </div>
            </div>

            <div class="form-group w-100">
                <label class="form-label fw-semibold" for="password">Password:</label>
                <input name="password" class="form-control" type="password" id="password" required placeholder="Password*"/>
                <div class="invalid-feedback">
                    Please enter your password.
                </div>
            </div>

            <button class="btn btn-primary w-100" type="submit" name="submit-btn">Log In</button>

            <span id="logInErrorMsg" class="text-danger d-none mt-2"></span>
            <a href="resetPassword.cfm" class="text-primary text-decoration-none mt-2">Reset Password</a>
        </div>
    </form>
</div>

<script>
    const form = document.querySelector('.needs-validation');
    form.addEventListener('submit', function(e) {
        if (!form.checkValidity()) {
            e.preventDefault();
        }
        form.classList.add('was-validated');
    });
</script>

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
        <cfset session.currUser = qryCurrUser/>
        <script>
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
</html>