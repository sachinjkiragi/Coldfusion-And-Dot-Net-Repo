<cfquery name="getTable">
    SELECT * FROM Person;
</cfquery>
<cf_header>
<cfoutput>
    <div class="d-flex flex-column gap-5 justify-content-center align-items-center">
        <h1 class="mt-3">Home</h1>
        Number of active sessions On this application = #application.sessions#
        <table class="table table-bordered w-50">
            <thead class="table-light">
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Age</th>
                </tr>
            </thead>
            <tbody>
                
                <cfloop query=#getTable#>
                    <tr>
                        <td>#name#</td>    
                        <td>#email#</td>    
                        <td>#phone#</td>    
                        <td>#age#</td>    
                    </tr>
                </cfloop>
            </tbody>
        </table>
        
    </div>
</cfoutput>
<cf_footer>