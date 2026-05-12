<cfinvoke component="../../../services/patientServices/patientQueries.cfc" method="getBillingHistory" returnvariable="billingHistory">
    <cfinvokeargument name="patientId" value="#session.currUser.user_id#"/>
</cfinvoke>

    <style>
        #billingHistory td, #billingHistory th {
            white-space: normal;
            word-break: break-word;
            vertical-align: middle;
            text-align: center;
            padding: 0.75rem 0.5rem;
        }

        #billingHistory tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }

        #billingHistory tbody tr:hover {
            background-color: #f2f2f2;
        }

        #billingHistory thead {
            background-color: #0d6efd;
            color: white;
            font-weight: 600;
        }

        #billingHistory .btn {
            min-width: 80px;
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        #billingHistory {
            border-collapse: collapse;
            width: 100%;
        }

        #billingHistory, #billingHistory th, #billingHistory td {
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
                        <td>#dateFormat(billingHistory.slot_date, "dd/mm/yyyy")#</td>
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
