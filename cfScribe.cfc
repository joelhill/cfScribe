<cfcomponent output="false">

	<!--- VARIABLES --->
    <cfset variables.instance = {}>
   

    <!--- INITIALISATION --->
	<cffunction name="init" returntype="Any">
		<cfargument name="consumerKey" required="true">
		<cfargument name="consumerSecret" required="true">
		<cfargument name="authKey" type="string" required="false" default="">
		<cfargument name="authSecret" type="string" required="false" default="">
		<cfargument name="scribePath" type="string" hint="absolute path to the scribe jar" default="">
		<cfargument name="commonsCodecPath" type="string" hint="absolute path to the commons-codec jar" default="">
		<cfargument name="callback" required="false" hint="call back url from api" default="">
        
		<cfset var local = {}>
		<cfset var paths = []>
		<cfset variables.instance.consumerKey = arguments.consumerKey>
		<cfset variables.instance.consumerSecret = arguments.consumerSecret>
		<cfset variables.instance.authKey = arguments.authKey>
		<cfset variables.instance.authSecret = arguments.authSecret>
		
		<cfset paths[1] = arguments.scribePath>
		<cfset paths[2] = arguments.commonsCodecPath>
		<cfset variables.instance.javaloader = createObject("component", "components.javaloader.JavaLoader").init(paths)>
		<cfset variables.instance.YahooApi = variables.instance.javaloader.create("org.scribe.builder.api.YahooApi")>
		<cfset variables.instance.verb = variables.instance.javaloader.create("org.scribe.model.Verb")>
		<cfset variables.instance.scribeService = variables.instance.javaloader.create("org.scribe.builder.ServiceBuilder").init()
									   			  .provider(variables.instance.YahooApi.getClass())
									   			  .apiKey(variables.instance.consumerKey)
									   			  .apiSecret(variables.instance.consumerSecret)
									   			  .callback(arguments.callback)
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
		<cfset var local = {}>
		<cfset local.javaloader =  variables.instance.javaloader>
		<cfset local.setRequest = local.javaloader.create("org.scribe.model.OAuthRequest").init(variables.instance.verb.get,arguments.URI)>
		<cfreturn local.setRequest /> 
	</cffunction>
	
	<cffunction name="setSignRequest" output="false" access="public" returntype="String">
		<cfargument name="accessToken" required="true">
		<cfargument name="request" required="true">
		<cfreturn variables.instance.scribeService.signRequest(arguments.accessToken,arguments.request) />
	</cffunction>
	
</cfcomponent>


