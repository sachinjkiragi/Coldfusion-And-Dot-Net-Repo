<cfset applicationStop()/>
<html>
    <head>
        <title>App End</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container d-flex flex-column gap-2 align-items-center justify-content-center min-vh-100">
            <h3>Application Ended.</h3>
            <a href="restartApp.cfm">Restart Application</a>
        </div>
    </body>
</html>