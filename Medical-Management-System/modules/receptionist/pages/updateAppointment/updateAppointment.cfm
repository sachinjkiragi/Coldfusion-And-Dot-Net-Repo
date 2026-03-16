<cfset queryServicesPath = "../../../../services/receptionistServices/receptionistQueries.cfc"/>

<cfinvoke method="getAppointmentData" component="#queryServicesPath#" returnvariable="appointementData">
    <cfinvokeargument name="appointment_id" value=#appointmentIdToUpdate#/>
</cfinvoke>
<cfinvoke component="#queryServicesPath#" method="getTimeSlots" returnvariable="timeSlotList">
</cfinvoke>

<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <cfinclude template = "../../../../includes/toast.cfm"/>
    <cfoutput>
        <div>
            <form class="p-3 d-flex flex-column align-items-center gap-4" method="POST">
                <div>
                    <h3 class="text-primary">Update an appointment</h3>
                </div>
                <div class="d-flex flex-column gap-3" style="width: 50%;">
                    <div class="d-flex justify-content-between">
                        <div class="form-check">
                            <label class="form-label fw-semibold">Doctor:</label>
                            <input class="form-control" type="text" name="doctor_name" id="doctor" readonly value="#appointementData.doctor_name#"/>
                        </div>
                        <div class="form-check">
                            <label class="form-label fw-semibold">Patient:</label>
                            <input  class="form-control" type="text" name="patient_name" id="patient" readonly value="#appointementData.patient_name#"/>
                        </div>
                    </div>
                    <div class="d-flex justify-content-between">
                        <div class="form-check">
                            <label class="form-label fw-semibold">Appointment Charges:</label>
                            <input required name="appointment_charges" class="form-control" placeholder="Appointment Charges" id="appointment_charges" type="number" min="0" required value="#appointementData.appointment_charges#"/>
                        </div>

                        <div class="form-check">
                            <label class="form-label fw-semibold">Slot Time:</label>
                            <select required id="timeSlots" class="form-control form-select" name="timeslot_id" style="width: fit-content">
                                <option value="">Select Time Slot</option>
                                <cfoutput query=#timeSlotList#>
                                    <cfif timeSlotList.timeslot_id EQ appointementData.timeslot_id>
                                        <option selected value=#timeSlotList.timeslot_id#>#timeFormat(timeSlotList.start_time, 'HH:mm')# - #timeFormat(timeSlotList.end_time, 'HH:mm')# </option>
                                    <cfelse>
                                        <option value=#timeSlotList.timeslot_id#>#timeFormat(timeSlotList.start_time, 'HH:mm')# - #timeFormat(timeSlotList.end_time, 'HH:mm')# </option>
                                    </cfif>
                                </cfoutput>
                            </select>
                        </div>
                    </div>
                    
                    <div class="d-flex justify-content-between">
                        
                        <div class="form-check">
                            <label class="form-label fw-semibold">Status:</label>
                            <select required class="form-control form-select"  name="status">
                                <cfif appointementData.status EQ "Booked">
                                    <option value="Booked" selected>Booked</option>
                                    <option value="Cancelled">Cancel</option>
                                    <option value="Completed">Completed</option>
                                <cfelseif appointementData.status EQ "Cancelled">
                                    <option value="Booked">Book</option>
                                    <option value="Cancelled" selected>Cancelled</option>
                                    <option value="Completed">Completed</option>
                                <cfelse>
                                    <option value="Booked">Book</option>
                                    <option value="Cancelled">Cancelled</option>
                                    <option value="Completed" selected>Completed</option>
                                </cfif>
                            </select>
                        </div>
                        <div class="form-check">
                            <label class="form-label fw-semibold">Slot Date:</label>
                            <input required value="#dateFormat(appointementData.slot_date, "dd/mm/yyyy")#" class="form-control" placeholder="Date" name="slot_date" type="text" id="my_date_picker">
                        </div>
                    </div>
                    <button name="update-btn" type="submit" class="btn btn-primary mx-auto" style="width: fit-content;">Update Appointment</button>
                    <a href="home.cfm?reqPage=appointments" class="text-decoration-none mx-auto">Go Back</a>
                </div>
            </form>
        </div>
    </cfoutput>
</html>


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

<cfif structKeyExists(form, "update-btn")>
    <cfset form.doctor_id = appointementData.doctor_id/>
    <cfset form.patient_id = appointementData.patient_id/>
    <cfset form.appointment_id = appointementData.appointment_id/>
    
    <cfif form.status EQ "Booked">
        <cfinvoke component=#queryServicesPath# method="isDoctorAvailable" returnvariable="isAvailable">
            <cfinvokeargument name="appointmentDetails" value=#form#/>
        </cfinvoke>
        
        <cfif isAvailable EQ false>
            <script>
                showToast('The selected date and time slot are not available for this doctor. Please choose another slot.', 'warning');
            </script>
            <cfabort/>
        </cfif>
    </cfif>

    <cfinvoke component=#queryServicesPath# method="updateAppointmentData" returnvariable="success">
        <cfinvokeargument name="appointmentDetails" value=#form#/>
    </cfinvoke>


    <cfif success EQ true>
        <script>
            showToast('Appointment details have been updated successfully.', 'success');
        </script>
    <cfelse>
        <script>
            showToast('Unable to update appointment. Please try again later.', 'warning');
        </script>
    </cfif>

</cfif>