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
    <div class="h-100 w-100 d-flex justify-content-center align-items-center">
        <form class="card shadow-lg p-5 border-0" style="width:360px;" method="POST" action="verifyOtp.cfm">
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