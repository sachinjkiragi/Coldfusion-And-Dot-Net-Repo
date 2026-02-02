<html>
    <head>
        <title>Simple Calculator</title>
        <link rel="stylesheet" type="text/css" href="../../styles/style.css"/>
    </head>
    <body>
        <main class="main-container">
            <h1>Program to check whether a number is prime or not</h1>
            <br/>
            <br/>
            <form method="POST" action="calculate.cfm">
                <div>
                    <label for="value1">Enter Num1: </label>
                    <input name="value1" type="number" required value="12"/>
                </div>
                <div>
                    <label for="value2">Enter Num2: </label>
                    <input name="value2" type="number" value="5"/>
                </div>
                <div>
                    <input type="radio" value="+" name="operator"/>
                    <input type="radio" value="-" name="operator"/>
                    <input type="radio" value="*" name="operator"/>
                    <input type="radio" value="/" name="operator"/>
                    <br/>
                    <label for="add"> + </label> &nbsp;
                    <label for="substract"> - </label> &nbsp;
                    <label for="multiply"> x </label>  &nbsp;
                    <label for="divide"> / </label>  &nbsp;
                </div>
                
                <button type="submit">Submit</button>
                <a href="../../index.cfm">Go back</a>
            </form>
        </main>
    </body>
</html>