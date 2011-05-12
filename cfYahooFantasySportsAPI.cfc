<cfcomponent output="false" extends="cfScribe">
	
	<!--- VARIABLES --->
    <cfset variables.instance = {}>
    

    <!--- INITIALISATION --->
	<cffunction name="init" returntype="Any">
		<cfargument name="cfScribeObject" required="true">
		<cfset variables.instance.cfScribeObject = arguments.cfScribeObject>
		<cfreturn this />
	</cffunction>
	
	
	<!--- YAHOO FANTASY SPORTS API SPECIFIC FUNCTIONS --->
	<cffunction name="getUserGames" output="false" access="public" returntype="String" 
		hint="Fetch the Games in which the user has played. Additionally accepts flags is_available to only return available games.">
			<cfargument name="accessToken" required="true">
			<cfset var local = {}>
			<cfset local.request = variables.instance.cfScribeObject.setRequest("http://fantasysports.yahooapis.com/fantasy/v2/users;use_login=1/games")>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=arguments.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>
	
	<cffunction name="getUserGamesLeagues" output="false" access="public" returntype="String" 
		hint="Fetch leagues that the user belongs to in one or more games. The leagues will be scoped to the user. This will throw an error if any of the specified games do not support league sub-resources.">
			<cfargument name="accessToken" required="true">
			<cfargument name="gameKeys" required="true" hint="Game Keys found here: http://developer.yahoo.com/fantasysports/guide/game-resource.html">
			<cfset var local = {}>
			<cfset local.request = variables.instance.cfScribeObject.setRequest("http://fantasysports.yahooapis.com/fantasy/v2/users;use_login=1/games;game_keys=#arguments.gameKeys#/leagues")>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=arguments.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>
	
</cfcomponent>


