<cfcomponent>

	<!--- VARIABLES --->
    <cfset variables.instance = {}>
   

    <!--- INITIALISATION --->
	<cffunction name="init" returntype="Any">
		<cfset variables.instance.consumerKey = "bigLongConsumerKeyGivenToYouByYahoo">
		<cfset variables.instance.consumerSecret = "notSoLongConsumerSecretGivenToYouByYahoo">
		<cfset variables.instance.authKey = "">
		<cfset variables.instance.authSecret = "">
		<cfset variables.instance.scribePath = "D:\home\yoursite.com\wwwroot\components\scribe-1.1.3.jar">
		<cfset variables.instance.commonsCodecPath = "D:\home\yoursite.com\wwwroot\components\commons-codec-1.5.jar">
		<cfset variables.instance.callback = "http://www.yoursite.com/index.cfm">
		<cfreturn this />
	</cffunction>
	
	
	<cffunction name="getConsumerKey" access="public" returntype="String">		
		<cfreturn variables.instance.consumerKey>
	</cffunction>

	<cffunction name="getConsumerSecret" access="public" returntype="String">		
		<cfreturn variables.instance.consumerSecret>
	</cffunction>
	
	<cffunction name="getAuthKey" access="public" returntype="String">		
		<cfreturn variables.instance.authKey>
	</cffunction>

	<cffunction name="getAuthSecret" access="public" returntype="String">		
		<cfreturn variables.instance.authSecret>
	</cffunction>

	<cffunction name="getScribePath" access="public" returntype="String" hint="absolute path to the scribe jar">		
		<cfreturn variables.instance.scribePath>
	</cffunction>
	
	<cffunction name="getCommonsCodecPath" access="public" returntype="String" hint="absolute path to the commons-codec jar">		
		<cfreturn variables.instance.commonsCodecPath>
	</cffunction>
	
	<cffunction name="getCallback" access="public" returntype="String" hint="call back url from api">		
		<cfreturn variables.instance.callback>
	</cffunction>
	
	


</cfcomponent>