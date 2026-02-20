<html>
    <head>
        <title>Local Blog</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
        <style>
            textarea{
                min-width: 25rem;
            }
        </style>
    </head>
    <cfoutput>
        <body>
            <div class="m-5 d-flex justify-content-center align-items-center">
                <div class="border border-black rounded-4 p-5">
                    <form method="POST" action="processCreateCategory.cfm" class="d-flex flex-column gap-4 justify-content-center align-items-start">
                        <h2 class="text-primary">Create Category</h2>
                        <div class="form-group">
                            <label class="note note-dark text-secondary" for="category">Category Name</label> 
                            <input type="text" class="form-control" name="category" id="categoryblogName" required pattern="^{a-zA-Z0-9}$"/>    
                        </div>
                        <button type="submit" class="btn btn-primary" name="submit-btn">Create</button>
                        <a class="mx-auto btn btn-primary" href="../index.cfm?category">Go Back</a>
                    </form>
                </div>
            </div>
        </body>
    </cfoutput>
</html>
