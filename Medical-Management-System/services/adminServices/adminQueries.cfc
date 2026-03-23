<cfcomponent>

    <cffunction name="getUserList" returntype="query">
        <cfargument name="role" type="string"/>
        <cfinvoke method="getUserList" component="../commonServices/commonServices.cfc" returnvariable="userList">
            <cfinvokeargument name="role" value="#arguments.role#"/>
        </cfinvoke>
        <cfreturn userList/>
    </cffunction>

    <cffunction name="updatePatientData" returntype="boolean">
        <cfargument name="patientData" type="struct"/>
        <cfinvoke method="updatePatientData" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="patientData" value="#arguments.patientData#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>

    <cffunction name="deletePatient" returntype="boolean">
        <cfargument name="patient_id" type="numeric"/>
        <cfset local.success = true/>
        <cfinvoke method="deletePatient" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="patient_id" value="#arguments.patient_id#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>


    <cffunction name="getDoctorData" returntype="query">
        <cfargument name="doctorId" type="numeric"/>
        <cfquery name="qryUserList">
            SELECT
                user_id, first_name, last_name, email, phone, department_id, gender, qualification
                FROM
                Users
                WHERE user_id = <cfqueryparam value=#arguments.doctorId# cfsqltype="cf_sql_varchar"/>
        </cfquery>
        <cfreturn qryUserList/>
    </cffunction>

    <cffunction name="getDepartments" returntype="query">
        <cfquery name="qryDepartments">
            SELECT* FROM Departments
        </cfquery>
        <cfreturn qryDepartments>
    </cffunction>

    
    <cffunction name="updateDoctorData" returntype="boolean">
        <cfargument name="doctorData" type="struct"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryUpdate">
                UPDATE Users
                 SET 
                    first_name = <cfqueryparam value="#arguments.doctorData.firstName#" cfsqltype="cf_sql_varchar"/>,
                    last_name  = <cfqueryparam value="#arguments.doctorData.lastName#" cfsqltype="cf_sql_varchar"/>,
                    qualification  = <cfqueryparam value="#arguments.doctorData.qualification#" cfsqltype="cf_sql_varchar"/>,
                    email = <cfqueryparam value="#arguments.doctorData.email#" cfsqltype="cf_sql_varchar"/>,
                    phone = <cfqueryparam value="#arguments.doctorData.phone#" cfsqltype="cf_sql_varchar"/>,
                    gender = <cfqueryparam value="#arguments.doctorData.gender#" cfsqltype="cf_sql_char"/>,
                    department_id = <cfqueryparam value="#arguments.doctorData.department_id#" cfsqltype="cf_sql_char"/>
                WHERE user_id = <cfqueryparam value="#arguments.doctorData.doctor_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
        <cfcatch>
            <cfset local.success = false/>
            <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
        </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>
    

    <cffunction name="deleteDoctor" returntype="boolean">
        <cfargument name="doctor_id" type="numeric"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryDeleteDoctor">
                DELETE FROM
                Appointments
                WHERE doctor_id = <cfqueryparam value="#doctor_id#" cfsqltype="cf_sql_varchar"/> ;
                DELETE FROM
                Users
                WHERE user_id = <cfqueryparam value="#doctor_id#" cfsqltype="cf_sql_varchar"/> 
            </cfquery>
            <cfcatch>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
                <cfset local.success = false/>
            </cfcatch>
        </cftry> 
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="doesMailExists" returntype="boolean">
        <cfargument name="email" required="true" type="string"/>
        <cfinvoke method="doesMailExists" component="../commonServices/commonServices.cfc" returnvariable="doesExists">
            <cfinvokeargument name="email" value="#arguments.email#"/>
        </cfinvoke>
        <cfreturn doesExists/>
    </cffunction>


    <cffunction name="updateReceptionistData" returntype="boolean">
        <cfargument name="receptionistData" type="struct"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryUpdate">
                UPDATE Users
                 SET 
                    first_name = <cfqueryparam value="#arguments.receptionistData.firstName#" cfsqltype="cf_sql_varchar"/>,
                    last_name  = <cfqueryparam value="#arguments.receptionistData.lastName#" cfsqltype="cf_sql_varchar"/>,
                    email = <cfqueryparam value="#arguments.receptionistData.email#" cfsqltype="cf_sql_varchar"/>,
                    phone = <cfqueryparam value="#arguments.receptionistData.phone#" cfsqltype="cf_sql_varchar"/>,
                    gender = <cfqueryparam value="#arguments.receptionistData.gender#" cfsqltype="cf_sql_char"/>,
                    department_id = <cfqueryparam value="#arguments.receptionistData.department_id#" cfsqltype="cf_sql_char"/>
                WHERE user_id = <cfqueryparam value="#arguments.receptionistData.receptionist_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
        <cfcatch>
            <cfset local.success = false/>
            <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
        </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>


        <cffunction name="deleteReceptionist" returntype="boolean">
        <cfargument name="receptionist_id" type="numeric"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryDeleteReceptionist">
                DELETE FROM
                Users
                WHERE user_id = <cfqueryparam value="#receptionist_id#" cfsqltype="cf_sql_varchar"/> 
            </cfquery>
            <cfcatch>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
                <cfset local.success = false/>
            </cfcatch>
        </cftry> 
        <cfreturn local.success/>
    </cffunction>


    <cffunction name="getAppointmentList" returntype="query">
        <cfinvoke method="getAppointmentList" component="../commonServices/commonServices.cfc" returnvariable="appointmentList">
        </cfinvoke>
        <cfreturn appointmentList/>
    </cffunction>

    <cffunction name="getAppointmentData" returntype="query">
        <cfargument name="appointment_id" type="numeric"/>
        <cfinvoke method="getAppointmentData" component="../commonServices/commonServices.cfc" returnvariable="appointmentData">
            <cfinvokeargument name="appointment_id" value="#arguments.appointment_id#"/>
        </cfinvoke>
        <cfreturn appointmentData/>
    </cffunction>
    

    <cffunction name="updateAppointmentData" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>
        
        <cfinvoke method="updateAppointmentData" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="appointmentDetails" value="#arguments.appointmentDetails#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>

    <cffunction name="insertPatientData" returntype="boolean">
        <cfargument name="patientData" type="struct"/>
        <cfinvoke method="insertPatientData" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="patientData" value="#arguments.patientData#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>

    <cffunction name="insertDoctorData" returntype="boolean">
        <cfargument name="doctorData" type="struct"/>
        <cfset local.success = true/>

        <cfset local.hashedPassword = hash(arguments.doctorData.password, "SHA-256")>

        <cftry>
            <cfquery name="qryInsert">
                INSERT INTO Users (first_name, last_name, qualification, email, phone, role_id, password, gender, department_id)
                VALUES (
                    <cfqueryparam value="#arguments.doctorData.firstName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.doctorData.lastName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.doctorData.qualification#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.doctorData.email#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.doctorData.phone#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.doctorData.role_id#" cfsqltype="cf_sql_integer"/>,
                    <cfqueryparam value="#local.hashedPassword#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.doctorData.gender#" cfsqltype="cf_sql_char"/>,
                    <cfqueryparam value="#arguments.doctorData.department_id#" cfsqltype="cf_sql_integer"/>
                )
            </cfquery>
        <cfcatch>
            <cfset local.success = false/>
            <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
        </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="insertReceptionistData" returntype="boolean">
        <cfargument name="receptionistData" type="struct"/>
        <cfset local.success = true/>

        <cfset local.hashedPassword = hash(arguments.receptionistData.password, "SHA-256")>

        <cftry>
            <cfquery name="qryInsert">
                INSERT INTO Users (first_name, last_name, email, phone, role_id, password, gender, department_id)
                VALUES (
                    <cfqueryparam value="#arguments.receptionistData.firstName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.receptionistData.lastName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.receptionistData.email#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.receptionistData.phone#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.receptionistData.role_id#" cfsqltype="cf_sql_integer"/>,
                    <cfqueryparam value="#local.hashedPassword#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.receptionistData.gender#" cfsqltype="cf_sql_char"/>,
                    <cfqueryparam value="#arguments.receptionistData.department_id#" cfsqltype="cf_sql_integer"/>
                )
            </cfquery>
        <cfcatch>
            <cfset local.success = false/>
            <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
        </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="insertAppointment" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>
        <cfinvoke method="insertAppointment" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="appointmentDetails" value="#arguments.appointmentDetails#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>

    <cffunction name="isDoctorAvailable" returntype="boolean">
        <cfargument name="appointmentDetails" type="struct"/>
                <cfinvoke method="isDoctorAvailable" component="../commonServices/commonServices.cfc" returnvariable="isAvailable">
            <cfinvokeargument name="appointmentDetails" value="#arguments.appointmentDetails#"/>
        </cfinvoke>
        <cfreturn isAvailable/>
    </cffunction>

    <cffunction name="getTimeSlots" returntype="query">
        <cfinvoke method="getTimeSlots" component="../commonServices/commonServices.cfc" returnvariable="timeSlots"/>
        <cfreturn timeSlots/>
    </cffunction>

    <cffunction name="doesPrescriptionExists" returntype="boolean">
        <cfargument name="appointment_id" type="numeric"/>
        <cfinvoke method="doesPrescriptionExists" component="../commonServices/commonServices.cfc" returnvariable="doesExists">
            <cfinvokeargument name="appointment_id" value="#arguments.appointment_id#"/>
        </cfinvoke>
        <cfreturn doesExists/>
    </cffunction>

    <cffunction name="addPrescription" returntype="boolean">
        <cfargument name="prescription_data" type="struct"/>
        <cfinvoke method="addPrescription" component="../commonServices/commonServices.cfc" returnvariable="success">
            <cfinvokeargument name="prescription_data" value="#arguments.prescription_data#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>


    <cffunction name="getPatientData" returntype="query">
        <cfargument name="patient_id" type="numeric"/>
        <cfinvoke method="getPatientData" component="../commonServices/commonServices.cfc" returnvariable="patientData">
            <cfinvokeargument name="patient_id" value="#arguments.patient_id#"/>
        </cfinvoke>
        <cfreturn patientData/>
    </cffunction>

    <cffunction name="getPrescriptionData" returntype="query">
        <cfargument name="appointment_id" type="numeric"/>
        <cfinvoke method="getPrescriptionData" component="../commonServices/commonServices.cfc"  returnvariable="prescriptionData">
            <cfinvokeargument name="appointment_id" value="#arguments.appointment_id#"/>
        </cfinvoke>
        <cfreturn prescriptionData/>
    </cffunction>

    <cffunction name="getPrescriptionDataByPrescriptionId" returntype="query">
        <cfargument name="prescription_id" type="numeric"/>
         <cfinvoke method="getPrescriptionDataByPrescriptionId" component="../commonServices/commonServices.cfc"  returnvariable="prescriptionData">
            <cfinvokeargument name="prescription_id" value="#arguments.prescription_id#"/>
        </cfinvoke>
        <cfreturn prescriptionData/>
    </cffunction>

    <cffunction name="updatePrescriptionData" returntype="boolean">
        <cfargument name="prescriptionData" type="struct"/>
        <cfinvoke method="updatePrescriptionData" component="../commonServices/commonServices.cfc"  returnvariable="success">
            <cfinvokeargument name="prescriptionData" value="#arguments.prescriptionData#"/>
        </cfinvoke>
        <cfreturn success/>
    </cffunction>

    <cffunction name="deletePrescription">
        <cfargument name="prescription_id" type="numeric"/>
        <cfargument name="appointment_id" type="numeric"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryDeletePrescription">
                DELETE FROM Prescriptions 
                WHERE prescription_id = <cfqueryparam value="#arguments.prescription_id#" cfsqltype="cf_sql_integer"/>

                UPDATE Appointments 
                SET status = 'Booked' 
                WHERE appointment_id = <cfqueryparam value="#arguments.appointment_id#" cfsqltype="cf_sql_integer"/>
            </cfquery>
        <cfcatch>
            <cfset local.success = false/>
            <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
        </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="getMedicines" returntype="query">
        <cfinvoke method="getMedicines" component="../commonServices/commonServices.cfc" returnvariable="medicineList"/>
        <cfreturn medicineList/>
    </cffunction>

    <cffunction name="addMedicine" returntype="boolean">
        <cfargument name="medicineData" type="struct"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryInsertMedicine">
                INSERT INTO Medicines (medicine_name, unit_price)
                VALUES(
                    <cfqueryparam value="#arguments.medicineData.medicineName#" cfsqltype="cf_sql_varchar"/>,
                    <cfqueryparam value="#arguments.medicineData.unitPrice#" cfsqltype="cf_sql_integer"/>
                )
            </cfquery>
            <cfcatch>
                <cfset local.success = true/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="medicineExists" returntype="boolean">
        <cfargument name="medicineName" type="string">
        <cfquery name="qryMedicineExists">
            SELECT 1 FROM Medicines
            WHERE medicine_name = <cfqueryparam value="#arguments.medicineName#" cfsqltype="cf_sql_varchar"/>
        </cfquery>
        <cfreturn qryMedicineExists.recordCount GT 0/>
    </cffunction>

    <cffunction name="getMedicineDataById" returntype="query">
        <cfargument name="medicineId" type="numeric">
        <cfquery name="qeyMedicineData">
            SELECT medicine_name, unit_price FROM Medicines
            WHERE medicine_id = <cfqueryparam value="#arguments.medicineId#" cfsqltype="cf_sql_integer"/>
        </cfquery>
        <cfreturn qeyMedicineData/>
    </cffunction>

    <cffunction name="updateMedicine" returntype="boolean">
        <cfargument name="medicineData" type="struct"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryUpdateMedicine">
                UPDATE  Medicines 
                SET
                medicine_name = <cfqueryparam value="#arguments.medicineData.medicineName#" cfsqltype="cf_sql_varchar"/>,
                unit_price =   <cfqueryparam value="#arguments.medicineData.unitPrice#" cfsqltype="cf_sql_integer"/>
                WHERE medicine_id = <cfqueryparam value="#arguments.medicineData.medicineId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset local.success = true/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="deleteMedicine" returntype="boolean">
        <cfargument name="medicineId" type="numeric"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryUpdateMedicine">
                DELETE FROM Medicines
                WHERE medicine_id = <cfqueryparam value="#arguments.medicineId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset local.success = true/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    
    <cffunction name="getAvailableTimeSlots">
        <cfquery name="qryAvailableTimeSlots">
            SELECT* FROM ALL_Slots
            WHERE start_time NOT IN (SELECT start_time FROM Time_Slots);
        </cfquery>
        <cfreturn qryAvailableTimeSlots/>
    </cffunction>

    <cffunction name="addTimeSlot" returntype="boolean">
        <cfargument name="availableTimeSlotId" type="numeric"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryInsertTimeSlot">
                INSERT INTO Time_Slots (start_time, end_time)
                VALUES(
                    (SELECT start_time FROM All_Slots WHERE slot_id = <cfqueryparam value="#arguments.availableTimeSlotId#" cfsqltype="cf_sql_integer"/>),
                    (SELECT end_time FROM All_Slots WHERE slot_id = <cfqueryparam value="#arguments.availableTimeSlotId#" cfsqltype="cf_sql_integer"/>)
                )
            </cfquery>
            <cfcatch>
                <cfset local.success = false/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="deleteTimeSlot" returntype="boolean">
        <cfargument name="timeSlotId" type="numeric">
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryDeleteTimeSlot">
                DELETE FROM Time_Slots
                WHERE timeslot_id = <cfqueryparam value="#timeSlotId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset local.success = false/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>


    <cffunction name="addDepartment" returntype="boolean">
        <cfargument name="departmentData" type="struct"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryInsertMedicine">
                INSERT INTO Departments (department_name)
                VALUES(
                    <cfqueryparam value="#arguments.departmentData.departmentName#" cfsqltype="cf_sql_varchar"/>
                )
            </cfquery>
            <cfcatch>
                <cfset local.success = false/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="departmentExists" returntype="boolean">
        <cfargument name="departmentName" type="string">
        <cfquery name="qryDepartmentExists">
            SELECT 1 FROM Departments
            WHERE department_name = <cfqueryparam value="#arguments.departmentName#" cfsqltype="cf_sql_varchar"/>
        </cfquery>
        <cfreturn qryDepartmentExists.recordCount GT 0/>
    </cffunction>

    <cffunction name="getDepartmentDataById" returntype="query">
        <cfargument name="departmentId" type="numeric">
        <cfquery name="qryDepartmentData">
            SELECT department_name FROM Departments
            WHERE department_id = <cfqueryparam value="#arguments.departmentId#" cfsqltype="cf_sql_integer"/>
        </cfquery>
        <cfreturn qryDepartmentData/>
    </cffunction>

    <cffunction name="updateDepartment" returntype="boolean">
        <cfargument name="departmentData" type="struct"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryUpdateDepartment">
                UPDATE  Departments 
                SET
                department_name = <cfqueryparam value="#arguments.departmentData.departmentName#" cfsqltype="cf_sql_varchar"/>
                WHERE department_id = <cfqueryparam value="#arguments.departmentData.departmentId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset local.success = false/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="deleteDepartment" returntype="boolean">
        <cfargument name="departmentId" type="numeric"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qeyDeleteDepartment">
                DELETE FROM Departments
                WHERE department_id = <cfqueryparam value="#arguments.departmentId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset local.success = false/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>


    
    <cffunction name="getRoles" returntype="query">
        <cfquery name="qryRoles">
            SELECT* FROM Roles;
        </cfquery>
        <cfreturn qryRoles/>
    </cffunction>

    <cffunction name="addRole" returntype="boolean">
        <cfargument name="roleData" type="struct"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryInsertMedicine">
                INSERT INTO Roles (role_name)
                VALUES(
                    <cfqueryparam value="#arguments.roleData.roleName#" cfsqltype="cf_sql_varchar"/>
                )
            </cfquery>
            <cfcatch>
                <cfset local.success = false/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="roleExists" returntype="boolean">
        <cfargument name="roleName" type="string">
        <cfquery name="qryRoleExists">
            SELECT 1 FROM Roles
            WHERE role_name = <cfqueryparam value="#arguments.roleName#" cfsqltype="cf_sql_varchar"/>
        </cfquery>
        <cfreturn qryRoleExists.recordCount GT 0/>
    </cffunction>

    <cffunction name="getRoleDataById" returntype="query">
        <cfargument name="roleId" type="numeric">
        <cfquery name="qryRoleData">
            SELECT role_name FROM Roles
            WHERE role_id = <cfqueryparam value="#arguments.roleId#" cfsqltype="cf_sql_integer"/>
        </cfquery>
        <cfreturn qryRoleData/>
    </cffunction>

    <cffunction name="updateRole" returntype="boolean">
        <cfargument name="roletData" type="struct"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qryUpdateRole">
                UPDATE Roles
                SET
                role_name = <cfqueryparam value="#arguments.roleData.roleName#" cfsqltype="cf_sql_varchar"/>
                WHERE role_id = <cfqueryparam value="#arguments.roleData.roleId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset local.success = false/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="deleteRole" returntype="boolean">
        <cfargument name="roleId" type="numeric"/>
        <cfset local.success = true/>
        <cftry>
            <cfquery name="qeyDeleteRole">
                DELETE FROM Roles
                WHERE role_id = <cfqueryparam value="#arguments.roleId#" cfsqltype="cf_sql_integer"/>
            </cfquery>
            <cfcatch>
                <cfset local.success = false/>
                <cflog file="medManageLogs" text="#cfcatch.message#" type="error">
            </cfcatch>
        </cftry>
        <cfreturn local.success/>
    </cffunction>

    <cffunction name="getReceptionistData" returntype="query">
        <cfargument name="receptionistId" type="numeric"/>
        <cfquery name="qryReceptionistData">
            SELECT
                user_id, first_name, last_name, email, phone, department_id, gender
                FROM
                Users
                WHERE user_id = <cfqueryparam value=#arguments.receptionistId# cfsqltype="cf_sql_varchar"/>
        </cfquery>
        <cfreturn qryReceptionistData/>
    </cffunction>
</cfcomponent>