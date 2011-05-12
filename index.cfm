<cfparam name="url.oauth_token" default="" />
<cfparam name="url.oauth_verifier" default="" />

<cfif isdefined("form.btnSubmit")>
		<!--- Create our session to store the required keys for this user --->
		<cfset session.user = {}>
		<!--- Create our cfScribe object --->
		<cfset session.cfscribe = createObject("component", "cfScribe").init()>
		<!--- Create our cfYahooFantasySportsAPI object --->
		<cfset session.cfYahooFantasySportsAPI = createObject("component", "cfYahooFantasySportsAPI").init(cfScribeObject=session.cfscribe)>
		<cflocation url="#session.cfscribe.getAuthorizationUrl(session.cfscribe.getRequestToken())#" addtoken="false">
</cfif>

<cfif len(url.oauth_token) AND len(url.oauth_verifier)>
	<cfset session.user.verifier = session.cfscribe.getVerifier(url.oauth_verifier)>
	<cfset session.user.accessToken = session.cfscribe.getAccessToken(session.user.verifier)>
	<cfset session.user.getUserGames = session.cfYahooFantasySportsAPI.getUserGames(accessToken=session.user.accessToken)>
	<cflocation url="yahooSuccess.cfm" addtoken="false" />
</cfif>


<html>
	<body id="page1">
		<cfoutput>
		<div id="main">
			<cfform action="#CGI.SCRIPT_NAME#" name="frmYahoo">
				<cfinput type="submit" name="btnSubmit" value="Sign in with Yahoo">
			</cfform>
		</div>
		</cfoutput>
	</body>
</html>