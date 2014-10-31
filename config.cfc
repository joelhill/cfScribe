<cfcomponent>

	<!--- VARIABLES --->
    <cfset variables.instance = {}>
   

    <!--- INITIALISATION --->
	<cffunction name="twitterInit" returntype="Any">
		<cfset variables.instance.consumerKey = "">
		<cfset variables.instance.consumerSecret = "">
		<cfset variables.instance.authKey = "">
		<cfset variables.instance.authSecret = "">
		<cfset variables.instance.scribePath = "#GetDirectoryFromPath(GetCurrentTemplatePath())#components/scribe-1.3.5.jar">
		<cfset variables.instance.commonsCodecPath = "#GetDirectoryFromPath(GetCurrentTemplatePath())#components/commons-codec-1.5.jar">
		<cfset variables.instance.httpCorePath = "#GetDirectoryFromPath(GetCurrentTemplatePath())#components/httpcore-4.3.2.jar">
		<cfset variables.instance.httpMimePath = "#GetDirectoryFromPath(GetCurrentTemplatePath())#components/httpmime-4.3.5.jar">

		<cfset variables.instance.callback = "http://cfscribe.local/index.cfm">
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

	<cffunction name="getHttpCorePath" access="public" returntype="String" hint="absolute path to the httpcore jar">		
		<cfreturn variables.instance.httpCorePath>
	</cffunction>

	<cffunction name="getHttpMimePath" access="public" returntype="String" hint="absolute path to the httpmime jar">		
		<cfreturn variables.instance.httpMimePath>
	</cffunction>
	
	<cffunction name="getCallback" access="public" returntype="String" hint="call back url from api">		
		<cfreturn variables.instance.callback>
	</cffunction>
	
	


</cfcomponent>
