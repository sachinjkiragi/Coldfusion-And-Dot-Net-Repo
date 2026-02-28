<cfset success = true/>
<cftry>
    <cfif structKeyExists(session, "otp") EQ false>
        <cfset session.otp = randRange(100000, 999999)>
        <cfmail from="noreply@mms.com" to=#session.userData.email# subject="OTP Verification">
            Your Otp Is #session.otp#
        </cfmail>
    </cfif>
<cfcatch>
    <cfset success = false/>
    <cfdump var=#cfcatch#/>
</cfcatch>
</cftry>

<cfif success EQ true>
    <html>
        <cfinclude template = "../includes/header.cfm"/>
        <div class="h-100 w-100 border border-black d-flex justify-content-center align-items-center">
            <form style="width: fit-content;" class="card shadow  p-5" method="POST">
                <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                    <div>
                        <h2 class="text-primary">Validate Yourself </h2>
                    </div>
                    <div>
                        <p class="text-secondary">An OTP has been sent to your email address. Please enter it to complete verification.</p>
                    </div>
                    <div>
                        <input name="otp" class="form-control" type="text" id="otp" required placeholder="OTP *"/>
                    </div>
                    <div>
                        <p id="otpTimer" class="text-secondary"></p>
                    </div>
                    
                    <span title="Please complete all required fields">
                        <button class="btn btn-primary" type="submit" name="submit-btn"> Submit </button>
                    </span>
                    <a href="../register/register.cfm" class="text-primary text-decoration-none">Go Back</a>
                </div>
            </form>
        </div>
    </html>

    <cfif structKeyExists(form, "submit-btn")>
        <cfif session.otp EQ form.otp>
            <cfset structDelete(session, "userData")/>
            <cfset structDelete(session, "otp")/>
            <cfset structDelete(session, "otpTime")/>
            <cflocation url="../login/login.cfm"/>
        <cfelse>
            <script>
                alert('Invalid Otp');
            </script>
        </cfif>
    </cfif>
</cfif>