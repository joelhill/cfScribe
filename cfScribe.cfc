<cfcomponent output="false">

	<!--- VARIABLES --->
    <cfset variables.instance = {}>
   

    <!--- INITIALISATION --->
	<cffunction name="init" returntype="Any">
		<cfset var local = {}>
		<cfset local.config = createObject("component", "config").init()>
		<cfset local.paths = []>
		<cfset local.paths[1] = local.config.getScribePath()>
		<cfset local.paths[2] = local.config.getCommonsCodecPath()>
		<cfset variables.instance.javaloader = createObject("component", "components.javaloader.JavaLoader").init(local.paths)>
		<cfset variables.instance.TwitterApi = variables.instance.javaloader.create("org.scribe.builder.api.TwitterApi")>
        <cfset variables.instance.YahooApi = variables.instance.javaloader.create("org.scribe.builder.api.YahooApi")>
		<cfset variables.instance.verb = variables.instance.javaloader.create("org.scribe.model.Verb")>
		<cfset variables.instance.scribeService = variables.instance..javaloader.create("org.scribe.builder.ServiceBuilder").init()
									   			  .provider(variables.instance.YahooApi.getClass())
									   			  .apiKey(local.config.getConsumerKey())
									   			  .apiSecret(local.config.getConsumerSecret())
									   			  .callback(local.config.getCallback())
									   			  .build()>
		<cfreturn this />
	</cffunction>


    <!--- GETTER FUNCTIONS---> 
	<cffunction name="getRequestToken" output="false" access="public" returntype="String">
		<cfif !isDefined("session.user.getRequestToken")>
			<cfset session.user.getRequestToken = variables.instance.scribeService.getRequestToken()>
		</cfif>	
		<cfreturn session.user.getRequestToken />
	</cffunction>
	
	<cffunction name="getAuthorizationUrl" output="false" access="public" returntype="any">
		<cfargument name="requestToken" required="true">
		<cfreturn variables.instance.scribeService.getAuthorizationUrl(arguments.requestToken) />
	</cffunction>
	
	<cffunction name="getVerifier" output="false" access="public" returntype="String">
		<cfargument name="oAuthVerifier" required="true">
		<cfreturn variables.instance.javaloader.create("org.scribe.model.Verifier").init(arguments.oAuthVerifier) />
	</cffunction>
	
	<cffunction name="getAccessToken" output="false" access="public" returntype="String">
		<cfargument name="verifier" required="true">
		<cfreturn variables.instance.scribeService.getAccessToken(getRequestToken(),arguments.verifier) />
	</cffunction>
	
	<!--- SETTER FUNCTIONS---> 
	<cffunction name="setRequest" output="false" access="public" returntype="String">
		<cfargument name="URI" required="true">
		<cfreturn variables.instance.javaloader.create("org.scribe.model.OAuthRequest").init(variables.instance.verb.get,arguments.URI) /> 
	</cffunction>
	
	<cffunction name="setSignRequest" output="false" access="public" returntype="String">
		<cfargument name="accessToken" required="true">
		<cfargument name="request" required="true">
		<cfreturn variables.instance.scribeService.signRequest(arguments.accessToken,arguments.request) />
	</cffunction>
	
</cfcomponent>


