<cfcomponent output="false">
	<!--- Application name, should be unique --->
	<cfset this.name = "ParlayStats">
	<!--- How long application vars persist --->
	<cfset this.applicationTimeout = createTimeSpan(0,2,0,0)>
	<!--- Should client vars be enabled? (PROBLEM) --->
	<cfset this.clientManagement = true>
	<!--- Where should we store them, if enable? --->
	<cfset this.clientStorage = "registry">
	<!--- Where should cflogin stuff persist  (PROBLEM) --->
	<cfset this.loginStorage = "session">
	<!--- Should we even use sessions? --->
	<cfset this.sessionManagement = true>
	<!--- How long do session vars persist? --->
	<cfset this.sessionTimeout = createTimeSpan(0,0,60,0)>
	<!--- Should we set cookies on the browser? --->
	<cfset this.setClientCookies = true>
	<!--- should cookies be domain specific, ie, *.foo.com or www.foo.com --->
	<cfset this.setDomainCookies = false>
	<!--- should we try to block 'bad' input from users --->
	<cfset this.scriptProtect = "none">
	<!--- should we secure our JSON calls? --->
	<cfset this.secureJSON = false>
	<!--- Should we use a prefix in front of JSON strings? --->
	<cfset this.secureJSONPrefix = "">
	<!--- Used to help CF work with missing files and dir indexes --->
	<cfset this.welcomeFileList = "">
	<!--- define custom coldfusion mappings. Keys are mapping names, values are full paths ---> 
	<cfset this.mappings = structNew()>
	<cfset this.mappings["/root"] = getDirectoryFromPath(getCurrentTemplatePath())>
	<!--- define a list of custom tag paths. --->
	<cfset this.customtagpaths = "">
	<cfset this.customtagpaths=ListAppend(this.customtagpaths, "d:\home\yourwebsite.com\wwwroot\components")>
	
<!------------------------------------------------------------------------------------------->	

	
	<!--- Run when application starts up --->
	<cffunction name="onApplicationStart" returnType="boolean" output="false">
		<cfset var local = {}>
		<!--- Create our cfScribe object --->
		<cfset local.consumerKey = "yourBigLongConsumerKeyThatYahooWillGiveYou">
		<cfset local.consumerSecret = "youNotSoLongConsumerSecretThatYahooWillGiveYou">
		<cfset local.scribePath = "D:\home\yourwebsite.com\wwwroot\components\scribe-1.1.3.jar">
		<cfset local.commonsCodecPath = "D:\home\yourwebsite.com\wwwroot\components\commons-codec-1.5.jar">
		<cfset local.callback = "http://www.yourwebsite.com/index.cfm">
		<cfset application.cfscribe = createObject("component", "cfScribe").init(consumerKey=local.consumerKey,
																				 consumerSecret=local.consumerSecret,
																				 scribePath=local.scribePath,
																				 commonsCodecPath=local.commonsCodecPath,
																				 callback=local.callback)>
		<!--- Create our cfYahooFantasySportsAPI object --->
		<cfset application.cfYahooFantasySportsAPI = createObject("component", "cfYahooFantasySportsAPI").init(cfScribeObject=application.cfscribe)>
		
		<cfreturn true>
	</cffunction>
	
	
<!------------------------------------------------------------------------------------------->	
	

	<!--- Run when application stops --->
	<cffunction name="onApplicationEnd" returnType="void" output="false">
		<cfargument name="applicationScope" required="true">
	</cffunction>
	

<!------------------------------------------------------------------------------------------->	
	

	<!--- Fired when user requests a CFM that doesn't exist. --->
	<cffunction name="onMissingTemplate" returnType="boolean" output="false">
		<cfargument name="targetpage" required="true" type="string">
			<cflocation url="#application.base_url#missing_template.cfm" addtoken="false">
		<cfreturn true>
	</cffunction>
	
	
<!------------------------------------------------------------------------------------------->	

	
	<!--- Run before the request is processed --->
	<cffunction name="onRequestStart" returnType="boolean" output="false">
		<cfargument name="thePage" type="string" required="true">
		
		<!--- Check for initialization. --->
		<cfif StructKeyExists( URL, "reset" )>
 
			<!--- Reset application and session. --->
			<cfset THIS.OnApplicationStart() />
			<cfset THIS.OnSessionStart() />
 
		</cfif>		
		<cfreturn true>
	</cffunction>


<!------------------------------------------------------------------------------------------->	


	<!--- Runs at end of request --->
	<cffunction name="onRequestEnd" returnType="void" output="false">
		<cfargument name="thePage" type="string" required="true">
	</cffunction>


<!------------------------------------------------------------------------------------------->	


	<!--- Runs on error --->
	<cffunction name="onError" returnType="void" output="false">
		<cfargument name="exception" required="true">
		<cfargument name="eventname" type="string" required="true">
			<cfdump var="#arguments#" label="error scope">
	        <cfdump var="#cgi#" label="cgi scope">
	        <cfdump var="#form#" label="form scope">
	        <cfdump var="#url#" label="url scope">
	        <cfabort>
	</cffunction>

<!------------------------------------------------------------------------------------------->	
	
	<!--- Runs when your session starts --->
	<cffunction name="onSessionStart" returnType="void" output="false">
 		<cfset session.user = {}>
	</cffunction>


<!------------------------------------------------------------------------------------------->	


	<!--- Runs when session ends --->
	<cffunction name="onSessionEnd" returnType="void" output="false">
		<cfargument name="sessionScope" type="struct" required="true">
		<cfargument name="appScope" type="struct" required="false">
	</cffunction>


<!------------------------------------------------------------------------------------------->	
	
</cfcomponent>