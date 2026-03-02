<cfset success = true/>
<cftry>
    <cfif structKeyExists(session, "otp") EQ false>
        <cfset session.otp = randRange(100000, 999999)>
        <cfset session.otpTime = now()/>
        <!--- <cfmail from="noreply@mms.com" to=#session.userData.email# subject="OTP Verification">
            Your Otp Is #session.otp#
        </cfmail> --->
    </cfif>
<cfcatch>
    <cfset success = false/>
    <!---<cfdump var=#cfcatch#/> --->
</cfcatch>
</cftry>

<cfif success EQ true>
    <html>
        <cfdump var=#session.otp#/>
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
                    <a href="userValidator.cfm" class="text-primary text-decoration-none">Resend OTP</a>
                    <a href="../register/register.cfm" class="text-primary text-decoration-none">Go Back</a>
                </div>
            </form>
        </div>
    </html>


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
            <cfinvoke method="insertUserData" component="../services/userServices/userQueries" returnvariable="success">
                <cfinvokeargument name="userData" value=#session.userData#/>
            </cfinvoke>
            <cfif success EQ true>
                <cfinvoke method="clearOtp"/>
                <cfinvoke method="clearUserData"/>
                <script>
                    alert('Registration done successfully');
                    window.location.href = '../login/login.cfm';
                </script>
            <cfelse>
                <script>
                    alert('Registration failed. Please try again.');
                </script>
            </cfif>
        <cfelse>
            <script>
                alert('Invalid Otp');
            </script>
        </cfif>
    </cfif>
</cfif>