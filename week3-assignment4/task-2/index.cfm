<html>
    <head>
        <title>CFInclude - Demo</title>
        <link rel="stylesheet" type="text/css" href="styles/style.css"/>
    </head>
    <body>
        <main class="main-container">
            <h1>CFInclude - Demo</h1>
            <br/>
            <br/>
            <form method="POST" action="home.cfm">
                <div>
                    <label for="country">Choose Country: </label>
                    <select name="country">
                        <option value="India">India</option>
                        <option value="USA">USA</option>
                        <option value="China">China</option>
                        <option value="other">Other</option>
                    </select>
                </div>
                <div>
                    <label for="age">Enter Age: </label>
                    <input name="age" type="number" required min="0" max="150"/>
                </div>
                <button type="submit">Submit</button>
            </form>
        </main>
    </body>
</html>