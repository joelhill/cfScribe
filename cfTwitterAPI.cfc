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
		hint="Returns a collection of the 100 most recent retweets of the tweet specified by the id parameter. For more than 100 retweeters, use getStatusesResteetersIDs().">
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

	<cffunction name="postMediaUpload" output="false" access="public" returntype="String" 
		hint="Uploading images with this method will provide you with media id's, which can then be used when publishing a new status with multiple media attachments. Details here: https://dev.twitter.com/rest/public/uploading-media-multiple-photos">
			<cfargument name="accessToken" required="true">
			<cfargument name="image" required="true" hint="Supported image formats are PNG, JPG and GIF. Animated GIFs are now supported.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset local.image = arguments.image>	
			<cfset structDelete(arguments, "accessToken")>
			<cfset structDelete(arguments, "image")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://upload.twitter.com/1.1/media/upload.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParamsWithMedia(media=local.image,mediaLabel="media",stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postStatusesUpdate" output="false" access="public" returntype="String" 
		hint="Updates the authenticating user’s current status, also known as tweeting. For each update attempt, the update text is compared with the authenticating user’s recent tweets. Any attempt that would result in duplication will be blocked, resulting in a 403 error. Therefore, a user cannot submit the same status twice in a row.">
			<cfargument name="accessToken" required="true">
			<cfargument name="status" required="true" hint="The text of your status update, typically up to 140 characters. URL encode as necessary. t.co link wrapping may affect character counts. Use getHelpConfiguration to get the character count of t.co shortened links">
			<cfargument name="in_reply_to_status_id" required="false" hint="The ID of an existing status that the update is in reply to.">
			<cfargument name="possibly_sensitive" required="false" hint="If you upload Tweet media that might be considered sensitive content such as nudity, violence, or medical procedures, you should set this value to true.">
			<cfargument name="lat" required="false" hint="The latitude of the location this tweet refers to. This parameter will be ignored unless it is inside the range -90.0 to +90.0 (North is positive) inclusive. It will also be ignored if there isn’t a corresponding long parameter.">
			<cfargument name="long" required="false" hint="The longitude of the location this tweet refers to. The valid ranges for longitude is -180.0 to +180.0 (East is positive) inclusive. This parameter will be ignored if outside that range, if it is not a number, if geo_enabled is disabled, or if there not a corresponding lat parameter.">
			<cfargument name="place_id" required="false" hint="A place in the world. (as defined by https://dev.twitter.com/overview/api/places)">
			<cfargument name="display_coordinates" required="false" hint="Whether or not to put a pin on the exact coordinates a tweet has been sent from.">
			<cfargument name="trim_user" required="false" hint="When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.">
			<cfargument name="media_ids " required="false" hint="A list of media ids to associate with the Tweet. You may associated up to 4 media to a Tweet. Use postMediaUpload() to obtain media id's.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/update.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postStatusesRetweetID" output="false" access="public" returntype="String" 
		hint="Retweets a tweet. Returns the original tweet with retweet details embedded.">
			<cfargument name="accessToken" required="true">
			<cfargument name="id" required="true" hint="The numerical ID of the desired status.">
			<cfargument name="trim_user" required="false" hint="When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/retweet/" & arguments.id & ".json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<!--- postStatusesUpdateWithMedia() is depreciated. Use postStatusesUpdate() & postMediaUpload() instead. https://dev.twitter.com/rest/reference/post/statuses/update_with_media --->

	<cffunction name="getStatusesOembed" output="false" access="public" returntype="String" 
		hint="Returns a single Tweet, specified by either a Tweet web URL or the Tweet ID, in an oEmbed-compatible format. The returned HTML snippet will be automatically recognized as an Embedded Tweet when Twitter’s widget JavaScript is included on the page. (https://dev.twitter.com/rest/reference/get/statuses/oembed)">
			<cfargument name="accessToken" required="true">
			<cfargument name="id" required="false" hint="The ID of the desired Tweet. Either the id or url parameters must be specified in a request. It is not necessary to include both.">
			<cfargument name="url" required="false" hint="The URL-encoded URL of the Tweet to be embedded. Example: https%3A%2F%2Ftwitter.com%Interior%2Fstatus%2F507185938620219395">
			<cfargument name="maxwidth" required="false" hint="The maximum width of a rendered Tweet in whole pixels. This value must be between 220 and 550 inclusive.">
			<cfargument name="hide_media" required="false" hint="When set to true, t or 1 links in a Tweet are not expanded to photo, video, or link previews.">
			<cfargument name="hide_thread" required="false" hint="When set to true, t or 1 a collapsed version of the previous Tweet in a conversation thread will not be displayed when the requested Tweet is in reply to another Tweet.">
			<cfargument name="omit_script" required="false" hint="When set to true, t or 1 the <script> responsible for loading widgets.js will not be returned. Your webpages should include their own reference to widgets.js for use across all Twitter widgets including Embedded Tweets.">
			<cfargument name="align" required="false" hint="Specifies whether the embedded Tweet should be floated left, right, or center in the page relative to the parent element. Valid values are left, right, center, and none. Defaults to none, meaning no alignment styles are specified for the Tweet.">
			<cfargument name="related" required="false" hint="A comma-separated list of Twitter usernames related to your content. This value will be forwarded to Tweet action intents if a viewer chooses to reply, favorite, or retweet the embedded Tweet.">
			<cfargument name="lang" required="false" hint="Request returned HTML and a rendered Tweet in the specified Twitter language supported by embedded Tweets.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/oembed.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getStatusesResteetersIDs" output="false" access="public" returntype="String" 
		hint="Returns a collection of up to 100 user IDs belonging to users who have retweeted the tweet specified by the id parameter.">
			<cfargument name="accessToken" required="true">
			<cfargument name="id" required="true" hint="The numerical ID of the desired status.">
			<cfargument name="cursor" required="false" hint="Causes the list of IDs to be broken into pages of no more than 100 IDs at a time. The number of IDs returned is not guaranteed to be 100 as suspended users are filtered out after connections are queried. If no cursor is provided, a value of -1 will be assumed, which is the first page.">
			<cfargument name="stringify_ids" required="false" hint="Many programming environments will not consume our ids due to their size. Provide this option to have ids returned as strings instead.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/retweeters/ids.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getStatusesLookup" output="false" access="public" returntype="String" 
		hint="Returns fully-hydrated tweet objects for up to 100 tweets per request, as specified by comma-separated values passed to the id parameter. This method is especially useful to get the details (hydrate) a collection of Tweet IDs.">
			<cfargument name="accessToken" required="true">
			<cfargument name="id" required="true" hint="A comma separated list of tweet IDs, up to 100 are allowed in a single request.">
			<cfargument name="include_entities" required="false" hint="The entities node that may appear within embedded statuses will be disincluded when set to false.">
			<cfargument name="trim_user" required="false" hint="When set to either true, t or 1, each tweet returned in a timeline will include a user object including only the status authors numerical ID. Omit this parameter to receive the complete user object.">
			<cfargument name="map" required="false" hint="When using the map parameter, tweets that do not exist or cannot be viewed by the current user will still have their key represented but with an explicitly null value paired with it.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/statuses/lookup.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getSearchTweets" output="false" access="public" returntype="String" 
		hint="Returns a collection of relevant Tweets matching a specified query. Please note that Twitter’s search service and, by extension, the Search API is not meant to be an exhaustive source of Tweets. Not all Tweets will be indexed or made available via the search interface.">
			<cfargument name="accessToken" required="true">
			<cfargument name="q" required="true" hint="A UTF-8, URL-encoded search query of 500 characters maximum, including operators. Queries may additionally be limited by complexity.">
			<cfargument name="geocode" required="false" hint="Returns tweets by users located within a given radius of the given latitude/longitude. The location is preferentially taking from the Geotagging API, but will fall back to their Twitter profile.">
			<cfargument name="lang" required="false" hint="Restricts tweets to the given language, given by an ISO 639-1 code. Language detection is best-effort.">
			<cfargument name="locale" required="false" hint="Specify the language of the query you are sending (only ja is currently effective). This is intended for language-specific consumers and the default should work in the majority of cases.">
			<cfargument name="result_type" required="false" hint="Specifies what type of search results you would prefer to receive. The current default is “mixed.” Valid values include: * mixed: Include both popular and real time results in the response. * recent: return only the most recent results in the response * popular: return only the most popular results in the response.">
			<cfargument name="count" required="false" hint="The number of tweets to return per page, up to a maximum of 100. Defaults to 15. This was formerly the “rpp” parameter in the old Search API.">
			<cfargument name="until" required="false" hint="Returns tweets generated before the given date. Date should be formatted as YYYY-MM-DD. Keep in mind that the search index may not go back as far as the date you specify here.">
			<cfargument name="since_id" required="false" hint="Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.">
			<cfargument name="max_id" required="false" hint="Returns results with an ID less than (that is, older than) or equal to the specified ID.">
			<cfargument name="include_entities " required="false" hint="The entities node will be disincluded when set to false.">
			<cfargument name="callback" required="false" hint="If supplied, the response will use the JSONP format with a callback of the given name. The usefulness of this parameter is somewhat diminished by the requirement of authentication for requests to this endpoint.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/search/tweets.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>	

	<!--- ---------------------- --->
	<!--- DIRECT MESSAGE METHODS --->
	<!--- ---------------------- --->

	<cffunction name="getDirectMessages" output="false" access="public" returntype="String" 
		hint="Returns the 20 most recent direct messages sent to the authenticating user. Includes detailed information about the sender and recipient user. You can request up to 200 direct messages per call, up to a maximum of 800 incoming DMs.">
			<cfargument name="accessToken" required="true">
			<cfargument name="since_id" required="false" hint="Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.">
			<cfargument name="max_id" required="false" hint="Returns results with an ID less than (that is, older than) or equal to the specified ID.">
			<cfargument name="count" required="false" hint="Specifies the number of direct messages to try and retrieve, up to a maximum of 200. The value of count is best thought of as a limit to the number of Tweets to return because suspended or deleted content is removed after the count has been applied. ">
			<cfargument name="include_entities" required="false" hint="The entities node will not be included when set to false.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/direct_messages.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getDirectMessagesSent" output="false" access="public" returntype="String" 
		hint="Returns the 20 most recent direct messages sent by the authenticating user. Includes detailed information about the sender and recipient user. You can request up to 200 direct messages per call, up to a maximum of 800 outgoing DMs.">
			<cfargument name="accessToken" required="true">
			<cfargument name="since_id" required="false" hint="Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.">
			<cfargument name="max_id" required="false" hint="Returns results with an ID less than (that is, older than) or equal to the specified ID.">
			<cfargument name="count" required="false" hint="Specifies the number of records to retrieve. Must be less than or equal to 200.">
			<cfargument name="page" required="false" hint="Specifies the page of results to retrieve.">
			<cfargument name="include_entities" required="false" hint="The entities node will not be included when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/direct_messages/sent.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getDirectMessagesShow" output="false" access="public" returntype="String" 
		hint="Returns a single direct message, specified by an id parameter. Like the /1.1/direct_messages.format request, this method will include the user objects of the sender and recipient.">
			<cfargument name="accessToken" required="true">
			<cfargument name="id" required="true" hint="The ID of the direct message.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/direct_messages/show.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postDirectMessagesDestroy" output="false" access="public" returntype="String" 
		hint="Destroys the direct message specified in the required ID parameter. The authenticating user must be the recipient of the specified direct message.">
			<cfargument name="accessToken" required="true">
			<cfargument name="id" required="false" hint="The ID of the direct message to delete.">
			<cfargument name="include_entities" required="false" hint="The entities node will not be included when set to false.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/direct_messages/destroy.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postDirectMessagesNew" output="false" access="public" returntype="String" 
		hint="Sends a new direct message to the specified user from the authenticating user. Requires both the user and text parameters and must be a POST. Returns the sent message in the requested format if successful.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user who should receive the direct message. Helpful for disambiguating when a valid user ID is also a valid screen name.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user who should receive the direct message. Helpful for disambiguating when a valid screen name is also a user ID.">
			<cfargument name="text" required="false" hint="The text of your direct message. Be sure to URL encode as necessary, and keep the message under 140 characters.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/direct_messages/new.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<!--- -------------------------- --->
	<!--- FRIENDS & FOLLOWER METHODS --->
	<!--- -------------------------- --->

	<cffunction name="getFriendsIDs" output="false" access="public" returntype="String" 
		hint="Returns a cursored collection of user IDs for every user the specified user is following (otherwise known as their “friends”). At this time, results are ordered with the most recent following first — however, this ordering is subject to unannounced change and eventual consistency issues. Results are given in groups of 5,000 user IDs and multiple “pages” of results can be navigated through using the next_cursor value in subsequent requests.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for.">
			<cfargument name="cursor" required="false" hint="Causes the list of connections to be broken into pages of no more than 5000 IDs at a time. The number of IDs returned is not guaranteed to be 5000 as suspended users are filtered out after connections are queried. If no cursor is provided, a value of -1 will be assumed, which is the first page.">
			<cfargument name="stringify_ids" required="false" hint="Many programming environments will not consume our Tweet ids due to their size. Provide this option to have ids returned as strings instead.">
			<cfargument name="count" required="false" hint="Specifies the number of IDs attempt retrieval of, up to a maximum of 5,000 per distinct request. The value of count is best thought of as a limit to the number of results to return. When using the count parameter with this method, it is wise to use a consistent count value across all requests to the same user’s collection. Usage of this parameter is encouraged in environments where all 5,000 IDs constitutes too large of a response.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/friends/ids.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getFollowersIDs" output="false" access="public" returntype="String" 
		hint="Returns a cursored collection of user IDs for every user following the specified user. At this time, results are ordered with the most recent following first — however, this ordering is subject to unannounced change and eventual consistency issues. Results are given in groups of 5,000 user IDs and multiple “pages” of results can be navigated through using the next_cursor value in subsequent requests.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for.">
			<cfargument name="cursor" required="false" hint="Causes the list of connections to be broken into pages of no more than 5000 IDs at a time. The number of IDs returned is not guaranteed to be 5000 as suspended users are filtered out after connections are queried. If no cursor is provided, a value of -1 will be assumed, which is the first page.">
			<cfargument name="stringify_ids" required="false" hint="Many programming environments will not consume our Tweet ids due to their size. Provide this option to have ids returned as strings instead.">
			<cfargument name="count" required="false" hint="Specifies the number of IDs attempt retrieval of, up to a maximum of 5,000 per distinct request. The value of count is best thought of as a limit to the number of results to return. When using the count parameter with this method, it is wise to use a consistent count value across all requests to the same user’s collection. Usage of this parameter is encouraged in environments where all 5,000 IDs constitutes too large of a response.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/followers/ids.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getFriendshipsNoRetweetsIDs" output="false" access="public" returntype="String" 
		hint="Returns a collection of user_ids that the currently authenticated user does not want to receive retweets from. Use postFriendshipsUpdate() to set the “no retweets” status for a given user account on behalf of the current user.">
			<cfargument name="accessToken" required="true">
			<cfargument name="stringify_ids" required="false" hint="Many programming environments will not consume our ids due to their size. Provide this option to have ids returned as strings instead. Read more about [node:194]. This parameter is especially important to use in Javascript environments.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/friendships/no_retweets/ids.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getFriendshipsIncoming" output="false" access="public" returntype="String" 
		hint="Returns a collection of numeric IDs for every user who has a pending request to follow the authenticating user.">
			<cfargument name="accessToken" required="true">
			<cfargument name="cursor" required="false" hint="Causes the list of connections to be broken into pages of no more than 5000 IDs at a time. The number of IDs returned is not guaranteed to be 5000 as suspended users are filtered out after connections are queried. If no cursor is provided, a value of -1 will be assumed, which is the first page.">
			<cfargument name="stringify_ids" required="false" hint="Many programming environments will not consume our Tweet ids due to their size. Provide this option to have ids returned as strings instead.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/friendships/incoming.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getFriendshipsOutgoing" output="false" access="public" returntype="String" 
		hint="Returns a collection of numeric IDs for every protected user for whom the authenticating user has a pending follow request.">
			<cfargument name="accessToken" required="true">
			<cfargument name="cursor" required="false" hint="Causes the list of connections to be broken into pages of no more than 5000 IDs at a time. The number of IDs returned is not guaranteed to be 5000 as suspended users are filtered out after connections are queried. If no cursor is provided, a value of -1 will be assumed, which is the first page.">
			<cfargument name="stringify_ids" required="false" hint="Many programming environments will not consume our Tweet ids due to their size. Provide this option to have ids returned as strings instead.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/friendships/outgoing.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postFriendshipsCreate" output="false" access="public" returntype="String" 
		hint="Allows the authenticating users to follow the user specified in the ID parameter. Returns the befriended user in the requested format when successful. Returns a string describing the failure condition when unsuccessful. If you are already friends with the user a HTTP 403 may be returned, though for performance reasons you may get a 200 OK message even if the friendship already exists.">
			<cfargument name="accessToken" required="true">
			<cfargument name="screen_name " required="false" hint="The screen name of the user for whom to befriend. Providing either screen_name or user_id is required.">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to befriend. Providing either screen_name or user_id is required.">
			<cfargument name="follow" required="false" hint="Enable notifications for the target user.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/friendships/create.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postFriendshipsDestroy" output="false" access="public" returntype="String" 
		hint="Allows the authenticating user to unfollow the user specified in the ID parameter. Returns the unfollowed user in the requested format when successful. Returns a string describing the failure condition when unsuccessful.">
			<cfargument name="accessToken" required="true">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to unfollow. Providing either screen_name or user_id is required.">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to unfollow. Providing either screen_name or user_id is required.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/friendships/destroy.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postFriendshipsUpdate" output="false" access="public" returntype="String" 
		hint="Allows one to enable or disable retweets and device notifications from the specified user.">
			<cfargument name="accessToken" required="true">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to befriend. Providing either screen_name or user_id is required.">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to befriend. Providing either screen_name or user_id is required.">
			<cfargument name="device" required="false" hint="Enable/disable device notifications from the target user.">
			<cfargument name="retweets" required="false" hint="Enable/disable retweets from the target user.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/friendships/update.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getFriendShipsShow" output="false" access="public" returntype="String" 
		hint="Returns detailed information about the relationship between two arbitrary users. At least one source and one target, whether specified by IDs or screen_names, should be provided to this method.">
			<cfargument name="accessToken" required="true">
			<cfargument name="source_id" required="false" hint="The user_id of the subject user.">
			<cfargument name="source_screen_name" required="false" hint="The screen_name of the subject user.">
			<cfargument name="target_id" required="false" hint="The user_id of the target user.">
			<cfargument name="target_screen_name" required="false" hint="The screen_name of the target user.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/friendships/show.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getFriendsList" output="false" access="public" returntype="String" 
		hint="Returns a cursored collection of user objects for every user the specified user is following (otherwise known as their “friends”). Results are given in groups of 20 users and multiple “pages” of results can be navigated through using the next_cursor value in subsequent requests.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for. Either a screen_name or a user_id should be provided.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for. Either a screen_name or a user_id should be provided.">
			<cfargument name="cursor" required="false" hint="Causes the results to be broken into pages. If no cursor is provided, a value of -1 will be assumed, which is the first page.">
			<cfargument name="count" required="false" hint="The number of users to return per page, up to a maximum of 200. Defaults to 20.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfargument name="include_user_entities" required="false" hint="The user object entities node will be disincluded when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/friends/list.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getFollowersList" output="false" access="public" returntype="String" 
		hint="Returns a cursored collection of user objects for users following the specified user. Results are given in groups of 20 users and multiple “pages” of results can be navigated through using the next_cursor value in subsequent requests.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for. Either a screen_name or a user_id should be provided.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for. Either a screen_name or a user_id should be provided.">
			<cfargument name="cursor" required="false" hint="Causes the results to be broken into pages. If no cursor is provided, a value of -1 will be assumed, which is the first page.">
			<cfargument name="count" required="false" hint="The number of users to return per page, up to a maximum of 200. Defaults to 20.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfargument name="include_user_entities" required="false" hint="The user object entities node will be disincluded when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/followers/list.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getFriendshipsLookup" output="false" access="public" returntype="String" 
		hint="Returns the relationships of the authenticating user to the comma-separated list of up to 100 screen_names or user_ids provided. Values for connections can be: following, following_requested, followed_by, none, blocking, muting.">
			<cfargument name="accessToken" required="true">
			<cfargument name="screen_name" required="false" hint="A comma separated list of screen names, up to 100 are allowed in a single request.">
			<cfargument name="user_id" required="false" hint="A comma separated list of user IDs, up to 100 are allowed in a single request.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/friendships/lookup.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<!--- ---------------- --->
	<!--- BLOCKING METHODS --->
	<!--- ---------------- --->

	<cffunction name="getBlocksList" output="false" access="public" returntype="String" 
		hint="Returns a cursored collection of user objects that the authenticating user is blocking.">
			<cfargument name="accessToken" required="true">
			<cfargument name="include_entities" required="false" hint="The entities node will not be included when set to false.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfargument name="cursor" required="false" hint="Causes the list of blocked users to be broken into pages of no more than 5000 IDs at a time. The number of IDs returned is not guaranteed to be 5000 as suspended users are filtered out after connections are queried. If no cursor is provided, a value of -1 will be assumed, which is the first page.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/blocks/list.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getBlocksIDs" output="false" access="public" returntype="String" 
		hint="Returns an cursored array of numeric user ids the authenticating user is blocking.">
			<cfargument name="accessToken" required="true">
			<cfargument name="stringify_ids" required="false" hint="Many programming environments will not consume our ids due to their size. Provide this option to have ids returned as strings instead.">
			<cfargument name="cursor" required="false" hint="Causes the list of IDs to be broken into pages of no more than 5000 IDs at a time. The number of IDs returned is not guaranteed to be 5000 as suspended users are filtered out after connections are queried. If no cursor is provided, a value of -1 will be assumed, which is the first page.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/blocks/ids.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postBlocksCreate" output="false" access="public" returntype="String" 
		hint="Blocks the specified user from following the authenticating user. In addition the blocked user will not show in the authenticating users mentions or timeline (unless retweeted by another user). If a follow or friend relationship exists it is destroyed.">
			<cfargument name="accessToken" required="true">
			<cfargument name="screen_name" required="false" hint="The screen name of the potentially blocked user. Either screen_name or user_id must be provided.">
			<cfargument name="user_id" required="false" hint="The ID of the potentially blocked user. Either screen_name or user_id must be provided.">
			<cfargument name="include_entities" required="false" hint="The entities node will not be included when set to false.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/blocks/create.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postBlocksDestroy" output="false" access="public" returntype="String" 
		hint="Un-blocks the user specified in the ID parameter for the authenticating user. Returns the un-blocked user in the requested format when successful. If relationships existed before the block was instated, they will not be restored.">
			<cfargument name="accessToken" required="true">
			<cfargument name="screen_name" required="false" hint="The screen name of the potentially blocked user. Either screen_name or user_id must be provided.">
			<cfargument name="user_id" required="false" hint="The ID of the potentially blocked user. Either screen_name or user_id must be provided.">
			<cfargument name="include_entities" required="false" hint="The entities node will not be included when set to false.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/blocks/destroy.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<!--- ------------ --->
	<!--- USER METHODS --->
	<!--- ------------ --->

	<cffunction name="getUsersLookup" output="false" access="public" returntype="String" 
		hint="Returns fully-hydrated user objects for up to 100 users per request, as specified by comma-separated values passed to the user_id and/or screen_name parameters. This method is especially useful when used in conjunction with collections of user IDs returned from GET friends / ids and GET followers / ids.">
			<cfargument name="accessToken" required="true">
			<cfargument name="screen_name" required="false" hint="A comma separated list of screen names, up to 100 are allowed in a single request. You are strongly encouraged to use a POST for larger (up to 100 screen names) requests.">
			<cfargument name="user_id" required="false" hint="A comma separated list of user IDs, up to 100 are allowed in a single request. You are strongly encouraged to use a POST for larger requests.">
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
		hint="Returns a variety of information about the user specified by the required user_id or screen_name parameter. The author’s most recent Tweet will be returned inline when possible. getUsersLookup() is used to retrieve a bulk collection of user objects.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for. Either an id or screen_name is required for this method.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for. Either a id or screen_name is required for this method.">
			<cfargument name="include_entities" required="false" hint="The entities node will be disincluded when set to false.">
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
			<cfargument name="q" required="true" hint="The search query to run against people search.">
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
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for. A user_id or screen_name is required.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for. A user_id or screen_name is required.">
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
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for. A user_id or screen_name is required.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for. A user_id or screen_name is required.">
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
		hint="Returns a map of the available size variations of the specified user’s profile banner. If the user has not uploaded a profile banner, a HTTP 404 will be served instead. This method can be used instead of string manipulation on the profile_banner_url returned in user objects.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for. A user_id or screen_name is required.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for. A user_id or screen_name is required.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/users/profile_banner.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getUsersSuggestions" output="false" access="public" returntype="String" 
		hint="Access to Twitter’s suggested user list. This returns the list of suggested user categories usable with getUsersSuggestionsSlug().">
			<cfargument name="accessToken" required="true">
			<cfargument name="lang" required="false" hint="Restricts the suggested categories to the requested language. Currently supported languages are provided by the getHelpLanguages() API request. Unsupported language codes will receive English (en) results.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/users/suggestions.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getUsersSuggestionsSlug" output="false" access="public" returntype="String" 
		hint="Access the users in a given category of the Twitter suggested user list. It is recommended that applications cache this data for no more than one hour.">
			<cfargument name="accessToken" required="true">
			<cfargument name="slug" required="false" hint="The short name of list or a category">
			<cfargument name="lang" required="false" hint="Restricts the suggested categories to the requested language. Currently supported languages are provided by the getHelpLanguages() API request. Unsupported language codes will receive English (en) results.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/users/suggestions/" & arguments.slug & ".json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getUsersSuggestionsSlugMembers" output="false" access="public" returntype="String" 
		hint="Access the users in a given category of the Twitter suggested user list and return their most recent status if they are not a protected user.">
			<cfargument name="accessToken" required="true">
			<cfargument name="slug" required="false" hint="The short name of list or a category">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/users/suggestions/" & arguments.slug & "/members.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postUsersReportSpam" output="false" access="public" returntype="String" 
		hint="Report the specified user as a spam account to Twitter. Additionally performs a block on behalf of the authenticated user.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID or screen_name of the user you want to report as a spammer. A user_id or screen_name is required.">
			<cfargument name="screen_name" required="false" hint="The ID of the user you want to report as a spammer. A user_id or screen_name is required.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/users/report_spam.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<!--- ------------ --->
	<!--- MUTE METHODS --->
	<!--- ------------ --->

	<cffunction name="getMutesUsersList" output="false" access="public" returntype="String" 
		hint="Returns an array of user objects the authenticating user has muted. ">
			<cfargument name="accessToken" required="true">
			<cfargument name="cursor" required="false" hint="Causes the list of IDs to be broken into pages of no more than 5000 IDs at a time. The number of IDs returned is not guaranteed to be 5000 as suspended users are filtered out after connections are queried. If no cursor is provided, a value of -1 will be assumed, which is the first page.">
			<cfargument name="include_entities" required="false" hint="The entities node will not be included when set to false.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/mutes/users/list.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getMutesUsersIDs" output="false" access="public" returntype="String" 
		hint="Returns an array of numeric user ids the authenticating user has muted.">
			<cfargument name="accessToken" required="true">
			<cfargument name="cursor" required="false" hint="Causes the list of IDs to be broken into pages of no more than 5000 IDs at a time. The number of IDs returned is not guaranteed to be 5000 as suspended users are filtered out after connections are queried. If no cursor is provided, a value of -1 will be assumed, which is the first page.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/mutes/users/ids.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postMutesUsersCreate" output="false" access="public" returntype="String" 
		hint="Mutes the user specified in the ID parameter for the authenticating user. Returns the muted user in the requested format when successful. Returns a string describing the failure condition when unsuccessful.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the potentially muted user. A user_id or screen_name is required.">
			<cfargument name="screen_name" required="false" hint="The screen name of the potentially muted user. A user_id or screen_name is required.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/mutes/users/create.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postMutesUsersDestroy" output="false" access="public" returntype="String" 
		hint="Un-mutes the user specified in the ID parameter for the authenticating user. Returns the unmuted user in the requested format when successful. Returns a string describing the failure condition when unsuccessful.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the potentially muted user. A user_id or screen_name is required.">
			<cfargument name="screen_name" required="false" hint="The screen name of the potentially muted user. A user_id or screen_name is required.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/mutes/users/destroy.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<!--- ------------------ --->
	<!--- FAVORITING METHODS --->
	<!--- ------------------ --->

	<cffunction name="getFavoritesList" output="false" access="public" returntype="String" 
		hint="Returns the 20 most recent Tweets favorited by the authenticating or specified user. If you do not provide either a user_id or screen_name to this method, it will assume you are requesting on behalf of the authenticating user. Specify one or the other for best results.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for.">
			<cfargument name="count" required="false" hint="Specifies the number of records to retrieve. Must be less than or equal to 200. Defaults to 20.">
			<cfargument name="since_id" required="false" hint="Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.">
			<cfargument name="max_id" required="false" hint="Returns results with an ID less than (that is, older than) or equal to the specified ID.">
			<cfargument name="include_entities" required="false" hint="The entities node will be omitted when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/favorites/list.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postFavoritesCreate" output="false" access="public" returntype="String" 
		hint="Favorites the status specified in the ID parameter as the authenticating user. Returns the favorite status when successful.">
			<cfargument name="accessToken" required="true">
			<cfargument name="id" required="true" hint="The numerical ID of the desired status.">
			<cfargument name="include_entities" required="false" hint="The entities node will be omitted when set to false.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/favorites/create.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postFavoritesDestroy" output="false" access="public" returntype="String" 
		hint="Un-favorites the status specified in the ID parameter as the authenticating user. Returns the un-favorited status in the requested format when successful.">
			<cfargument name="accessToken" required="true">
			<cfargument name="id" required="true" hint="The numerical ID of the desired status.">
			<cfargument name="include_entities" required="false" hint="The entities node will be omitted when set to false.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/favorites/destroy.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<!--- ------------ --->
	<!--- LIST METHODS --->
	<!--- ------------ --->

	<cffunction name="getListsList" output="false" access="public" returntype="String" 
		hint="Returns all lists the authenticating or specified user subscribes to, including their own. The user is specified using the user_id or screen_name parameters. If no user is given, the authenticating user is used.

		A maximum of 100 results will be returned by this call. Subscribed lists are returned first, followed by owned lists. This means that if a user subscribes to 90 lists and owns 20 lists, this method returns 90 subscriptions
		and 10 owned lists. The reverse method returns owned lists first, so with reverse=true, 20 owned lists and 80 subscriptions would be returned. If your goal is to obtain every list a user owns or subscribes to, use
		getListsOwnerships() and/or getListsSubscriptions() instead.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for.">
			<cfargument name="screen_name " required="false" hint="The screen name of the user for whom to return results for.">
			<cfargument name="reverse" required="false" hint="Set this to true if you would like owned lists to be returned first.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/lists/list.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getListsStatuses" output="false" access="public" returntype="String" 
		hint="Returns a timeline of tweets authored by members of the specified list. Retweets are included by default. Use the include_rts=false parameter to omit retweets.">
			<cfargument name="accessToken" required="true">
			<cfargument name="list_id" required="true" hint="The numerical id of the list.">
			<cfargument name="slug" required="false" hint="You can identify a list by its slug instead of its numerical id. If you decide to do so, note that you’ll also have to specify the list owner using the owner_id or owner_screen_name parameters.">
			<cfargument name="owner_screen_name" required="false" hint="The screen name of the user who owns the list being requested by a slug.">
			<cfargument name="owner_id" required="false" hint="The user ID of the user who owns the list being requested by a slug.">
			<cfargument name="since_id" required="false" hint="Returns results with an ID greater than (that is, more recent than) the specified ID. There are limits to the number of Tweets which can be accessed through the API. If the limit of Tweets has occured since the since_id, the since_id will be forced to the oldest ID available.">
			<cfargument name="max_id" required="false" hint="Returns results with an ID less than (that is, older than) or equal to the specified ID.">
			<cfargument name="count" required="false" hint="Specifies the number of results to retrieve per page.">
			<cfargument name="include_entities" required="false" hint="Entities are ON by default in API 1.1, each tweet includes a node called “entities”. This node offers a variety of metadata about the tweet in a discreet structure, including: user_mentions, urls, and hashtags. You can omit entities from the result by using include_entities=false">
			<cfargument name="include_rts" required="false" hint="When set to either true, t or 1, the list timeline will contain native retweets (if they exist) in addition to the standard stream of tweets. The output format of retweeted tweets is identical to the representation you see in home_timeline.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/lists/statuses.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="postListsMembersDestroy" output="false" access="public" returntype="String" 
		hint="Removes the specified member from the list. The authenticated user must be the list’s owner to remove members from the list.">
			<cfargument name="accessToken" required="true">
			<cfargument name="list_id" required="false" hint="The numerical id of the list.">
			<cfargument name="slug" required="false" hint="You can identify a list by its slug instead of its numerical id. If you decide to do so, note that you’ll also have to specify the list owner using the owner_id or owner_screen_name parameters.">
			<cfargument name="user_id" required="false" hint="The ID of the user to remove from the list. Helpful for disambiguating when a valid user ID is also a valid screen name.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to remove from the list. Helpful for disambiguating when a valid screen name is also a user ID.">
			<cfargument name="owner_screen_name" required="false" hint="The screen name of the user who owns the list being requested by a slug.">
			<cfargument name="owner_id" required="false" hint="The user ID of the user who owns the list being requested by a slug.">
			<cfset var local = {}>
			<cfset local.method = "post">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/lists/members/destroy.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getListsMemberships" output="false" access="public" returntype="String" 
		hint="Returns the lists the specified user has been added to. If user_id or screen_name are not provided the memberships for the authenticating user are returned.">
			<cfargument name="accessToken" required="true">
			<cfargument name="user_id" required="false" hint="The ID of the user for whom to return results for. A user_id or screen_name must be provided.">
			<cfargument name="screen_name" required="false" hint="The screen name of the user for whom to return results for. A user_id or screen_name must be provided.">
			<cfargument name="count" required="false" hint="The amount of results to return per page. Defaults to 20. No more than 1000 results will ever be returned in a single page.">
			<cfargument name="cursor" required="false" hint="Breaks the results into pages. Provide a value of -1 to begin paging. Provide values as returned in the response body’s next_cursor and previous_cursor attributes to page back and forth in the list. It is recommended to always use cursors when the method supports them.">
			<cfargument name="filter_to_owned_lists" required="false" hint="When set to true, t or 1, will return just lists the authenticating user owns, and the user represented by user_id or screen_name is a member of.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/lists/memberships.json",method=local.method)>
			<cfset local.request = variables.instance.cfScribeObject.setRequestParams(method=local.method,stctParams=arguments,objRequest=local.request)>
			<cfset local.signRequest = variables.instance.cfScribeObject.setSignRequest(accessToken=local.accessToken,request=local.request)>
			<cfreturn local.request.send() />
	</cffunction>

	<cffunction name="getListsSubscribers" output="false" access="public" returntype="String" 
		hint="Returns the subscribers of the specified list. Private list subscribers will only be shown if the authenticated user owns the specified list.">
			<cfargument name="accessToken" required="true">
			<cfargument name="list_id" required="false" hint="The numerical id of the list.">
			<cfargument name="slug" required="false" hint="You can identify a list by its slug instead of its numerical id. If you decide to do so, note that you’ll also have to specify the list owner using the owner_id or owner_screen_name parameters.">
			<cfargument name="owner_screen_name" required="false" hint="The screen name of the user who owns the list being requested by a slug.">
			<cfargument name="owner_id" required="false" hint="The user ID of the user who owns the list being requested by a slug.">
			<cfargument name="count" required="false" hint="Specifies the number of results to return per page (see cursor below). The default is 20, with a maximum of 5,000.">
			<cfargument name="cursor" required="false" hint="Breaks the results into pages. A single page contains 20 lists. Provide a value of -1 to begin paging. Provide values as returned in the response body’s next_cursor and previous_cursor attributes to page back and forth in the list.">
			<cfargument name="include_entities" required="false" hint="When set to either true, t or 1, each tweet will include a node called “entities”. This node offers a variety of metadata about the tweet in a discreet structure, including: user_mentions, urls, and hashtags.">
			<cfargument name="skip_status" required="false" hint="When set to either true, t or 1 statuses will not be included in the returned user objects.">
			<cfset var local = {}>
			<cfset local.method = "get">
			<cfset local.accessToken = arguments.accessToken>
			<cfset structDelete(arguments, "accessToken")>
			<cfset local.request = variables.instance.cfScribeObject.setRequest(uri="https://api.twitter.com/1.1/lists/subscribers.json",method=local.method)>
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


