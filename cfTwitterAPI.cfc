<cfcomponent output="false" extends="cfScribe">
    
	<!--- VARIABLES --->
    <cfset variables.instance = {}>
    

    <!--- INITIALISATION --->
	<cffunction name="init" returntype="Any">
		<cfargument name="cfScribeObject" required="true">
		<cfset variables.instance.cfScribeObject = arguments.cfScribeObject>
		<cfreturn this />
	</cffunction>
	
	<!--- --------------- --->
	<!--- ACCOUNT METHODS --->
	<!--- --------------- --->

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
			<cfset local.image = arguments.image>			
			<cfset structDelete(arguments, "accessToken")>
			<cfset structDelete(arguments, "image")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/account/update_profile_background_image.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParamsWithMedia(media=local.image,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postUpdateProfileColors" output="false" access="public" returntype="String" 
		hint="Sets one or more hex values that control the color scheme of the authenticating user’s profile page on twitter.com. Each parameter’s value must be a valid hexidecimal value, and may be either three or six characters (ex: fff or ffffff).">
			<cfargument name="accessToken" required="true">
			<cfargument name="profile_background_color" required="false" hint="Profile background color. (Example Values: 3D3D3D)">
			<cfargument name="profile_link_color" required="false" hint="Profile link color. (Example Values: 0000FF)">
			<cfargument name="profile_sidebar_border_color" required="false" hint="Profile sidebar’s border color. (Example Values: 0F0F0F)">
			<cfargument name="profile_sidebar_fill_color" required="false" hint="Profile sidebar’s background color. (Example Values: 00FF00)">
			<cfargument name="profile_text_color" required="false" hint="Profile text color. (Example Values: 000000)">
			<cfargument name="include_entities" required="false" hint="The entities node will not be included when set to false.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/account/update_profile_colors.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postUpdateProfileImage" output="false" access="public" returntype="String" 
		hint="Updates the authenticating user’s profile image. Note that this method expects raw multipart data, not a URL to an image.">
			<cfargument name="accessToken" required="true">
			<cfargument name="image" required="true" hint="The avatar image for the profile, base64-encoded. Must be a valid GIF, JPG, or PNG image of less than 700 kilobytes in size. Images with width larger than 400 pixels will be scaled down. Animated GIFs will be converted to a static GIF of the first frame, removing the animation.">
			<cfargument name="include_entities" required="false" hint="The entities node will not be included when set to false.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset local.image = arguments.image>	
			<cfset structDelete(arguments, "accessToken")>
			<cfset structDelete(arguments, "image")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/account/update_profile_image.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParamsWithMedia(media=local.image,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postRemoveProfileBanner" output="false" access="public" returntype="String" 
		hint="Removes the uploaded profile banner for the authenticating user. Returns HTTP 200 upon success.">
			<cfargument name="accessToken" required="true">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postUpdateProfileBanner" output="false" access="public" returntype="String" 
		hint="https://api.twitter.com/1.1/account/update_profile_banner.json">
			<cfargument name="accessToken" required="true">
			<cfargument name="banner" required="true" hint="The local image path of the image being uploaded as the user’s new profile banner.">
			<cfargument name="width" required="false" hint="The width of the preferred section of the image being uploaded in pixels. Use with height, offset_left, and offset_top to select the desired region of the image to use.">
			<cfargument name="height" required="false" hint="The height of the preferred section of the image being uploaded in pixels. Use with width, offset_left, and offset_top to select the desired region of the image to use.">
			<cfargument name="offset_left" required="false" hint="The number of pixels by which to offset the uploaded image from the left. Use with height, width, and offset_top to select the desired region of the image to use.">
			<cfargument name="offset_top" required="false" hint="The number of pixels by which to offset the uploaded image from the top. Use with height, width, and offset_left to select the desired region of the image to use.">
			<!---
			Response Code(s) Meaning:
			200, 201, 202	Profile banner image succesfully uploaded
			400				Either an image was not provided or the image data could not be processed
			422				The image could not be resized or is too large.
			--->
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset local.banner = arguments.banner>	
			<cfset structDelete(arguments, "accessToken")>
			<cfset structDelete(arguments, "banner")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/account/update_profile_banner.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParamsWithMedia(
																		media=local.banner,
																		mediaLabel="banner",
																		stctParams=arguments,
																		objRequest=local.request
																		)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<!--- ------------ --->
	<!--- USER METHODS --->
	<!--- ------------ --->

	<cffunction name="getUsersLookup" output="false" access="public" returntype="String" 
		hint="Returns fully-hydrated user objects for up to 100 users per request, as specified by comma-separated values passed to the user_id and/or screen_name parameters.
		This method is especially useful when used in conjunction with collections of user IDs returned from getFriendsIDs and getFollowersIDs.
		getUsersShow is used to retrieve a single user object.">
			<cfargument name="accessToken" required="true">
			<cfargument name="screen_name" required="false" hint="A comma separated list of screen names, up to 100 are allowed in a single request. You are strongly encouraged to use a POST for larger (up to 100 screen names) requests. (Example Values: twitterapi,twitter)">
			<cfargument name="user_id" required="false" hint="A comma separated list of user IDs, up to 100 are allowed in a single request. You are strongly encouraged to use a POST for larger requests. (Example Values: 783214,6253282)">
			<cfargument name="include_entities" required="false" hint="The entities node that may appear within embedded statuses will be disincluded when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/users/lookup.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getUsersShow" output="false" access="public" returntype="String" 
		hint="Returns a variety of information about the user specified by the required user_id or screen_name parameter. The author’s most recent Tweet will be returned inline when possible. getUsersLookup is used to retrieve a bulk collection of user objects.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for. Either an id or screen_name is required for this method.">
			<cfargument name="screen_name " required="false" hint="The screen name of the user for whom to return results for. Either a id or screen_name is required for this method.">
			<cfargument name="include_entities " required="false" hint="The entities node will be disincluded when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/users/show.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getUsersSearch" output="false" access="public" returntype="String" 
		hint="Provides a simple, relevance-based search interface to public user accounts on Twitter. Try querying by topical interest, full name, company name, location, or other criteria. Exact match searches are not supported. Only the first 1,000 matching results are available.">
			<cfargument name="accessToken" required="true">
			<cfargument name="q" required="true" hint="The (URL formatted) search query to run against people search.">
			<cfargument name="page" required="false" hint="Specifies the page of results to retrieve.">
			<cfargument name="count" required="false" hint="The number of potential user results to retrieve per page. This value has a maximum of 20.">
			<cfargument name="include_entities" required="false" hint="The entities node will be disincluded from embedded tweet objects when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/users/search.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getUsersContributees" output="false" access="public" returntype="String" 
		hint="Returns a collection of users that the specified user can 'contribute' to.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for. Helpful for disambiguating when a valid user ID is also a valid screen name.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for.">
			<cfargument name="include_entities" required="false" hint="The entities node will be disincluded when set to false.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/users/contributees.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getUsersContributors" output="false" access="public" returntype="String" 
		hint="Returns a collection of users who can contribute to the specified account.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for. Helpful for disambiguating when a valid user ID is also a valid screen name.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for.">
			<cfargument name="include_entities" required="false" hint="The entities node will be disincluded when set to false.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/users/contributors.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getUsersProfileBanner" output="false" access="public" returntype="String" 
		hint="Returns a map of the available size variations of the specified user’s profile banner. If the user has not uploaded a profile banner, a HTTP 404 will be served instead. This method can be used instead of string manipulation on the profile_banner_url returned in user objects as described in [node:10796 ]. Always specify either an user_id or screen_name when requesting this method.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for. Helpful for disambiguating when a valid user ID is also a valid screen name.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for. Helpful for disambiguating when a valid screen name is also a user ID.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/users/profile_banner.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<!--- -------------- --->
	<!--- STATUS METHODS --->
	<!--- -------------- --->

	<cffunction name="getStatusesMentionsTimeline" output="false" access="public" returntype="String" 
		hint="Returns the 20 most recent mentions (tweets containing a users’s @screen_name) for the authenticating user. The timeline returned is the equivalent of the one seen when you view your mentions on twitter.com. This method can only return up to 800 tweets.">
			<cfargument name="accessToken" required="true">
			<cfargument name="count" required="false" hint="Specifies the number of tweets to try and retrieve, up to a maximum of 200. The value of count is best thought of as a limit to the number of tweets to return because suspended or deleted content is removed after the count has been applied. We include retweets in the count.">
			<cfargument name="since_id " required="false" hint="Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.">
			<cfargument name="max_id" required="false" hint="Returns results with an ID less than (that is, older than) or equal to the specified ID.">
			<cfargument name="trim_user" required="false" hint="When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.">
			<cfargument name="contributor_details " required="false" hint="This parameter enhances the contributors element of the status response to include the screen_name of the contributor. By default only the user_id of the contributor is included.">
			<cfargument name="include_entities" required="false" hint="The entities node will be disincluded when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/mentions_timeline.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getStatusesUserTimeline" output="false" access="public" returntype="String" 
		hint="Returns a collection of the most recent Tweets posted by the user indicated by the screen_name or user_id parameters. User timelines belonging to protected users may only be requested when the authenticated user either “owns” the timeline or is an approved follower of the owner. The timeline returned is the equivalent of the one seen when you view a user’s profile on twitter.com.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for.">
			<cfargument name="since_id" required="false" hint="Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.">
			<cfargument name="count" required="false" hint="Specifies the number of tweets to try and retrieve, up to a maximum of 200 per distinct request.">
			<cfargument name="max_id" required="false" hint="Returns results with an ID less than (that is, older than) or equal to the specified ID.">
			<cfargument name="trim_user" required="false" hint="When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.">
			<cfargument name="exclude_replies" required="false" hint="This parameter will prevent replies from appearing in the returned timeline. Using exclude_replies with the count parameter will mean you will receive up-to count tweets — this is because the count parameter retrieves that many tweets before filtering out retweets and replies.">
			<cfargument name="contributor_details" required="false" hint="This parameter enhances the contributors element of the status response to include the screen_name of the contributor. By default only the user_id of the contributor is included.">
			<cfargument name="include_rts" required="false" hint="When set to false, the timeline will strip any native retweets (though they will still count toward both the maximal length of the timeline and the slice selected by the count parameter).">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/user_timeline.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getStatusesHomeTimeline" output="false" access="public" returntype="String" 
		hint="Returns a collection of the most recent Tweets and retweets posted by the authenticating user and the users they follow. The home timeline is central to how most users interact with the Twitter service. Up to 800 Tweets are obtainable on the home timeline. It is more volatile for users that follow many users or follow users who tweet frequently.">
			<cfargument name="accessToken" required="true">
			<cfargument name="count" required="false" hint="Specifies the number of records to retrieve. Must be less than or equal to 200. Defaults to 20.">
			<cfargument name="since_id" required="false" hint="Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.">
			<cfargument name="max_id" required="false" hint="Returns results with an ID less than (that is, older than) or equal to the specified ID.">
			<cfargument name="trim_user" required="false" hint="When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.">
			<cfargument name="exclude_replies" required="false" hint="This parameter will prevent replies from appearing in the returned timeline. Using exclude_replies with the count parameter will mean you will receive up-to count tweets — this is because the count parameter retrieves that many tweets before filtering out retweets and replies.">
			<cfargument name="contributor_details" required="false" hint="This parameter enhances the contributors element of the status response to include the screen_name of the contributor. By default only the user_id of the contributor is included.">
			<cfargument name="include_entities" required="false" hint="The entities node will be disincluded when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/home_timeline.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getStatusesRetweetsOfMe" output="false" access="public" returntype="String" 
		hint="Returns the most recent tweets authored by the authenticating user that have been retweeted by others. This timeline is a subset of the user’s getStatusesUserTimeline()">
			<cfargument name="accessToken" required="true">
			<cfargument name="count" required="false" hint="Specifies the number of records to retrieve. Must be less than or equal to 100. If omitted, 20 will be assumed.">
			<cfargument name="since_id" required="false" hint="Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.">
			<cfargument name="max_id" required="false" hint="Returns results with an ID less than (that is, older than) or equal to the specified ID.">
			<cfargument name="trim_user" required="false" hint="When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.">
			<cfargument name="include_entities" required="false" hint="The tweet entities node will not be included when set to false.">
			<cfargument name="include_user_entities" required="false" hint="The user entities node will not be included when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/retweets_of_me.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getStatusesRetweetsID" output="false" access="public" returntype="String" 
		hint="Returns a collection of the 100 most recent retweets of the tweet specified by the id parameter.">
			<cfargument name="accessToken" required="true">
			<cfargument name="id" required="false" hint="The numerical ID of the desired status.">
			<cfargument name="count" required="false" hint="Specifies the number of records to retrieve. Must be less than or equal to 100.">
			<cfargument name="trim_user" required="false" hint="When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/retweets/" & arguments.id & ".json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getStatusesShowID" output="false" access="public" returntype="String" 
		hint="Returns a single Tweet, specified by the id parameter. The Tweet’s author will also be embedded within the tweet. See getStatusesLookup() for getting Tweets in bulk (up to 100 per call).">
			<cfargument name="accessToken" required="true">
			<cfargument name="id" required="true" hint="The numerical ID of the desired Tweet.">
			<cfargument name="trim_user" required="false" hint="When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.">
			<cfargument name="include_my_retweet" required="false" hint="When set to either true, t or 1, any Tweets returned that have been retweeted by the authenticating user will include an additional current_user_retweet node, containing the ID of the source status for the retweet.">
			<cfargument name="include_entities" required="false" hint="The entities node will be disincluded when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/show.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postStatusesDestroyID" output="false" access="public" returntype="String" 
		hint="Destroys the status specified by the required ID parameter. The authenticating user must be the author of the specified status. Returns the destroyed status if successful.">
			<cfargument name="accessToken" required="true">
			<cfargument name="id" required="false" hint="The numerical ID of the desired status.">
			<cfargument name="trim_user" required="false" hint="When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/destroy/" & arguments.id & ".json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<!--- blank --->
	<!---
	<cffunction name="get" output="false" access="public" returntype="String" 
		hint="">
			<cfargument name="accessToken" required="true">
			<cfargument name="" required="false" hint="">
			<cfargument name="" required="false" hint="">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>
	--->

</cfcomponent>


