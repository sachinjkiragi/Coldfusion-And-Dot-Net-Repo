<html>
    <cfinclude template = "../includes/header.cfm"/>
    <nav class="d-flex align-items-center justify-content-between px-4 py-3 text-white" 
     style="background: linear-gradient(90deg, #0d6efd, #0dcaf0);">
        <h3 class="m-0">Hospital Here</h3>
    </nav>
    <div class="h-100 w-100 d-flex justify-content-center align-items-center">
        <form style="width: fit-content;" class="card shadow  p-5" method="POST" action="verifyOtp.cfm">
            <div class="d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Reset Password</h2>
                </div>
                <div class="form-check">
                    <input name="email" class="form-control" type="email" id="email" required placeholder="Your Email *"/>
                </div>
                <span title="Please complete all required fields">
                    <button class="btn btn-primary" type="submit" name="submit-btn"> Submit </button>
                </span>
                <a href="login.cfm" class="text-primary text-decoration-none">Go Back</a>
            </div>
        </form>
    </div>
</html>