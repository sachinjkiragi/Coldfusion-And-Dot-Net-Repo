<cfset success = true/>
<cfif structKeyExists(form, "email")>
    <cfinvoke method="doesMailExists" component="../services/UserServices/userQueries" returnvariable="flag">
        <cfinvokeargument name="email" value=#form.email#/>
    </cfinvoke>
    <cfif flag EQ false>
        <script>
        alert('Given Email does not Exists!')
        window.location.href = "resetPassword.cfm";
        </script>
    <cfelse>
        <cfset session.email = form.email/>
    </cfif>
</cfif>

<cftry>
    <cfif structKeyExists(session, "otp") EQ false>
        <cfset session.otp = randRange(100000, 999999)>
        <cfset session.otpTime = now()/>
        <cfmail to="#form.email#" from="noreply@med.com" subject="OTP Verification">Your OTP is #session.otp#
        </cfmail> 
    </cfif>
<cfcatch>
    <cfset success = false/>
    <cflog file="MedManageLogs" text="#cfcatch.message#" type="error"/>
    <!---<cfdump var=#cfcatch#/> --->
</cfcatch>
</cftry>


<html>
    <nav class="d-flex align-items-center px-4 py-3 text-white shadow-sm position-fixed w-100 z-1"
    style="background: linear-gradient(90deg, #0d6efd, #0dcaf0);">
    <div class="d-flex align-items-center gap-3">
        <i class="bi bi-heart-pulse fs-1"></i>
        <h2 class="m-0 fw-bold">
            MedManage
        </h2>
    </div>
</nav>
<cfinclude template = "../includes/header.cfm"/>
<cfinclude template = "../includes/toast.cfm"/>
<div class="h-100 w-100 border border-black d-flex justify-content-center align-items-center">
    <form class="card shadow-lg p-5 border-0" style="width:360px;" method="POST" action="verifyOtp.cfm">
        <cfdump var=#session.otp# label="OTP"/>
            <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Reset Password</h2>
                    <p class="text-secondary">We have sent an OTP to your mail.</p>
                </div>
                <div class="form-check">
                    <label class="form-label fw-semibold">OTP:</label>
                    <input name="otp" class="form-control" type="number" id="otp" required placeholder="OTP*"/>
                </div>
                <div class="form-check">
                    <label class="form-label fw-semibold">New Password:</label>
                    <input name="newPassword" class="form-control" type="password" id="newPassword" required placeholder="New Password*"/>
                </div>
                <span title="Please complete all required fields">
                    <button class="btn btn-primary" type="submit" name="submit-btn"> Submit </button>
                </span>
                <a href="resetPassword.cfm" class="text-primary text-decoration-none">Go Back</a>
            </div>
        </form>
    </div>
</html>

<cfif structKeyExists(form, 'submit-btn')>
    <cffunction name="clearOtp">
        <cfif structKeyExists(session, "otp")>
            <cfset structDelete(session, "otp")/>
            <cfset structDelete(session, "otpTime")/>
        </cfif>
    </cffunction>
    <cffunction name="clearUserData">
        <cfif structKeyExists(session, "userData")>
            <cfset structDelete(session, "userData")/>
        </cfif>
    </cffunction>

    <cfif dateDiff("s", session.otpTime, now()) GT 60>
        <cfinvoke method="clearOtp"/>
        <script>
            showToast('OTP Expired', 'warning');
        </script>
    </cfif>

    <cfif structKeyExists(form, "submit-btn") AND structKeyExists(session, "otp") AND structKeyExists(form, 'otp')>
        <cfif session.otp EQ form.otp>
            
            <cfinvoke method="resetPassword" component="../services/userServices/userQueries" returnvariable="success">
                <cfinvokeargument name="email" value=#session.email#/>
                <cfinvokeargument name="password" value=#form.newPassword#/>
            </cfinvoke>
            <cfif success EQ true>
                <cfinvoke method="clearOtp"/>
                <cfinvoke method="clearUserData"/>
                <cfset structDelete(session, "email")/>
                <script>
                    showToast('Password Updated successfully', 'success')
                    window.location.href = '../login/login.cfm';
                </script>
            <cfelse>
                <script>
                    showToast('Failed To Updated password. Please try again.', 'danger')
                </script>
            </cfif>
        <cfelse>
            <script>
                showToast('Invalid OTP', 'warning')
            </script>
        </cfif>
    </cfif>
</cfif>
