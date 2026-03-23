<cfcomponent>

    <cffunction name="checkPermission" returntype="boolean">
        <cfargument name="permissionTag" type="string"/>
        <cfquery name="qryPermission">
            SELECT Roles.role_name, Permissions.permission_tag
            FROM Role_Permissions
            JOIN Roles ON Role_Permissions.role_id = Roles.role_id
            JOIN Permissions ON Role_Permissions.permission_id = Permissions.permission_id
            WHERE Roles.role_name = 'Receptionist'
            AND permission_tag = <cfqueryparam value="#arguments.permissionTag#" cfsqltype="cf_sql_varchar"/>
        </cfquery> 
        <cfreturn qryPermission.recordCount EQ 1/>
    </cffunction>

    <cffunction name="getUserList" returntype="query">
        <cfargument name="role" type="string"/>
        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Users"/>
        </cfinvoke>
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        <cfinvoke method="getUserList" component="../commonServices/commonServices.cfc" returnvariable="userList">
            <cfinvokeargument name="role" value="#arguments.role#"/>
        </cfinvoke>
        <cfreturn userList/>
    </cffunction>

    <cffunction name="doesMailExists" returntype="boolean">
        <cfargument name="email" required="true" type="string"/>
        <cfinvoke method="doesMailExists" component="../commonServices/commonServices.cfc" returnvariable="doesExists">
            <cfinvokeargument name="email" value="#arguments.email#"/>
        </cfinvoke>
        <cfreturn doesExists/>
    </cffunction>

    <cffunction name="insertPatientData" returntype="boolean">
        <cfargument name="patientData" type="struct"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Create_Users"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfinvoke method="insertPatientData" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="patientData" value="#arguments.patientData#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>

    <cffunction name="updatePatientData" returntype="boolean">
        <cfargument name="patientData" type="struct"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Update_Users"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfinvoke method="updatePatientData" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="patientData" value="#arguments.patientData#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>

    <cffunction name="getTimeSlots" returntype="query">
        <cfinvoke method="getTimeSlots" component="../commonServices/commonServices.cfc" returnvariable="timeSlots"/>
        <cfreturn timeSlots/>
    </cffunction>

    <cffunction name="insertAppointment" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>
        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Create_Appointments"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfinvoke method="insertAppointment" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="appointmentDetails" value="#arguments.appointmentDetails#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>

    <cffunction name="isDoctorAvailable" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Appointments"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        
        <cfinvoke method="isDoctorAvailable" component="../commonServices/commonServices.cfc" returnvariable="isAvailable">
            <cfinvokeargument name="appointmentDetails" value="#arguments.appointmentDetails#"/>
        </cfinvoke>
        <cfreturn isAvailable/>
    </cffunction>

    <cffunction name="getDoctorName" returntype="query">
        <cfargument name="doctor_id" type="numeric"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Users"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        
        <cfquery name="qryDoctorData">
            SELECT first_name, last_name
            FROM Users 
            WHERE user_id = <cfqueryparam value=#arguments.doctor_id# cfsqltype="cf_sql_integer"/>;
        </cfquery>
        <cfreturn qryDoctorData/>
    </cffunction>

    <cffunction name="getPatientData" returntype="query">
        <cfargument name="patient_id" type="numeric"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Users"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfinvoke method="getPatientData" component="../commonServices/commonServices.cfc" returnvariable="patientData">
            <cfinvokeargument name="patient_id" value="#arguments.patient_id#"/>
        </cfinvoke>

        <cfreturn patientData/>

    </cffunction>

    <cffunction name="deletePatient" returntype="boolean">
        <cfargument name="patient_id" type="numeric"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Delete_Users"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfinvoke method="deletePatient" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="patient_id" value="#arguments.patient_id#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>


    <cffunction name="getAppointmentList" returntype="query">

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Appointments"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfinvoke method="getAppointmentList" component="../commonServices/commonServices.cfc" returnvariable="appointmentList">
        </cfinvoke>
        <cfreturn appointmentList/>
    </cffunction>

    <cffunction name="getAppointmentData" returntype="query">
        <cfargument name="appointment_id" type="numeric"/>

        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Appointments"/>
        </cfinvoke>
        
        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>

        <cfinvoke method="getAppointmentData" component="../commonServices/commonServices.cfc" returnvariable="appointmentData">
            <cfinvokeargument name="appointment_id" value="#arguments.appointment_id#"/>
        </cfinvoke>
        <cfreturn appointmentData/>
    </cffunction>
    

    <cffunction name="updateAppointmentData" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>
        
        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="Update_Appointments"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        <cfset local.success = true/>
        
        <cfinvoke method="updateAppointmentData" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="appointmentDetails" value="#arguments.appointmentDetails#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>


    <cffunction name="getDoctorsAvailability" returntype="query">
        <cfargument name="doctor_id" type="string"/>
        <cfargument name="slot_date" type="string"/>
        <cfinvoke method="checkPermission" returnvariable="hasPermission">
            <cfinvokeargument name="permissionTag" value="View_Appointments"/>
        </cfinvoke>

        <cfif hasPermission EQ false>
            <cflocation url="../../noPermission.cfm"/>
        </cfif>
        <cfquery name="qryAvailabilityList">
            WITH cte AS(
                SELECT* 
                FROM Appointments
                WHERE Appointments.doctor_id = <cfqueryparam value="#doctor_id#" cfsqltype="cf_sql_integer"/> AND Appointments.slot_date = <cfqueryparam value="#form.slot_date#" cfsqltype="date"/>
                ),
                res AS(
                    SELECT Time_Slots.start_time, Time_Slots.end_time
                    FROM Time_Slots LEFT JOIN cte
                    ON Time_Slots.timeslot_id = cte.timeslot_id
                    WHERE cte.appointment_id IS NULL
                ) SELECT* FROM res;
        </cfquery>
        
        <cfreturn qryAvailabilityList/>
    </cffunction>
</cfcomponent>