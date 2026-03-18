<cfinvoke component="../../../../services/doctorServices/doctorQueries.cfc" method="getPatientHistory" returnvariable="patientHistory">
    <cfinvokeargument name="patientId" value="#patientId#"/>
</cfinvoke>
<cfif patientHistory.recordCount EQ 0>
    <cflocation url="home.cfm?reqPage=Appointments"/>
</cfif>

<style>
        #patientHistory {
            width: 100%;
            table-layout: fixed;
        }
        #patientHistory td {
            white-space: normal;
            word-break: break-word;
        }
    </style>
    
    <form method="POST" class="p-5">
        <h4 class="text-primary mb-4">Patient History - <cfoutput>#patientHistory.patient_name#</cfoutput></h4>
        <table id="patientHistory"  class="display">
            <thead>
                <tr>
                    <th>Doctor Name</th>
                    <th>Slot Date</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Medicine Name</th>
                    <th>Diagnosis</th>
                    <th>Diagnosis Notes</th>
                    <th>Dosage Info</th>
                    <th>Quantity</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#patientHistory#>
                    <tr style="width: 10rem;">
                        <td>#patientHistory.doctor_name#</td>
                        <td>#dateFormat(patientHistory.slot_date, "dd/mm/yyyy")#</td>
                        <td>#timeFormat(patientHistory.start_time, "hh:mm tt")#</td>
                        <td>#timeFormat(patientHistory.end_time, "hh:mm tt")#</td>
                        <td>#patientHistory.medicine_name#</td>
                        <td>#patientHistory.diagnosis#</td>
                        <td>#patientHistory.diagnosis_notes#</td>
                        <td>#patientHistory.dosage_info#</td>
                        <td>#patientHistory.quantity#</td>
                    </tr>
                </cfoutput>
            </tbody>
        </table>
        <div class="mx-auto" style="width: fit-content;">
            <a href="home.cfm?reqPage=appointments">Go Back</a>
        </div>
    </form>

<script>
    $(document).ready(function(){
        $('table#patientHistory').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
        });
    })
</script>