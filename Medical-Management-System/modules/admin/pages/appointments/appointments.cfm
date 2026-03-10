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
    
    <form method="POST" class="p-5">
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

<cfif structKeyExists(form, "updateAppointmentId")>
    <cfdump var=#form#/>
    <cfdump var=#form.updateAppointmentId#/>
    <cflocation url="home.cfm?reqPage=updateAppointment&appointmentId=#form.updateAppointmentId#"/>
</cfif>
