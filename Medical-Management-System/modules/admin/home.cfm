<cfparam name="url.reqPage" default="dashboard"/>
<html>
    <cfinclude template="../../includes/header.cfm"/>

    <body>
         <div class="min-vh-100 w-100">
            <nav class="d-flex align-items-center justify-content-between px-4 py-3 text-white shadow-sm"
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
                <cfoutput>
                   <div class="text-center mt-4 mb-4">
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
                                <a class="nav-link text-white bg-primary" href="home.cfm?reqPage=dashboard"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=dashboard"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "patients">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=Patients"><i class="bi bi-people me-2"></i> Patients</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=Patients"><i class="bi bi-people me-2"></i>Patients</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "doctors">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=doctors"><i class="bi bi-person-badge me-2"></i> Doctors</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=doctors"><i class="bi bi-person-badge me-2"></i> Doctors</a>
                            </cfif>
                        </li>
                        
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "receptionists">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=receptionists"><i class="bi bi-person-lines-fill me-2"></i> Receptionists</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=receptionists"><i class="bi bi-person-lines-fill me-2"></i> Receptionists</a>
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
                            <cfif url.reqPage EQ "medicines">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=medicines"><i class="bi bi-capsule me-2"></i>Medicines</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=medicines"><i class="bi bi-capsule me-2"></i>Medicines</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "timeSlots">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=timeSlots"><i class="bi bi-clock-history me-2"></i> Time Slots</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=timeSlots"><i class="bi bi-clock-history me-2"></i> Time Slots</a>
                            </cfif>
                        </li>
                        <li class="border-bottom border-black">
                            <cfif url.reqPage EQ "departments">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=departments"><i class="bi bi-building me-2"></i> Departments</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=departments"><i class="bi bi-building me-2"></i> Departments</a>
                            </cfif>
                        </li>
                        <li>
                            <cfif url.reqPage EQ "roles">
                                <a class="nav-link bg-primary text-white" href="home.cfm?reqPage=roles"><i class="bi bi-shield-lock me-2"></i> Roles</a>
                            <cfelse>
                                <a class="nav-link text-black" href="home.cfm?reqPage=roles"><i class="bi bi-shield-lock me-2"></i> Roles</a>
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
                            <cfinclude template="pages/patients/patients.cfm"/>
                        </cfcase>
                        <cfcase value="addPatient">
                            <cfinclude template="pages/patients/addPatient/addPatient.cfm"/>
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
                        <cfcase value="addDoctor">
                            <cfinclude template="pages/doctors/addDoctor/addDoctor.cfm"/>
                        </cfcase>
                        <cfcase value="appointments">
                            <cfinclude template="pages/appointments/appointments.cfm"/>
                        </cfcase>
                        <cfcase value="updateAppointment">
                            <cfinclude template="pages/appointments/updateAppointment.cfm"/>
                        </cfcase>
                        <cfcase value="addAppointment">
                            <cfinclude template="pages/appointments/addAppointment.cfm"/>
                        </cfcase>
                        <cfcase value="addPrescription">
                            <cfinclude template="pages/appointments/addPrescription.cfm"/>
                        </cfcase>
                        <cfcase value="viewPrescription">
                            <cfinclude template="pages/appointments/viewPrescription.cfm"/>
                        </cfcase>
                        <cfcase value="updatePrescription">
                            <cfinclude template="pages/appointments/updatePrescription.cfm"/>
                        </cfcase>
                        <cfcase value="medicines">
                            <cfinclude template="pages/medicines/medicines.cfm"/>
                        </cfcase>
                        <cfcase value="addMedicine">
                            <cfinclude template="pages/medicines/addMedicine.cfm"/>
                        </cfcase>
                        <cfcase value="updateMedicine">
                            <cfinclude template="pages/medicines/updateMedicine.cfm"/>
                        </cfcase>
                        <cfcase value="timeSlots">
                            <cfinclude template="pages/timeSlots/TimeSlots.cfm"/>
                        </cfcase>
                        <cfcase value="addTimeSlot">
                            <cfinclude template="pages/timeSlots/addTimeSlot.cfm"/>
                        </cfcase>
                        <cfcase value="departments">
                            <cfinclude template="pages/departments/departments.cfm"/>
                        </cfcase>
                        <cfcase value="addDepartment">
                            <cfinclude template="pages/departments/addDepartment.cfm"/>
                        </cfcase>
                        <cfcase value="updateDepartment">
                            <cfinclude template="pages/departments/updateDepartment.cfm"/>
                        </cfcase>
                        <cfcase value="roles">
                            <cfinclude template="pages/roles/roles.cfm"/>
                        </cfcase>
                        <cfcase value="addRole">
                            <cfinclude template="pages/roles/addRole.cfm"/>
                        </cfcase>
                        <cfcase value="updateRole">
                            <cfinclude template="pages/roles/updateRole.cfm"/>
                        </cfcase>
                        <cfcase value="receptionists">
                            <cfinclude template="pages/receptionists/receptionists.cfm"/>
                        </cfcase>
                        <cfcase value="updateReceptionist">
                            <cfinclude template="pages/receptionists/updateReceptionist.cfm"/>
                        </cfcase>
                        <cfcase value="addReceptionist">
                            <cfinclude template="pages/receptionists/addReceptionist/addReceptionist.cfm"/>
                        </cfcase>
                    </cfswitch>
                </div>
            </div>
        </div>
        <cfinclude template="../../includes/footer.cfm"/>
    </body>
</html>