<cfcomponent output="false" extends="cfScribe">
    
	<!--- VARIABLES --->
    <cfset variables.instance = {}>
    

    <!--- INITIALISATION --->
	<cffunction name="init" returntype="Any">
		<cfargument name="cfScribeObject" required="true">
		<cfset variables.instance.cfScribeObject = arguments.cfScribeObject>
		<cfreturn this />
	</cffunction>
	
	
	<!--- TWITTER API SPECIFIC FUNCTIONS --->
	<cffunction name="getVerifyCredentials" output="false" access="public" returntype="String" 
		hint="Returns an HTTP 200 OK response code and a representation of the requesting user if authentication was successful; returns a 401 status code and an error message if not. Use this method to test if supplied user credentials are valid.">
			<cfargument name="accessToken" required="true">
			<cfset var local = {}>
			<cfset local.request = variables.instance.cfScribeObject.setRequest("http://api.twitter.com/1/account/verify_credentials.json")>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=arguments.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>
	
</cfcomponent>


