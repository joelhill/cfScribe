<cfparam name="url.oauth_token" default="" />
<cfparam name="url.oauth_verifier" default="" />

<cfif isdefined("form.btnSubmit")>
	<cflocation url="#application.cfscribe.getAuthorizationUrl(application.cfscribe.getRequestToken())#" addtoken="false">
</cfif>

<cfif len(url.oauth_token) AND len(url.oauth_verifier)>
	<cfset session.user.verifier = application.cfscribe.getVerifier(url.oauth_verifier)>
	<cfset session.user.accessToken = application.cfscribe.getAccessToken(session.user.verifier)>
	<cfset session.user.getUserGames = application.cfYahooFantasySportsAPI.getUserGames(accessToken=session.user.accessToken)>
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