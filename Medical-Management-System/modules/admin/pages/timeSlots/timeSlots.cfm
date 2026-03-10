<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getTimeSlots" returnvariable="timeSlotList"/>

<cftry>
    <style>
        #timeSlotList {
            width: 100%;
            table-layout: fixed;
        }
        #timeSlotList td {
    white-space: normal;
    word-break: break-word;
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
                            <button class="btn btn-danger" name="deleteTimeSlotId" value=#timeSlotList.timeslot_id# type="submit">Delete</button>
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