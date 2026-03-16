<cfset queryServicesPath = "../../../../services/adminServices/adminQueries.cfc"/>
<cfinvoke component=#queryServicesPath# method="getUserList" returnvariable="patientList">
    <cfinvokeargument name="role" value="Patient"/>
</cfinvoke>

<cfinvoke component=#queryServicesPath# method="getUserList" returnvariable="doctorList">
    <cfinvokeargument name="role" value="Doctor"/>
</cfinvoke>

<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getTimeSlots" returnvariable="timeSlotList">
</cfinvoke>

<div>
    <form class="p-3 d-flex flex-column align-items-center gap-4" method="POST">
        <div>
            <h3 class="text-primary">Schedule an appointment</h3>
        </div>
        <div class="d-flex flex-column gap-3" style="width: 50%;">
            <div class="d-flex justify-content-between">
                <div class="form-check">
                    <label class="form-label fw-semibold">Doctor:</label>
                    <select id="doctor" class="form-control d-block form-select" name="doctor_id" style="width: fit-content;" required>
                        <option value="">Select Doctor</option>
                        <cfoutput query=#doctorList#>
                            <option value=#doctorList.user_id#>#doctorList.first_name#  #doctorList.last_name# - #doctorList.department_name#</option>
                        </cfoutput>
                    </select>
                </div>
                <div class="form-check">
                    <label class="form-label fw-semibold">Patient:</label>
                    <select required id="patient" class="form-control form-select" name="patient_id" style="width: fit-content;" required>
                        <option value="">Select Patient</option>
                        <cfoutput query=#patientList#>
                            <option value=#patientList.user_id#>#patientList.first_name#  #patientList.last_name#</option>
                        </cfoutput>
                    </select>
                </div>
            </div>
            <div class="d-flex justify-content-between">
                <div class="form-check">
                    <label class="form-label fw-semibold">Appointment Charges:</label>
                    <input name="appointment_charges" class="form-control" placeholder="Appointment Charges" id="appointment_charges" type="number" min="0" required/>
                </div>

                 <div class="form-check">
                    <label class="form-label fw-semibold">Time Slot:</label>
                    <select required id="timeSlots" class="form-control form-select" name="timeslot_id" style="width: fit-content">
                        <option value="">Select Time Slot</option>
                        <cfoutput query=#timeSlotList#>
                            <option value=#timeSlotList.timeslot_id#>#timeFormat(timeSlotList.start_time, 'HH:mm')# - #timeFormat(timeSlotList.end_time, 'HH:mm')# </option>
                        </cfoutput>
                    </select>
                </div>
            </div>
            
            <div class="form-check">
                <label class="form-label fw-semibold">Slot Date:</label>
                <input class="form-control w-25" placeholder="Date" name="slot_date" type="text" id="my_date_picker">
            </div>
            <button name="book-btn" type="submit" class="btn btn-primary mx-auto" style="width: fit-content;">Book Appointment</button>
            <a href="home.cfm?reqPage=appointments" class="text-primary text-decoration-none text-center">Go Back</a>

        </div>
    </form>
</div>

<script>
    $(document).ready(function () {
        $('#doctor').select2({
            placeholder: "Search doctor",
            allowClear: true
        });
        $('#patient').select2({
            placeholder: "Search doctor",
            allowClear: true
        });
        $('#timeSlots').select2({
            placeholder: "Search doctor",
            allowClear: true
        });
    });
    
    $(document).ready(function () {
        $(function () {
            $("#my_date_picker").
            datepicker({
                dateFormat: "dd/mm/yy"
            });
        });
    }) 
</script>

<cfif structKeyExists(form, "book-btn")>
    <cfset form.status = "Booked"/>

    <cfinvoke component=#queryServicesPath# method="isDoctorAvailable" returnvariable="isAvailable">
        <cfinvokeargument name="appointmentDetails" value=#form#/>
    </cfinvoke>

    <cfif isAvailable EQ false>
        <script>alert('The selected date and time slot are not available for this doctor. Please choose another slot.');</script>
        <cfabort/>
    </cfif>

    <cfinvoke component=#queryServicesPath# method="insertAppointment" returnvariable="success">
        <cfinvokeargument name="appointmentDetails" value=#form#/>
    </cfinvoke>


    <cfif success EQ true>
        <script>
            alert("Appointment booked successfully.");
        </script>
    <cfelse>
        <script>
            alert("Appointment booking failed. Please try again.");
        </script>
    </cfif>

</cfif>