<cftry>
    <cfinvoke component="../../../../services/patientServices/patientQueries.cfc" method="getAppointmentList" returnvariable="appointmentList">
        <cfinvokeargument name="patientId" value="#session.currUser.user_id#"/>
    </cfinvoke>
    <style>
        #appointmentList td, #appointmentList th {
            white-space: normal;
            word-break: break-word;
            vertical-align: middle;
            text-align: center;
            padding: 0.75rem 0.5rem;
        }

        #appointmentList tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }

        #appointmentList tbody tr:hover {
            background-color: #f2f2f2;
        }

        #appointmentList thead {
            background-color: #0d6efd;
            color: white;
            font-weight: 600;
        }

        #appointmentList .btn {
            min-width: 80px;
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        #appointmentList {
            border-collapse: collapse;
            width: 100%;
        }

        #appointmentList, #appointmentList th, #appointmentList td {
            border: 1px solid #dee2e6;
        }

        div.dataTables_wrapper div.dataTables_length,
        div.dataTables_wrapper div.dataTables_filter {
            margin-bottom: 1rem;
            margin-top: 0.5rem;
        }

        div.dataTables_wrapper div.dataTables_paginate {
            margin-top: 1rem;
        }

        div.dataTables_wrapper div.dataTables_filter {
            float: right;
        }

        div.dataTables_wrapper div.dataTables_length {
            float: left;
        }
    </style>
    
    <form method="POST" class="p-5">
        <table id="appointmentList"  class="display">
            <thead>
                <tr>
                    <th>Patient Name</th>
                    <th>Appointment Charges</th>
                    <th>Slot date</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Status</th>
                    <th class="no-sort">Prescription</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#appointmentList#>
                    <tr style="width: 10rem;">
                        <td>#appointmentList.doctor_name#</td>
                        <td> #appointmentList.appointment_charges#</td>
                        <td>#dateFormat(appointmentList.slot_date, "dd-mm-yyyy")#</td>
                        <td>#timeFormat(appointmentList.start_time, "hh:mm tt")#</td>
                        <td>#timeFormat(appointmentList.end_time, "hh:mm tt")#</td>
                        <td>#appointmentList.status#</td>
                        <td>
                            <cfif appointmentList.status EQ "Booked">
                                <button disabled class="btn btn-primary">NA&nbsp;&nbsp;&nbsp;</button>
                            <cfelseif appointmentList.status EQ "Completed">
                                <button name="btnView" value="#appointmentList.appointment_id#" class="btn btn-primary">View</button>
                            <cfelse>
                                <button disabled value="#appointmentList.appointment_id#" class="btn btn-primary">NA</button>
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
            columnDefs: [
                {orderable: false, targets: 'no-sort'}
            ]
        });
    })
</script>


<cfif structKeyExists(form, "btnView")>
    <cflocation url="home.cfm?reqPage=viewPrescription&appointment_id=#form.btnView#"/>
</cfif>
