<cfparam name="url.reqPage" default="appointments"/>
<html>
    <cfinclude template="../../includes/header.cfm"/>

    <body>
         <div class="min-vh-100 w-100">
            <nav class="z-3 z-3 position-fixed top-0 w-100 d-flex align-items-center justify-content-between px-4 py-3 text-white shadow-sm"
                style="background: linear-gradient(90deg, #0d6efd, #0dcaf0);">
                <div class="d-flex gap-2">
                    <i class="bi bi-heart-pulse fs-1"></i>
                    <h2 class="m-0 fw-bold" style="letter-spacing:1px;">
                        MedManage
                    </h2>
                </div>
                <a href="../../logout/logout.cfm" 
                class="btn btn-light btn-sm fw-semibold d-flex align-items-center gap-2">
                    <i class="bi bi-box-arrow-right"></i>
                    Logout
                </a>
            </nav>
            <div>
            <div style="margin-top: 6rem">
                <cfoutput>
                   <div class="text-center">
                        <h2 class="fw-semibold text-secondary">
                            <i class="bi bi-person-circle"></i>
                            Welcome, <span class="text-primary">#session.currUser.first_name#</span>
                        </h2>
                    </div>
                </cfoutput>
            </div>
            </div>
            <div class="d-flex m-3 rounded shadow bg-white overflow-hidden">
                <div class="text-white p-3" style="width: 20%">
                    <ul class="nav flex-column bg-light rounded overflow-hidden">
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "myAccount">
                                <a class="nav-link text-white bg-primary" href="home.cfm?reqPage=myAccount"><i class="bi bi-person-circle me-2"></i>My Account</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=myAccount"><i class="bi bi-person-circle me-2"></i>My Account</a>
                            </cfif>
                        </li>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "appointments">
                                <a class="nav-link text-white bg-primary" href="home.cfm?reqPage=appointments"><i class="bi bi-calendar-check me-2"></i>Appointments</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=appointments"><i class="bi bi-calendar-check me-2"></i>Appointments</a>
                            </cfif>
                        </li>
                        <li>
                            <cfif url.reqPage EQ "billingHistory">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=billingHistory"><i class="bi bi-receipt me-2"></i>Billing History</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=billingHistory"><i class="bi bi-receipt me-2"></i>Billing History</a>
                            </cfif>
                        </li>
                    </ul>
                </div>
                <div style="width: 80%">
                    <cfswitch expression=#url.reqPage#>
                        <cfcase value="myAccount">
                            <cfinclude template="pages/myAccount.cfm"/>
                        </cfcase>
                        <cfcase value="appointments">
                            <cfinclude template="pages/appointments/appointments.cfm"/>
                        </cfcase>
                        <cfcase value="patientHistory">
                            <cfinclude template="pages/patientHistory/patientHistory.cfm"/>
                        </cfcase>
                        <cfcase value="viewPrescription">
                            <cfinclude template="pages/appointments/viewPrescription.cfm"/>
                        </cfcase>
                        <cfcase value="downloadPrescription">
                            <cfinclude template="pages/appointments/viewPrescription.cfm"/>
                        </cfcase>
                        <cfcase value="billingHistory">
                            <cfinclude template="pages/billingHistory.cfm"/>
                        </cfcase>
                    </cfswitch>
                </div>
            </div>
        </div>
        <cfinclude template="../../includes/footer.cfm"/>
    </body>
</html>
