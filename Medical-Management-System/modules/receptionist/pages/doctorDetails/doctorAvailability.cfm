<div class="px-5">
    <form class="py-3 d-flex flex-column gap-4" method="POST">
        <div class="form-check d-flex gap-4 p-0 ">
            <input required class="form-control w-25" placeholder="Date" name="slot_date" type="text" id="my_date_picker">
            <button name="check-btn" type="submit" class="btn btn-primary" style="width: fit-content;">Check Availability</button>
        </div>
    </form>
    
    <cfif structKeyExists(form, "check-btn")>
        <cfset success = true/>
        <cftry>
            <cfinvoke component="../../../../services/receptionistServices/receptionistQueries.cfc" method="getDoctorsAvailability" returnvariable="availabilityList">
                <cfinvokeargument name="doctor_id" value="#doctor_id#"/>
                <cfinvokeargument name="slot_date" value="#form.slot_date#"/>
            </cfinvoke>
            
            <table id="availabilityList"  class="display ml-5">
                <thead>
                    <tr>
                        <th>Start Time</th>
                        <th>End Time</th>
                    </tr>
                </thead>
                <tbody>
                    <cfoutput query=#availabilityList#>
                        <tr style="width: 10rem;">
                            <td>#timeFormat(availabilityList.start_time, "hh:mm tt")#</td>
                            <td>#timeFormat(availabilityList.end_time, "hh:mm tt")#</td>
                        </tr> 

                    </cfoutput>
                </tbody>
            </table>
            
            <cfcatch>
                <cfset success EQ false/>
            </cfcatch>
        </cftry>
        
        
    </cfif>
    
    </div>
    <script>
    $(document).ready(function () {
        $(function () {
            $("#my_date_picker").
            datepicker();
        });
    }) 

    $(document).ready(function(){
        $('table#availabilityList').DataTable({
            pageLength: 5,
            lengthMenu: [5, 10, 25],
            autoWidth: false,
        });
    })
</script>
