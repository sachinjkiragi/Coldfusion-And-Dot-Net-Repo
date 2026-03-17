<cfset queryServicesPath = "../../../../services/receptionistServices/receptionistQueries.cfc"/>
<cfinvoke component=#queryServicesPath# method="getUserList" returnvariable="patientList">
    <cfinvokeargument name="role" value="Patient"/>
</cfinvoke>

<cfinvoke component=#queryServicesPath# method="getUserList" returnvariable="doctorList">
    <cfinvokeargument name="role" value="Doctor"/>
</cfinvoke>

<cfinvoke component="../../../../services/receptionistServices/receptionistQueries.cfc" method="getTimeSlots" returnvariable="timeSlotList">
</cfinvoke>

<div>
    <cfinclude template="../../../../includes/header.cfm"/>
    <cfinclude template="../../../../includes/toast.cfm"/>
    <div class="toast-container position-fixed top-0 end-0" style="padding: 4rem 1rem;">
        <div class="toast p-2" id="toast" role="alert" data-bs-delay="4000">
            <div class="toast-body">
                <div class="d-flex flex-column flex-grow-1 gap-2">
                    <div class="d-flex align-items-center">
                        <span id="alertMsg" class="fw-semibold text-white"></span>
                        <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="toast"></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <form class=" d-flex flex-column align-items-center gap-4 needs-validation" method="POST" novalidate>
        <div>
            <h3 class="text-primary">Schedule an appointment</h3>
        </div>
        <div class="d-flex flex-column gap-3" style="width: 50%;">
            <div class="d-flex justify-content-between gap-5">
                <div class="form-check p-0 w-50">
                    <label class="form-label fw-semibold">Doctor:</label>
                    <select id="doctor" class="form-control d-block form-select" name="doctor_id" required>
                        <option value="">Select Doctor</option>
                        <cfoutput query=#doctorList#>
                            <option value=#doctorList.user_id#>#doctorList.first_name#  #doctorList.last_name# - #doctorList.department_name#</option>
                        </cfoutput>
                    </select>
                    <div class="invalid-feedback">
                        Please select a doctor.
                    </div>
                </div>
                <div class="form-check p-0 w-50">
                    <label class="form-label fw-semibold">Patient:</label>
                    <select id="patient" class="form-control form-select" name="patient_id" required>
                        <option value="">Select Patient</option>
                        <cfoutput query=#patientList#>
                            <option value=#patientList.user_id#>#patientList.first_name#  #patientList.last_name#</option>
                        </cfoutput>
                    </select>
                    <div class="invalid-feedback">
                        Please select a patient.
                    </div>
                </div>
            </div>
            <div class="d-flex justify-content-between gap-5">
                <div class="form-check p-0 w-50">
                    <label class="form-label fw-semibold">Appointment Charges:</label>
                    <input name="appointment_charges" class="form-control" placeholder="Appointment Charges" id="appointment_charges" type="number" min="0" required/>
                    <div class="invalid-feedback">
                        Please enter appointment charges.
                    </div>
                </div>

                 <div class="form-check p-0 w-50">
                    <label class="form-label fw-semibold">Time Slots:</label>
                    <select required id="timeSlots" class="form-control form-select w-100" name="timeslot_id">
                        <option value="">Select Time Slot</option>
                        <cfoutput query=#timeSlotList#>
                            <option value=#timeSlotList.timeslot_id#>#timeFormat(timeSlotList.start_time, 'HH:mm')# - #timeFormat(timeSlotList.end_time, 'HH:mm')# </option>
                        </cfoutput>
                    </select>
                    <div class="invalid-feedback">
                        Please select a time slot.
                    </div>
                </div>
            </div>
            
            <div class="form-check p-0" style="width: 45%">
                <label class="form-label fw-semibold">Slot Date:</label>
                <input required class="form-control w-100" placeholder="Date" name="slot_date" type="text" id="my_date_picker">
                <div class="invalid-feedback">
                    Please select a date.
                </div>
            </div>
            <button name="book-btn" type="submit" class="btn btn-primary mx-auto" style="width: fit-content;">Book Appointment</button>
        </div>
    </form>
</div>

<script>

    const formEle = document.querySelector('.needs-validation')
    formEle.addEventListener('submit', (e)=>{
        if(!formEle.checkValidity()){
            e.preventDefault();
        }
        formEle.classList.add('was-validated');
    })
    
    $(document).ready(function () {
        $(function () {
            $("#my_date_picker").
            datepicker({
                dateFormat: "dd/mm/yy"
            });
        });
    }) 
</script>


<script>
    const alertEle = document.getElementById('alertMsg');
    const toastEle = document.getElementById("toast");
</script>

<cfif structKeyExists(form, "book-btn")>
    <cfset form.status = "Booked"/>
    <cfset form.slot_date = dateFormat(parseDateTime(form.slot_date, "dd/mm/yyyy"), "yyyy-mm-dd")>
    <cfinvoke component=#queryServicesPath# method="isDoctorAvailable" returnvariable="isAvailable">
        <cfinvokeargument name="appointmentDetails" value=#form#/>
    </cfinvoke>

    <cfif isAvailable EQ false>
        <script>
            showToast('The selected date and time slot are not available for this doctor. Please choose another slot.', 'warning');
        </script>
        <cfabort/>
    </cfif>

    <cfinvoke component=#queryServicesPath# method="insertAppointment" returnvariable="success">
        <cfinvokeargument name="appointmentDetails" value=#form#/>
    </cfinvoke>


    <cfif success EQ true>
        <script>
            showToast('Appointment Book Successfully.', 'success');
        </script>
    <cfelse>
        <script>
            showToast('Appointment booking failed. Please try again.', 'danger');
        </script>
    </cfif>

</cfif>