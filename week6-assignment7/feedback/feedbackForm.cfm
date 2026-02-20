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
                    <form method="POST" action="sendMail.cfm" class="d-flex flex-column gap-4 justify-content-center align-items-start">
                        <h2 class="text-primary">Provide Your Feedback.</h2>
                        <div class="form-group">
                            <label class="note note-dark text-secondary" for="email">Email</label> 
                            <input type="email" class="form-control" name="email" id="email" required/>    
                        </div>
                        <div class="form-group">
                            <label class="note note-dark text-secondary" for="content">Feed Back</label>
                            <textarea name="feedback" id="feedback" class="form-control" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary" name="submit-btn">Submit</button>
                        <a class="mx-auto btn btn-primary" href="../index.cfm">Go Back</a>
                    </form>
                </div>
            </div>
        </body>
    </cfoutput>
</html>
