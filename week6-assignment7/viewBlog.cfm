<cfset success = true/>

<cftry>
    <cfset filePath = expandPath('./categories/') & url.category & "/" & url.blog/>
    <cffile action="read" file="#filePath#/content.txt" variable="content"/>
    <cfcatch>
        <cfset success = false/>
        <cflog file="local blog" type="error" text=#cfcatch.message#/>
    </cfcatch>
</cftry>

<html>
    <head>
        <title>Local Blog</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

        <style>
            img{
                height: 22rem;
                width: 30rem;
            }
        </style>
    </head>

    <cfoutput>
        <body>
            <div class="m-3 d-flex justify-content-center align-items-center">
                <div class="border rounded p-5 gap-4 w-75 d-flex flex-column justify-content-center align-items-center">

                    <cfif success EQ true>
                        <h2 class="text-primary">#url.category# > #url.blog#</h2>
                        <img class="border border-black p-2" src="categories/#url.category#/#url.blog#/image.jpg"/>
                        <strong class="note note-dark text-secondary mb-0"> #content# </strong>
                    <cfelse>
                        <p class="text-danger">The Blog You Are Trying To Access Does Not Contain Any Content</p>
                    </cfif>

                    <a class="btn btn-primary" href="viewCategory.cfm?category=#url.category#&blog=#url.blog#">Go Back</a>
                </div>
            </div>

        </body>
    </cfoutput>

</html>
