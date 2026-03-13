<html>
    <cfinclude template="includes/header.cfm"/>

    <body class="d-flex flex-column min-vh-100">

        <nav class="d-flex align-items-center justify-content-between px-4 py-3 text-white"
            style="background: linear-gradient(90deg, #0d6efd, #0dcaf0);">
            <h3 class="m-0">MedManage</h3>
            <strong>
                <a href="../../logout/logout.cfm" class="text-white text-decoration-none">Logout</a>
            </strong>
        </nav>

        <div class="flex-grow-1 d-flex justify-content-center align-items-center">
            <div class="text-center">
                <h1 class="text-danger">Access Denied</h1>
                <p class="fs-4">Oops! You don't have permission to perform this action.</p>

                <a href="login/login.cfm" class="btn btn-primary mt-3">
                    Go back to login
                </a>
            </div>
        </div>

        <cfinclude template="includes/footer.cfm"/>

    </body>
</html>