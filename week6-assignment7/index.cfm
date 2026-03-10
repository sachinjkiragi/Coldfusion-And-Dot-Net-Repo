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
        <a style="top: 1rem; right: 1rem;" class="btn btn-primary position-absolute" href="feedback/feedbackForm.cfm">Give Feedback</a>
        <div class="h-100 d-flex justify-content-center align-items-center">
            <div class=" d-flex flex-column justify-content-center align-items-center gap-4">
                <h1 class="text-primary">Local Blog</h1>
                <h4 class="text-secondary">Your Categories</h4>
                <cfoutput>
                    <a class="btn btn-primary" href="createCategory/createCategory.cfm">Create New Category</a>
                </cfoutput>
                <cfdirectory action="list" name="categories" directory=#expandPath('./categories')#/>
                <table style="width: 30rem;" class="table table-bordered border-dark table-hover">
                    <tr>
                        <th>Category</th>
                        <th>View Category</th>
                        <th>Delete Category</th>
                    </tr>
                    <cfoutput query=#categories#>
                        <tr>
                            <td>#name#</td>
                            <td><a class=" btn btn-primary" href="viewCategory.cfm?category=#name#">View</a></td>
                            <td><a class=" btn btn-danger" href="deleteCategory/deleteCategory.cfm?category=#name#">Delete</a></td>
                        </tr>
                    </cfoutput>
                </table>
            </div>
        </div>
    </body>
</html>