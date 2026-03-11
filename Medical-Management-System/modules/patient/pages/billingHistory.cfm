<cfinvoke component="../../../services/patientServices/patientQueries.cfc" method="getBillingHistory" returnvariable="billingHistory">
    <cfinvokeargument name="patientId" value="#session.currUser.user_id#"/>
</cfinvoke>

<style>
        #billingHistory {
            width: 100%;
            table-layout: fixed;
        }
        #billingHistory td {
            white-space: normal;
            word-break: break-word;
        }
    </style>
    
    <form method="POST" class="p-5">
        <h4 class="text-primary mb-4">Billing History - <cfoutput>#session.currUser.first_name#</cfoutput></h4>
        <table id="billingHistory"  class="display">
            <thead>
                <tr>
                   <th>Doctor Name</th>
                    <th>Slot Date</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Medicine Name</th>
                    <th>Diagnosis</th>
                    <th>Quantity</th>
                    <th>Unit Price</th>
                    <th>Appoint- ment Charges</th>
                    <th>Total Bill</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#billingHistory#>
                    <tr style="width: 10rem;">
                        <td>#billingHistory.doctor_name#</td>
                        <td>#dateFormat(billingHistory.slot_date, "dd-mm-yyyy")#</td>
                        <td>#timeFormat(billingHistory.start_time, "hh:mm tt")#</td>
                        <td>#timeFormat(billingHistory.end_time, "hh:mm tt")#</td>
                        <td>#billingHistory.medicine_name#</td>
                        <td>#billingHistory.diagnosis#</td>
                        <td>#billingHistory.quantity#</td>
                        <td>#billingHistory.unit_price#</td>
                        <td>#billingHistory.appointment_charges#</td>
                        <td>#billingHistory.total_bill#</td>
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
        $('table#billingHistory').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
        });
    })
</script>
