<cfset success = true/>

<cftry>
    <cfset destPath = expandPath("../categories") & "/" & form.category & "/" & form.blogName>

    <cfdirectory action="create" directory=#destPath#/>
    <cffile action="upload" filefield="blogImage" destination=#destPath# result="res"/>
    <cffile action="rename" source=#destPath & "/" & res.serverFile# destination=#destPath & "/image.jpg"#/>
    <cffile action="write" file=#destPath & "/content.txt"# nameconflict="error" output=#form.content#/>
<cfcatch>
    <cfoutput>
        <cfset success = false/>
        <cflog file="local blog" text=#cfcatch.message# type="error"/>
    </cfoutput>
</cfcatch>
</cftry>

<html>
    <head>
        <title>Local Blog</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <link rel="stylesheet" href="styles.css">
    </head>

    <body>
        <div class="h-100 d-flex justify-content-center align-items-center ">
            <div class=" d-flex flex-column justify-content-center align-items-center">
                <cfoutput>
                    <cfif success EQ true>
                        <h2>Blog #form.blogName# Created Successufully Inside #form.category# category.</h2>
                    <cfelse>
                        <h2>Blog with name #form.blogName# Already exists in #form.category#, Please choose anothe name</h2>
                    </cfif>
                    <a class="btn btn-primary" href="createBlog.cfm?category=#form.category#">Go Back</a>
                </cfoutput>
            </div>
        </div>
    </body>
 </html>