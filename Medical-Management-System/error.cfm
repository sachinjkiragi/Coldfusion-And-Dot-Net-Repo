<html>
    <cfinclude template="includes/header.cfm"/>

    <body class="d-flex flex-column min-vh-100">

        <nav class="d-flex align-items-center justify-content-between px-4 py-3 text-white"
            style="background: linear-gradient(90deg, #0d6efd, #0dcaf0);">
            <h3 class="m-0">MedManage</h3>
        </nav>

        <div class="flex-grow-1 d-flex justify-content-center align-items-center">
            <div class="text-center">

                <h1 class="text-danger">Unexpected Error</h1>

                <p class="fs-4">
                    Something went wrong while processing your request.
                </p>

                <p class="text-muted">
                    Please contact the system administrator if the problem persists.
                </p>

                <a href="/Coldfusion-And-Dot-Net-Repo/Medical-Management-System/login/login.cfm" 
                   class="btn btn-primary mt-3">
                    Go to Login
                </a>

            </div>
        </div>

        <cfinclude template="includes/footer.cfm"/>

    </body>
</html>