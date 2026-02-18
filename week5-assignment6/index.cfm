<html>
    <head>
        <Title>Assignment - 6</Title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    </head>
    <body>
        <div class="container d-flex flex-column gap-2 align-items-center justify-content-center min-vh-100 ">
            <h3 class="text-primary font-weight-bold">Assignment - 6 (UDF's & Components Demo) </h3>
            <form style="width: 24rem" method="POST" class="was-validated border border-black px-5 pt-2 pb-4 rounded">
                <div class="mb-3 mt-3">
                    <label for="name" class="form-label">Name:</label>
                    <input type="text" class="form-control" id="name" placeholder="Enter name" name="name" required>
                    <div id="name-error-msg" class="invalid-feedback">Please fill out this field.</div>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email:</label>
                    <input type="email" class="form-control" id="email" placeholder="Enter email" name="email" required>
                    <div class="invalid-feedback">Please fill out this field.</div>
                </div>
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone:</label>
                    <input type="text" class="form-control" id="phone" placeholder="Enter Phone No." name="phone" required>
                    <div id="phone-error-msg" class="invalid-feedback">Please fill out this field.</div>
                </div>
                <div class="mb-3">
                    <label for="age" class="form-label">Age:</label>
                    <input type="number" class="form-control" id="age" placeholder="Enter age" name="age" required>
                    <div id="age-error-msg" class="invalid-feedback">Please fill out this field.</div>
                </div>
                <button type="submit" name="submit-btn" class="btn btn-primary">Submit</button>
            </form>
        </div>
    </body>

    <cfif structKeyExists(form, "submit-btn")>
        <cfset validatorObj = createObject("component", "ValidateServices")/>
        <cfset error = validatorObj.isUserDetailsValid(form)/>
        <cfif isEmpty(error)>
             <cflocation url="pages/home.cfm" addtoken="false"/>
        <cfelse>
            <script>
                var nameErrorDiv = document.getElementById('name-error-msg');
                var phoneErrorDiv = document.getElementById('phone-error-msg');
                var ageErrorDiv = document.getElementById('age-error-msg');
                <cfif structKeyExists(error, "name")>
                    nameErrorDiv.innerHTML = "<p>Please enter a valid name starting with atleast 1 letter and spaces only (up to 20 characters)</p>";
                </cfif>
                <cfif structKeyExists(error, "phone")>
                    phoneErrorDiv.innerHTML = "<p>Please enter a valid 10-digit phone number.</p>";
                </cfif>
                <cfif structKeyExists(error, "age")>
                    ageErrorDiv.innerHTML = "<p>Please enter a valid age between 18 and 150.</p>";
                </cfif>
            </script>
        </cfif>
    </cfif>
</html>
