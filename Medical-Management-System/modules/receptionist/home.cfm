<cfparam name="url.reqPage" default="dashboard"/>
<html>
    <cfinclude template="../../includes/header.cfm"/>

    <body>
         <div class="min-vh-100 w-100">
            <nav class="position-fixed top-0 w-100 d-flex align-items-center justify-content-between px-4 py-3 text-white shadow-sm"
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
            <div style="margin-top: 10rem">
                <cfoutput>
                   <div class="text-center">
                        <h2 class="fw-semibold text-secondary">
                            <i class="bi bi-person-circle"></i>
                            Welcome, <span class="text-primary">#session.currUser.first_name#</span>
                        </h2>
                    </div>
                </cfoutput>
            </div>
            <div class="d-flex m-3 rounded shadow bg-white overflow-hidden">
                <div class="text-white p-3" style="width: 20%">
                    <ul class="nav flex-column bg-light rounded overflow-hidden">
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "dashboard">
                                <a class="nav-link text-white bg-primary" href="home.cfm?reqPage=dashboard"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=dashboard"><i class="bi bi-speedometer2 me-2"></i>Dashboard</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "myAccount">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=myAccount"><i class="bi bi-person-circle me-2"></i>My Account</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=myAccount"><i class="bi bi-person-circle me-2"></i>My Account</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "patients">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=patients"><i class="bi bi-people me-2"></i>Patient List</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=patients"><i class="bi bi-people me-2"></i>Patient List</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "doctors">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=doctors"><i class="bi bi-person-badge me-2"></i>Doctor List</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=doctors"><i class="bi bi-person-badge me-2"></i>Doctor List</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "appointments">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=appointments"><i class="bi bi-calendar-check me-2"></i>Appointments</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=appointments"><i class="bi bi-calendar-check me-2"></i>Appointments</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "scheduleAppointment">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=scheduleAppointment"><i class="bi bi-calendar-plus me-2"></i>Schedule Appointment</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=scheduleAppointment"><i class="bi bi-calendar-plus me-2"></i>Schedule Appointment</a>
                            </cfif>
                        </li>
                        <li>
                            <cfif url.reqPage EQ "addPatient" OR url.reqPage EQ "validatePatient">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=addPatient"><i class="bi bi-person-plus me-2"></i>Add Patient</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=addPatient"><i class="bi bi-person-plus me-2"></i>Add Patient</a>
                            </cfif>
                        </li>
                    </ul>
                </div>
                <div style="width: 80%">
                    <cfswitch expression=#url.reqPage#>
                        <cfcase value="dashboard">
                            <cfinclude template="pages/dashboard.cfm"/>
                        </cfcase>
                        <cfcase value="patients">
                            <cfinclude template="pages/patientDetails/patientList.cfm"/>
                        </cfcase>
                        <cfcase value="doctors">
                            <cfinclude template="pages/doctorDetails/doctorList.cfm"/>
                        </cfcase>
                        <cfcase value="appointments">
                            <cfinclude template="pages/appointmentDetails/appointments.cfm"/>
                        </cfcase>
                        <cfcase value="scheduleAppointment">
                            <cfinclude template="pages/appointmentDetails/scheduleAppointment.cfm"/>
                        </cfcase>
                        <cfcase value="addPatient">
                            <cfinclude template="pages/addPatient/addPatient.cfm"/>
                        </cfcase>
                        <cfcase value="updatePatient">
                            <cfset patientIdToUpdate = url.patientId/>
                            <cfinclude template="pages/updatePatient/updatePatient.cfm"/>
                        </cfcase>
                        <cfcase value="updateAppointment">
                            <cfset appointmentIdToUpdate = url.appointmentId/>
                            <cfinclude template="pages/updateAppointment/updateAppointment.cfm"/>
                        </cfcase>
                        <cfcase value="doctorAvailability">
                            <cfset doctor_id = url.doctorId/>
                            <cfinclude template="pages/doctorDetails/doctorAvailability.cfm"/>
                        </cfcase>
                        <cfcase value="myAccount">
                            <cfinclude template="pages//myAccount.cfm"/>
                        </cfcase>
                    </cfswitch>
                </div>
            </div>
        </div>
        <cfinclude template="../../includes/footer.cfm"/>
    </body>
</html>
