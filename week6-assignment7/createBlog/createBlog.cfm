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
                    <form method="POST" action="processCreateBlog.cfm" enctype="multipart/form-data" class="d-flex flex-column gap-4 justify-content-center align-items-start">
                        <h2 class="text-primary">Create Blog Inside #url.category# Category</h2>
                        <input type="hidden" name="category" value=#url.category#>
                        <div class="form-group">
                            <label class="note note-dark text-secondary" for="blogName">Blog Name</label> 
                            <input type="text" class="form-control" name="blogName" id="blogName" required pattern="^{a-zA-Z0-9}$"/>    
                        </div>
                        <div class="form-group">
                            <label class="note note-dark text-secondary" for="blogImage">Blog Image</label> 
                            <input type="file" class="form-control" name="blogImage" id="blogImage" required/>
                        </div>
                        <div class="form-group">
                            <label class="note note-dark text-secondary" for="content">Blog Content</label>
                            <textarea name="content" id="content" class="form-control" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary" name="submit-btn">Create</button>
                        <a class="mx-auto btn btn-primary" href="../viewCategory.cfm?category=#url.category#">Go Back</a>
                    </form>
                </div>
            </div>
        </body>
    </cfoutput>
</html>
