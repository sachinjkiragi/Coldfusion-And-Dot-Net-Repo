<cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="getAvailableTimeSlots" returnvariable="availableSlots"/>

<html>
    <cfinclude template = "../../../../includes/header.cfm"/>
    <div class="h-100 w-100 border border-black d-flex justify-content-center align-items-center">
        <form class="p-5" method="POST">
            <div class="bordr-black d-flex flex-column gap-3 align-items-center">
                <div>
                    <h2 class="text-primary">Add Time Slot</h2>
                </div>

                <div class="d-flex gap-4">
                    <div class="form-check d-flex flex-column gap-4 align-items-center">
                        <div>
                            <select class="form-select" name="availableTimeSlotId">
                                <cfoutput query="#availableSlots#">
                                    <option value="#availableSlots.slot_id#">#timeFormat(availableSlots.start_time, "hh:mm tt")# - #timeFormat(availableSlots.end_time, "hh:mm tt")#</option>
                                </cfoutput>
                            </select>
                        </div>
                        
                        <span title="Please complete all required fields">
                            <button class="btn btn-primary" type="submit" name="addBtn"> Add </button>
                        </span>
                        <a href="home.cfm?reqPage=timeSlots" class="text-decoration-none">Go Back</a>
                    </div>
            </div>
        </form>
    </div>

</html>

<cfif structKeyExists(form, "addbtn")>
    <cfinvoke component="../../../../services/adminServices/adminQueries.cfc" method="addTimeSlot" returnvariable="success">
        <cfinvokeargument name="availableTimeSlotId" value="#form.availableTimeSlotId#"/>
    </cfinvoke>
    
    <cfif success EQ true>
        <script>
            alert('Time Slot added successfully');
        </script>
    <cfelse>
        <script>
            alert('Failed to add Time slot. Please try again.');
        </script>
    </cfif>
</cfif>
