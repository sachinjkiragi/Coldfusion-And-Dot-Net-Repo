<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getTimeSlots" returnvariable="timeSlotList"/>

<cftry>
    <style>
        #timeSlotList td, #timeSlotList th {
            white-space: normal;
            word-break: break-word;
            vertical-align: middle;
            text-align: center;
            padding: 0.75rem 0.5rem;
        }

        #timeSlotList tbody tr:nth-child(odd) {
            background-color: #f9f9f9;
        }

        #timeSlotList tbody tr:hover {
            background-color: #f2f2f2;
        }

        #timeSlotList thead {
            background-color: #0d6efd;
            color: white;
            font-weight: 600;
        }

        #timeSlotList .btn {
            min-width: 80px;
            padding: 0.25rem 0.5rem;
            font-size: 0.875rem;
        }

        #timeSlotList {
            border-collapse: collapse;
            width: 100%;
        }

        #timeSlotList, #timeSlotList th, #timeSlotList td {
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
    
    <form method="POST" class="py-3 px-5 d-flex flex-column gap-4">
        <a href="home.cfm?reqPage=addTimeSlot" class="btn btn-primary" style="width: 8rem;">Add Time Slot</a>
        <table id="timeSlotList"  class="display">
            <thead>
                <tr>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query=#timeSlotList#>
                    <tr style="width: 10rem;">
                        <td>#timeFormat(timeSlotList.start_time, "hh:mm tt")#</td>
                        <td>#timeFormat(timeSlotList.end_time, "hh:mm tt")#</td>
                        <td>
                            <button onclick="return confirm('Are you sure you want to delete this patient record?');" class="btn btn-danger" name="deleteTimeSlotId" value=#timeSlotList.timeslot_id# type="submit">Delete</button>
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
        $('table#timeSlotList').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
        });
    })
</script>

<cfif structKeyExists(form, "deleteTimeSlotId")>
    <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="deleteTimeSlot" returnvariable="success">
        <cfinvokeargument name="timeSlotId" value="#form.deleteTimeSlotId#"/>
    </cfinvoke>

    <cfif success EQ true>
        <script>
            alert("Time slot deleted successfully.");
        </script>
    <cfelse>
        <script>
            alert("Failed to delete time slot. Please try again.");
        </script>
</cfif>

</cfif>