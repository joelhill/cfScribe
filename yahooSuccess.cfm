<cfif isdefined("form.btnSubmit")>
	<cfset session.user.getUserGamesLeagues = session.cfYahooFantasySportsAPI.getUserGamesLeagues(accessToken=session.user.accessToken,
																		   		  				  gameKeys="253")>
	<cfdump var="#session.user.getUserGamesLeagues.getBody()#"><cfabort>
</cfif>

<html>
	<body id="page1">
		<cfoutput>
		<div id="main">
			SuccessFully logged In
			<cfform action="#CGI.SCRIPT_NAME#" name="frmYahooGet">
				<cfinput type="submit" name="btnSubmit" value="Get More Data from Yahoo">
				<br />
				<cfdump var="#session.user.getUserGames.getBody()#">	
			</cfform>
		</div>
		</cfoutput>
	</body>
</html>