<cfset country = form.country/>
<cfset age = form.age/>

<head>
    <link rel="stylesheet" type="text/css" href="styles/style.css"/>
</head>

<main class="main-container">
    <cfswitch expression=#country#>
        <cfcase value="India">
            <cfif age GTE 18>
                <cfinclude template="pages/india_pages/adults_page.cfm"/>
            <cfelse>
                <cfinclude template="pages/india_pages/kids_page.cfm"/>
            </cfif>
        </cfcase>
        <cfcase value="USA">
            <cfif age GTE 18>
                <cfinclude template="pages/usa_pages/adults_page.cfm"/>
            <cfelse>
                <cfinclude template="pages/usa_pages/kids_page.cfm"/>
            </cfif>
        </cfcase>
        <cfcase value="China">
            <cfif age GTE 18>
                <cfinclude template="pages/china_pages/adults_page.cfm"/>
            <cfelse>
                <cfinclude template="pages/china_pages/kids_page.cfm"/>
            </cfif>
        </cfcase>
        <cfdefaultcase>
            <cfif age GTE 18>
                <cfinclude template="pages/default_pages/default_adults.cfm"/>
            <cfelse>
                <cfinclude template="pages/default_pages/default_kids.cfm"/>
            </cfif>
        </cfdefaultcase>
    </cfswitch>

    <a href="index.cfm">Go Back </a>
</main>
