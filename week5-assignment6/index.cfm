<html>
    <head>
        <Title>Assignment - 6</Title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    </head>
    <body>
        <div class = "d-flex flex-column border border-dark vh-100 justify-content-center align-items-center">
            <form method="POST" class="d-flex flex-column gap-3 border rounded border-black p-5">
                <h2 class = "text-primary">Enter Your Details: </h2>
                <div>
                    <label for="name">Name</label>
                    <input class="form-control text-secondary" type="text" name="name"/>
                </div>
                <div>
                    <label for="email">Email</label>
                    <input class="form-control text-primary" type="email" name="email"/>
                </div>
                <div>
                    <label for="Phone">Phone</label>
                    <input class="form-control text-primary" type="number" name="phone"/>
                </div>                
                <div>
                    <label for="Age">Age</label>
                    <input class="form-control text-primary" type="number" name="age" min="18"/>
                </div>
                <button class="btn btn-primary" type="submit" name="submit-btn">Submit</button>
                <cfif structKeyExists(form, "submit-btn")>
                    <cfset validatorObj = createObject("component", "ValidateServices")/>
                    <cfset error = validatorObj.isUserDetailsValid(form)/>
                    <cfif isEmpty(error)>
                        <cflocation url="pages/home.cfm" addtoken="false"/>
                    <cfelse>
                        <cfoutput>
                            <div>
                                <cfloop collection = #error# index="key">        
                                    <p class="text-danger">#error[key]#</p>
                                </cfloop>
                            </div>
                            </cfoutput>
                    </cfif>
                </cfif>
            </form>
        </div>
    </body>
</html>