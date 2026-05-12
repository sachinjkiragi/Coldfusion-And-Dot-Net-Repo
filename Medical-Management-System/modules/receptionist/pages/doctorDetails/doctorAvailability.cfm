 <cfinvoke component="../../../../services/receptionistServices/receptionistQueries.cfc" method="getDoctorName" returnvariable="doctorName">
    <cfinvokeargument name="doctor_id" value="#url.doctorId#"/>
</cfinvoke>
<div class="px-5">
    <form class="py-3 d-flex flex-column gap-4" method="POST">
        <div class="form-check d-flex flex-column gap-2 p-0 ">
           <div class="mb-3 fs-5">
            <span class="fw-semibold text-primary">Doctor:</span>
            <cfoutput>
                <span class="fw-bold">#doctorName.first_name# #doctorName.last_name#</span>
            </cfoutput>
        </div>
            <label class="form-label fw-semibold">Select Date:</label>
            <div class="d-flex gap-4">
                <cfoutput>
                    <input <cfif structKeyExists(form, "slot_date")>value="#form.slot_date#"</cfif> required class="form-control w-25" placeholder="Date" name="slot_date" type="text" id="my_date_picker">
                </cfoutput>
                <button name="check-btn" type="submit" class="btn btn-primary" style="width: fit-content;">Check Availability</button>
            </div>
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
            datepicker({
                dateFormat: "dd/mm/yy"
            });
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
