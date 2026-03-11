<cfset success = true/>
<cftry>
    <cfif structKeyExists(session, "otp") EQ false>
        <cfset session.otp = randRange(100000, 999999)>
        <cfset session.otpTime = now()/>
        <!--- <cfmail from="noreply@med.com" to=#form.email# subject="OTP Verification">
            Your Otp Is #session.otp#
        </cfmail> --->
        
    </cfif>
<cfcatch>
    <cfset success = false/>
    <!---<cfdump var=#cfcatch#/> --->
</cfcatch>
</cftry>

<cfif structKeyExists(form, "email")>
   <cfset session.email = form.email/>
</cfif>

<html>
    <cfdump var=#session.otp# label="OTP"/>
    <nav class="d-flex align-items-center justify-content-between px-4 py-3 text-white" 
     style="background: linear-gradient(90deg, #0d6efd, #0dcaf0);">
        <h3 class="m-0">Hospital Here</h3>
    </nav>
    <cfinclude template = "../includes/header.cfm"/>
    <div class="h-100 w-100 border border-black d-flex justify-content-center align-items-center">
        <form style="width: fit-content;" class="card shadow  p-5" method="POST" action="verifyOtp.cfm">
            <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Reset Password</h2>
                    <p class="text-secondary">We have sent an OTP to your mail.</p>
                </div>
                <div class="form-check">
                    <input name="otp" class="form-control" type="number" id="otp" required placeholder="OTP *"/>
                </div>
                <div class="form-check">
                    <input name="newPassword" class="form-control" type="password" id="newPassword" required placeholder="New Password *"/>
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

    <cfif dateDiff("s", session.otpTime, now()) GT 120>
        <cfinvoke method="clearOtp"/>
        <script>
            alert('OTP Expired');
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
                    alert('Password Updated successfully');
                    window.location.href = '../login/login.cfm';
                </script>
            <cfelse>
                <script>
                    alert('Failed To Updated password. Please try again.');
                </script>
            </cfif>
        <cfelse>
            <script>
                alert('Invalid Otp');
            </script>
        </cfif>
    </cfif>
</cfif>
