<cfset success = true/>

<cftry>
    <cfdirectory action="list" name="categories" directory=#expandPath('./categories/#url.category#')#/>
<cfcatch>
    <cfset success = false/>
</cfcatch>
</cftry>

<html>
    <head>
        <title>Local Blog</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
       <style>
            td, th{
                text-align: center;
            }
       </style>
    </head>
    <body>
        <div class="h-100 d-flex justify-content-center align-items-center">
            <div class=" d-flex flex-column justify-content-center align-items-center gap-4">
                <h1 class="text-primary">Local Blog</h1>
                <cfif success EQ true>

                    <cfoutput>
                        <h3 class="text-secondary">#url.category# Category</h3>
                        <a class="btn btn-primary" href="createBlog/createBlog.cfm?category=#url.category#">Create New Blog</a>
                    </cfoutput>
                    
                    <table class="table table-bordered border-dark table-hover">
                        <tr>
                            <th>Category</th>
                            <th>View Blog</th>
                            <th>Delete Blog</th>
                        </tr>
                        <cfoutput query=#categories#>
                            <tr>
                                <td>#name#</td>
                                <td><a class="btn btn-primary" href="viewBlog.cfm?category=#url.category#&blog=#categories.name#">View</a></td>
                                <td><a class="btn btn-danger" href="deleteBlog/deleteBlog.cfm?category=#url.category#&blog=#categories.name#">Delete</a></td>
                            </tr>
                        </cfoutput>
                    </table>
                <cfelse>
                     <p class="text-danger">Error Occurred While Fetching The Categories</p>
                </cfif>
                 <a class="btn btn-primary" href="index.cfm">Go Back</a>
            </div>
        </div>
    </body>
</html>