<html>
    <head>
        <Title>Assignment - 6</Title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">

    </head>
    <body>
        <div class="container d-flex flex-column align-items-center justify-content-center min-vh-100 ">
            <h3 class="text-primary font-weight-bold">Assignment - 6 (UDF's & Components Demo) </h3>
            <form style="width: 30rem; height: 80vh;" method="POST" class="mt-4 border border-black px-5 py-2 rounded d-flex flex-column align-items-left justify-content-evenly">
                <div id="name-div">
                    <label for="name" class="form-label">Name:</label> 
                    <input class="w-100 p-1" type="text" id="name" placeholder="Enter name" name="name" required>
                </div>
                <div>
                    <label for="email" class="form-label">Email:</label> <br/>
                    <input class="w-100 py-1" type="email" id="email" placeholder="Enter email" name="email" required>
                </div>
                <div id="phone-div">
                    <label for="phone" class="form-label">Phone:</label> <br/>
                    <input class="w-100 py-1" type="text" id="phone" placeholder="Enter Phone No." name="phone" required>
                </div>
                <div id="age-div">
                    <label for="age" class="form-label">Age:</label> <br/>
                    <input class="w-100 py-1" type="number" id="age" placeholder="Enter age between 18 to 150" name="age" required>
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
                var nameDiv = document.getElementById('name-div');
                var phoneDiv = document.getElementById('phone-div');
                var ageDiv = document.getElementById('age-div');
                var nameInput = document.getElementById('name');
                var phoneInput = document.getElementById('phone');
                var ageInput = document.getElementById('age');
                <cfif structKeyExists(error, "name")>
                    nameInput.classList.add('border');
                    nameInput.classList.add('border-danger');
                    nameDiv.innerHTML += "<p class='text-danger mb-0'>Please enter valid name. It must start with letter and contain only letters and spaces (upto 20 characters)</p>";
                </cfif>
                <cfif structKeyExists(error, "phone")>
                    phoneInput.classList.add('border');
                    phoneInput.classList.add('border-danger');
                    phoneDiv.innerHTML += "<p class='text-danger mb-0'>Please enter a valid 10-digit phone number.</p>";
                </cfif>
                <cfif structKeyExists(error, "age")>
                    ageInput.classList.add('border');
                    ageInput.classList.add('border-danger');
                    ageDiv.innerHTML += "<p class='text-danger mb-0'>Please enter a valid age between 18 and 150.</p>";
                </cfif>
            </script>
        </cfif>
    </cfif>
</html>

