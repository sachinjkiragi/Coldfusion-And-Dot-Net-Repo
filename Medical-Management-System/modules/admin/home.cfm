<cfparam name="url.reqPage" default="dashboard"/>
<html>
    <cfinclude template="../../includes/header.cfm"/>

    <body>
         <div class="h-100 w-100 border border-black">
            <nav class="d-flex align-items-center justify-content-between px-4 py-3 text-white"
                style="background: linear-gradient(90deg, #0d6efd, #0dcaf0);">
                <h3 class="m-0">Hospital Here</h3>
                <strong><a href="../../logout/logout.cfm" class="text-white text-decoration-none">Logout</a></strong>
            </nav>
            <div class="border border-black">
                <p class="text-center fw-normal display-6 mt-4">Welcome Admin</p>
            </div>
            <div class="border border-black d-flex">
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
                            <cfif url.reqPage EQ "patients">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=Patients">Patients</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=Patients">Patients</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "doctors">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=doctors">Doctors</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=doctors">Doctors</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "appointments">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=appointments">Appointments</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=appointments">Appointments</a>
                            </cfif>
                        </li>
                    </ul>
                </div>
                <div class="border border-black" style="width: 80%">
                    <cfswitch expression=#url.reqPage#>
                        <cfcase value="dashboard">
                            <cfinclude template="pages/dashboard.cfm"/>
                        </cfcase>
                        <cfcase value="patients">
                            <cfinclude template="pages/patients/patients.cfm"/>
                        </cfcase>
                        <cfcase value="updatePatient">
                            <cfinclude template="pages/patients/updatePatient.cfm"/>
                        </cfcase>
                        <cfcase value="doctors">
                            <cfinclude template="pages/doctors/doctors.cfm"/>
                        </cfcase>
                        <cfcase value="updateDoctor">
                            <cfinclude template="pages/doctors/updateDoctor.cfm"/>
                        </cfcase>
                        <cfcase value="appointments">
                            <cfinclude template="pages/appointments/appointments.cfm"/>
                        </cfcase>
                        <cfcase value="updateAppointment">
                            <cfinclude template="pages/appointments/updateAppointment.cfm"/>
                        </cfcase>
                    </cfswitch>
                </div>
            </div>
         </div>
    </body>

</html>
