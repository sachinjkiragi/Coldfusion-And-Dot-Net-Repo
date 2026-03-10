<cftry>
    <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getAppointmentList" returnvariable="appointmentList">
    </cfinvoke>
    <style>
        #appointmentList {
            width: 100%;
            table-layout: fixed;
        }
        #appointmentList td {
    white-space: normal;
    word-break: break-word;
}
    </style>
    
    <form method="POST" class="py-3 px-5 d-flex flex-column gap-4">
        <a href="home.cfm?reqPage=addAppointment" class="btn btn-primary" style="width: 10rem;">Add Appointment</a>
        <table id="appointmentList"  class="display">
            <thead>
                <tr>
                    <th>Doctor Name</th>
                    <th>Patient Name</th>
                    <th>Appointment Charges</th>
                    <th>Slot date</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Status</th>
                    <th>Update</th>
                    <th>View/Add Prescription</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#appointmentList#>
                    <tr style="width: 10rem;">
                        <td>#appointmentList.doctor_name#</td>
                        <td>#appointmentList.patient_name#</td>
                        <td> #appointmentList.appointment_charges#</td>
                        <td>#dateFormat(appointmentList.slot_date, "dd-mm-yyyy")#</td>
                        <td>#timeFormat(appointmentList.start_time, "hh:mm tt")#</td>
                        <td>#timeFormat(appointmentList.end_time, "hh:mm tt")#</td>
                        <td>#appointmentList.status#</td>
                        <td>
                            <button class="btn btn-primary" name="updateAppointmentId" value=#appointmentList.appointment_id# type="submit">Update</button>
                        </td>
                        <td>
                            <cfif appointmentList.status EQ "Cancelled">
                                <button disabled class="btn btn-primary">NA&nbsp;&nbsp;&nbsp;</button>
                            <cfelseif appointmentList.status EQ "Booked">
                                <button name="btnAdd" value="#appointmentList.appointment_id#" class="btn btn-primary">Add</button>
                            <cfelse>
                                <button name="btnView" value="#appointmentList.appointment_id#" class="btn btn-primary">View</button>
                            </cfif>
                        </td>

                    </tr>
                </cfoutput>
            </tbody>
        </table>
    </form>
        
        <cfcatch>
            <cfoutput>#cfcatch#</cfoutput>
        </cfcatch>
</cftry>

<script>
    $(document).ready(function(){
        $('table#appointmentList').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
        });
    })
</script>


<cfif structKeyExists(form, "btnAdd")>
    <cflocation url="home.cfm?reqPage=addPrescription&appointment_id=#form.btnAdd#"/>
    <cfelseif structKeyExists(form, "btnView")>
        <cflocation url="home.cfm?reqPage=viewPrescription&appointment_id=#form.btnView#"/>
    <cfelseif structKeyExists(form, "btnViewPatientIdHistory")>
        <cflocation url="home.cfm?reqPage=patientHistory&patientId=#form.btnViewPatientIdHistory#"/>
</cfif>

<cfif structKeyExists(form, "updateAppointmentId")>
    <cfdump var=#form#/>
    <cfdump var=#form.updateAppointmentId#/>
    <cflocation url="home.cfm?reqPage=updateAppointment&appointmentId=#form.updateAppointmentId#"/>
</cfif>