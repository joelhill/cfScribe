<cfif isdefined("form.btnSubmit")>
	<cfset session.user.getUserGamesLeagues = application.cfYahooFantasySportsAPI.getUserGamesLeagues(accessToken=session.user.accessToken,
																		   		  					  gameKeys="253")>
	<cfdump var="#session.user.getUserGamesLeagues.getBody()#"><cfabort>
</cfif>

<html>
	<body id="page1">
		<cfoutput>
		<div id="main">
			SuccessFully logged In
			<cfform action="#CGI.SCRIPT_NAME#" name="frmYahooGet">
				<cfdump var="#session.user.getUserGames#">
				<cfinput type="submit" name="btnSubmit" value="Get Data from Yahoo">	
			</cfform>
		</div>
		</cfoutput>
	</body>
</html>