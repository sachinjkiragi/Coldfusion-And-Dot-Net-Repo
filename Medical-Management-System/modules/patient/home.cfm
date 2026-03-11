<cfparam name="url.reqPage" default="dashboard"/>
<html>
    <cfinclude template="../../includes/header.cfm"/>

    <body>
         <div class="min-vh-100 w-100">
            <nav class="d-flex align-items-center justify-content-between px-4 py-3 text-white"
                style="background: linear-gradient(90deg, #0d6efd, #0dcaf0);">
                <h3 class="m-0">MedManage</h3>
                <strong><a href="../../logout/logout.cfm" class="text-white text-decoration-none">Logout</a></strong>
            </nav>
            <div>
                <p class="text-center fw-normal display-6 mt-4">Welcome Patient</p>
            </div>
            <div class="border border-black m-3 rounded d-flex">
                <div class="text-white p-3" style="width: 20%">
                    <ul class="nav flex-column border border-black rounded overflow-hidden">
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "dashboard">
                                <a class="nav-link text-white bg-primary" href="home.cfm?reqPage=dashboard">Dashboard</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=dashboard">Dashboard</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "appointments">
                                <a class="nav-link text-white bg-primary" href="home.cfm?reqPage=appointments">Appointments</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=appointments">Appointments</a>
                            </cfif>
                        </li>
                        <li>
                            <cfif url.reqPage EQ "billingHistory">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=billingHistory">Billing History</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=billingHistory">Billing History</a>
                            </cfif>
                        </li>
                    </ul>
                </div>
                <div style="width: 80%">
                    <cfswitch expression=#url.reqPage#>
                        <cfcase value="dashboard">
                            <cfinclude template="pages/dashboard.cfm"/>
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
