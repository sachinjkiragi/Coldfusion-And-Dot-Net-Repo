<cfcomponent>
        <cffunction name="getAppointmentList" returntype="query">
            <cfargument name="doctor_id" type="numeric"/>
        <cfquery name="qryAppointmentList">

            SELECT Appointments.*,
            (SELECT CONCAT(first_name, ' ', last_name) FROM Users WHERE user_id = Appointments.patient_id) AS 'patient_name',
            (SELECT start_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'start_time',
            (SELECT end_time FROM Time_Slots WHERE timeslot_id = Appointments.timeslot_id) AS 'end_time'
            FROM Appointments 
            WHERE Appointments.doctor_id = <cfqueryparam value="#doctor_id#" cfsqltype="cf_sql_integer"/>;
        </cfquery>
        <cfreturn qryAppointmentList/>
    </cffunction>
</cfcomponent>