<cfcomponent output="false" extends="cfScribe">
    
	<!--- VARIABLES --->
    <cfset variables.instance = {}>
    

    <!--- INITIALISATION --->
	<cffunction name="init" returntype="Any">
		<cfargument name="cfScribeObject" required="true">
		<cfset variables.instance.cfScribeObject = arguments.cfScribeObject>
		<cfreturn this />
	</cffunction>
	
	
	<!--- TWITTER ACCOUNT FUNCTIONS --->
	<cffunction name="getVerifyCredentials" output="false" access="public" returntype="string" 
		hint="Tests to see if an access token is valid.">
			<cfargument name="accessToken" required="true">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/account/verify_credentials.json",method=local.method)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=arguments.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getAccountSettings" output="false" access="public" returntype="String" 
		hint="Returns settings (including current trend, geo and sleep time information) for the authenticating user.">
			<cfargument name="accessToken" required="true">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/account/settings.json",method=local.method)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=arguments.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postAccountSettings" output="false" access="public" returntype="String" 
		hint="Retrieves the authenticating users account settings">
			<cfargument name="accessToken" required="true">
			<cfargument name="trend_location_woeid" required="false" hint="The Yahoo! Where On Earth ID to use as the user’s default trend location. Global information is available by using 1 as the WOEID">
			<cfargument name="sleep_time_enabled" required="false" hint="When set to true, t or 1, will enable sleep time for the user. Sleep time is the time when push or SMS notifications should not be sent to the user.">
			<cfargument name="start_sleep_time" required="false" hint="The hour that sleep time should begin if it is enabled. The value for this parameter should be provided in ISO8601 format (i.e. 00-23). The time is considered to be in the same timezone as the user’s time_zone setting.">
			<cfargument name="end_sleep_time" required="false" hint="The hour that sleep time should end if it is enabled. The value for this parameter should be provided in ISO8601 format (i.e. 00-23). The time is considered to be in the same timezone as the user’s time_zone setting.">
			<cfargument name="time_zone" required="false" hint="The timezone dates and times should be displayed in for the user. The timezone must be one of the Rails TimeZone names. (http://api.rubyonrails.org/classes/ActiveSupport/TimeZone.html)">
			<cfargument name="lang" required="false" hint="The language which Twitter should render in for this user. The language must be specified by the appropriate two letter ISO 639-1 representation.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/account/settings.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postUpdateDeliveryDevice" output="false" access="public" returntype="String" 
		hint="Sets which device Twitter delivers updates to for the authenticating user. Sending none as the device parameter will disable SMS updates.">
			<cfargument name="accessToken" required="true">
			<cfargument name="device" required="true" hint="Must be one of: sms, none.">
			<cfargument name="include_entities" required="false" hint="When set to either true, t or 1, each tweet will include a node called “entities,”. This node offers a variety of metadata about the tweet in a discreet structure, including: user_mentions, urls, and hashtags. While entities are opt-in on timelines at present, they will be made a default component of output in the future.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/account/update_delivery_device.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postUpdateProfile" output="false" access="public" returntype="String" 
		hint="Sets which device Twitter delivers updates to for the authenticating user. Sending none as the device parameter will disable SMS updates.">
			<cfargument name="accessToken" required="true">
			<cfargument name="name" required="false" hint="Full name associated with the profile. Maximum of 20 characters.">
			<cfargument name="url" required="false" hint="URL associated with the profile. Will be prepended with “http://” if not present. Maximum of 100 characters.">
			<cfargument name="location" required="false" hint="The city or country describing where the user of the account is located. The contents are not normalized or geocoded in any way. Maximum of 30 characters.">
			<cfargument name="description" required="false" hint="A description of the user owning the account. Maximum of 160 characters.">
			<cfargument name="include_entities" required="false" hint="The entities node will not be included when set to false.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/account/update_profile.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postUpdateProfileBackgroundImage" output="false" access="public" returntype="String" 
		hint="Updates the authenticating user’s profile background image. This method can also be used to enable or disable the profile background image. Although each parameter is marked as optional, at least one of image, tile or use must be provided when making this request.">
			<cfargument name="accessToken" required="true">
			<cfargument name="image" required="false" hint="The background image for the profile, base64-encoded. Must be a valid GIF, JPG, or PNG image of less than 800 kilobytes in size. Images with width larger than 2048 pixels will be forcibly scaled down.">
			<cfargument name="title" required="false" hint="Whether or not to tile the background image. If set to true, t or 1 the background image will be displayed tiled. The image will not be tiled otherwise.">
			<cfargument name="include_entities" required="false" hint="The entities node will not be included when set to false.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfargument name="use" required="false" hint="Determines whether to display the profile background image or not. When set to true, t or 1 the background image will be displayed if an image is being uploaded with the request, or has been uploaded previously. An error will be returned if you try to use a background image when one is not being uploaded or does not exist. If this parameter is defined but set to anything other than true, t or 1, the background image will stop being used.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/account/update_profile_background_image.json",method=local.method)>
			<!--- <cfdump var="#local.request#"> --->
			<!--- <cfdump var="#local.request.addHeader("Content-type", "multipart/form-data; boundary=")#"> --->
			<!--- <cfdump var="#local.request.getHeaders()#"> --->
			<cfset local.image = arguments.image>
			<cfset structDelete(arguments, "image")>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParamsWithMedia(media=local.image,stctParams=arguments,objRequest=local.request)>
			<!--- <cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)> --->
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>

			<cfdump var="#local.request#">
			<cfdump var="#local.request.getVerb().toString()#">
			<cfdump var="#local.request.getCompleteUrl()#">
			<cfdump var="#local.request.getBodyContents()#">
			<cfabort>

			<cfreturn local.request.send() />
	</cffunction>

	<!--- blank --->
	<!---
	<cffunction name="post" output="false" access="public" returntype="String" 
		hint="Sets which device Twitter delivers updates to for the authenticating user. Sending none as the device parameter will disable SMS updates.">
			<cfargument name="accessToken" required="true">
			<cfargument name="" required="false" hint="">
			<cfargument name="" required="false" hint="">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>
	--->

</cfcomponent>


