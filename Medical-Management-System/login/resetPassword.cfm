<html>
    <cfinclude template = "../includes/header.cfm"/>
    <div class="h-100 w-100 border border-black d-flex justify-content-center align-items-center">
        <form style="width: fit-content;" class="card shadow  p-5" method="POST" action="verifyOtp.cfm">
            <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Log In</h2>
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