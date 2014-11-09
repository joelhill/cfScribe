<cfparam name="url.oauth_token" default="" />
<cfparam name="url.oauth_verifier" default="" />

<cfif isDefined("url.auth")>
		<!--- Create our session to store the required keys for this user --->
		<cfset session.user = {}>
		<!--- Create our cfScribe object --->
		<cfset session.cfscribe = createObject("component", "cfScribe").twitterInit(force_login=false)>
		<!--- Create our twitter object --->
		<cfset session.cfTwitterAPI = createObject("component", "cfTwitterAPI").init(cfScribeObject=session.cfscribe)>
        <cfif !isDefined("session.user.requestToken")>
            <cfset session.user.requestToken = session.cfscribe.getRequestToken()>
        </cfif>
		<cflocation url="#session.cfscribe.getAuthorizationUrl(session.user.requestToken)#" addtoken="false">
</cfif>

<cfif len(url.oauth_token) AND len(url.oauth_verifier)>
	<cfset session.user.verifier = session.cfscribe.getVerifier(url.oauth_verifier)>
	<cfset session.user.accessToken = session.cfscribe.getAccessToken(verifier=session.user.verifier,requestToken=session.user.requestToken)>
	<cflocation url="successTwitter.cfm" addtoken="false" />
</cfif>

<html lang="en">
    <head>
        <title>cfScribe</title>
        <meta name="keywords" content="" />
		<meta name="description" content="" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="shortcut icon" href="images/favicon.ico"> -->
        <!-- Fonts -->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
        
        <!-- Stylesheets -->
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>

	<body class="bg-black">

        <div class="form-box" id="login-box">
            <div class="header">cfScribe Examples</div>

            <div class="body bg-gray processing">
            	<p>Processing...</p>
           		<i class="fa fa-spinner fa-spin"></i>
            </div>

            <div class="margin">
                <span><a href="/">home</a></span>
                <br/>
            </div>
        </div>

        <!-- javascripts -->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/script.js"></script>   

    </body>
</html>