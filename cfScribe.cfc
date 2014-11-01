<cfcomponent output="false">

	<!--- VARIABLES --->
    <cfset variables.instance = {}>
   

    <!--- SERVICE INIT --->
	<cffunction name="twitterInit" returntype="Any">
		<cfset var local = {}>
		<cfset local.config = createObject("component", "config").twitterInit()>
		<cfset local.paths = []>
		<cfset local.paths[1] = local.config.getScribePath()>
		<cfset local.paths[2] = local.config.getCommonsCodecPath()>
		<cfset local.paths[3] = local.config.getHttpCorePath()>
		<cfset local.paths[4] = local.config.getHttpMimePath()>
		<cfset variables.instance.javaloader = createObject("component", "components.javaloader.JavaLoader").init(local.paths)>
		<cfset variables.instance.TwitterApi = variables.instance.javaloader.create("org.scribe.builder.api.TwitterApi$Authenticate")>
		<cfset variables.instance.verb = variables.instance.javaloader.create("org.scribe.model.Verb")>
		<cfset variables.instance.scribeService = variables.instance.javaloader.create("org.scribe.builder.ServiceBuilder").init()
									   			  .provider(variables.instance.TwitterApi.getClass())
									   			  .apiKey(local.config.getConsumerKey())
									   			  .apiSecret(local.config.getConsumerSecret())
									   			  .callback(local.config.getCallback())
									   			  .build()>
		<cfreturn this />
	</cffunction>


    <!--- GETTER FUNCTIONS---> 
	<cffunction name="getRequestToken" output="false" access="public" returntype="string">
		<cfset getRequestToken = variables.instance.scribeService.getRequestToken()>
		<cfreturn getRequestToken>
	</cffunction>
	
	<cffunction name="getAuthorizationUrl" output="false" access="public" returntype="any">
		<cfargument name="requestToken" required="true">
		<cfreturn variables.instance.scribeService.getAuthorizationUrl(arguments.requestToken) />
	</cffunction>
	
	<cffunction name="getVerifier" output="false" access="public" returntype="string">
		<cfargument name="oAuthVerifier" required="true">
		<cfreturn variables.instance.javaloader.create("org.scribe.model.Verifier").init(arguments.oAuthVerifier) />
	</cffunction>
	
	<cffunction name="getAccessToken" output="false" access="public" returntype="string">
		<cfargument name="requestToken" required="true">
		<cfargument name="verifier" required="true">
		<cfreturn variables.instance.scribeService.getAccessToken(arguments.requestToken,arguments.verifier) />
	</cffunction>
	
	<!--- SETTER FUNCTIONS---> 
	<cffunction name="setRequest" output="false" access="public" returntype="string">
		<cfargument name="URI" required="true">
		<cfargument name="method" required="true">
		<cfswitch expression="#arguments.method#">
			<!---
			dunno if we need all of these, but they are valid options in scribe:
			GET, POST, PUT, DELETE, HEAD, OPTIONS, TRACE
			--->
			<cfcase value="post">
				<cfreturn variables.instance.javaloader.create("org.scribe.model.OAuthRequest").init(variables.instance.verb.post,arguments.URI) />
			</cfcase>
			<cfdefaultcase>
				<cfreturn variables.instance.javaloader.create("org.scribe.model.OAuthRequest").init(variables.instance.verb.get,arguments.URI) />
			</cfdefaultcase>
		</cfswitch>
	</cffunction>
	
	<cffunction name="setSignRequest" output="false" access="public" returntype="string">
		<cfargument name="accessToken" required="true">
		<cfargument name="request" required="true">
		<cfreturn variables.instance.scribeService.signRequest(arguments.accessToken,arguments.request) />
	</cffunction>

	<cffunction name="setRequestParams" output="false" access="public" returntype="string" hint="I take a request object and add a set of params to it">
		<cfargument name="method" required="true" type="string">
		<cfargument name="multipart" required="true" type="boolean" default="0">
		<cfargument name="stctParams" required="true" type="struct">
		<cfargument name="objRequest" required="true" type="string">

		<cfif arguments.multipart>
			<cfloop collection="#arguments.stctParams#" item="theVar">
				<!--- only add a param if it contains a value --->
				<cfif structFind(arguments.stctParams, theVar) neq "">
					<cfset objRequest.addPayload(theVar, structFind(arguments.stctParams, theVar))>
				</cfif>
			</cfloop>
		<cfelse>
			<cfswitch expression="#arguments.method#">
				<cfcase value="post">
					<cfloop collection="#arguments.stctParams#" item="theVar">
						<!--- only add a param if it contains a value --->
						<cfif structFind(arguments.stctParams, theVar) neq "">
							<cfset objRequest.addBodyParameter(theVar, structFind(arguments.stctParams, theVar))>
						</cfif>
					</cfloop>
				</cfcase>
				<cfdefaultcase>
					<cfloop collection="#arguments.stctParams#" item="theVar">
						<!--- only add a param if it contains a value --->
						<cfif structFind(arguments.stctParams, theVar) neq "">
							<cfset objRequest.addQuerystringParameter(theVar, structFind(arguments.stctParams, theVar))>
						</cfif>
					</cfloop>
				</cfdefaultcase>
			</cfswitch>
		</cfif>
		<cfreturn objRequest>
	</cffunction>

	<cffunction name="setRequestParamsWithMedia" output="true" access="public" returntype="string" hint="I take a media object, convert it to base64, and add it to the request payload">
		<cfargument name="objRequest" required="true" type="string">
		<cfargument name="stctParams" required="true" type="struct">
		<cfargument name="media" required="true" type="string" hint="local system path to media file">

		<!--- scribe doesn't create a multipart request for us, so we have to create it ourselves --->
		<!--- start by ini'ing the classes we need to build a multipart request --->
		<cfset variables.instance.ctEntity = variables.instance.javaloader.create("org.apache.http.entity.ContentType")>
		<cfset variables.instance.mpBuilder = variables.instance.javaloader.create("org.apache.http.entity.mime.MultipartEntityBuilder")>

		<!--- read the file into binary and encode it --->
		<cflock type="readonly" name="MimeLock#Hash(arguments.media)#" timeout="10" throwontimeout="no">
			<cffile action="readbinary" file="#arguments.media#" variable="theBinaryFile" />
		</cflock>

		<cfset var reqEntity = variables.instance.mpBuilder.create()>

		<cfloop collection="#arguments.stctParams#" item="theVar">
			<!--- only add a param if it contains a value --->
			<cfif structFind(arguments.stctParams, theVar) neq "">
				<!--- <cfset objRequest.addPayload(theVar, structFind(arguments.stctParams, theVar))> --->
				<cfset reqEntity.addTextBody(theVar, structFind(arguments.stctParams, theVar), variables.instance.ctEntity.TEXT_PLAIN)>
			</cfif>
		</cfloop>

		<cfset reqEntity.addBinaryBody("image",
										theBinaryFile,
										variables.instance.ctEntity.MULTIPART_FORM_DATA,
										GetFileFromPath(arguments.media)
										)>

		<cfset var bos = createObject("java", "java.io.ByteArrayOutputStream").init()>
		<cfset var msg = reqEntity.build()>
		<cfset msg.writeTo(bos)>
		<cfset var contentType = msg.getContentType()>
		<cfset objRequest.addHeader("Content-length", msg.getContentLength())>
		<cfset objRequest.addHeader(contentType.getName(), contentType.getValue())>
		<cfset objRequest.addPayload(bos.toByteArray())>

		<cfreturn objRequest>
	</cffunction>

	<cffunction name="setRequestMedia" output="true" access="public" returntype="string" hint="I take a media object, convert it to base64, and add it to the request payload">
	</cffunction>

	<!--- checkMedia() function courtesy of Matt Gifford/MonkehTweets and available at https://github.com/coldfumonkeh/monkehTweets  --->
	<cffunction name="checkMedia" access="package" output="false" hint="Check the media to be uploaded into the status update.">
		<cfargument name="file" required="true" type="any" hint="The file to upload and update the status with." />

		<cfimage action = "info"
				source = "#arguments.file#"
				structname = "stctImageInfo">
		<cfdump var="#stctImageInfo#">
		<cfabort>

		<cfset var strFileData = getMagicMime(arguments.file) />
		<cfset var strFileList	=	'image/gif, image/jpeg, image/png' />
		<cfset var stuReturnData	=	true />
		<!--- Image must be either gif, jpeg or png --->
		<cfif not listContainsNoCase(strFileList,strFileData['mimetype'])>
			<cfset stuReturnData = false />
			<!--- Invalid file type for image --->
		</cfif>
		<cfreturn stuReturnData />
	</cffunction>
	
	<!--- getMagicMime() function courtesy of Paul Connell and available at http://magicmime.riaforge.org/ --->
	<cffunction name="getMagicMime" access="package" output="false" returntype="struct">
		<cfargument name="filePath" required="yes">
		<cfscript>
			var theFile = "";
			var hexFile = "";
			var LookupArray = ArrayNew(2);
			var resultStruct = StructNew();
			var i = 0;

			// Default results
			resultStruct.typename = "Unknown";
			resultStruct.mimetype = "Unknown";
			resultStruct.extension = "Unknown";

			LookupArray[1][1] = "474946383761|474946383961";
			LookupArray[1][2] = "Graphics interchange format file";
			LookupArray[1][3] = "image/gif";
			LookupArray[1][4] = "gif";

			LookupArray[2][1] = "FFD8FFE0[A-Z0-9]+4A46494600";
			LookupArray[2][2] = "JPEG/JFIF graphics file";
			LookupArray[2][3] = "image/jpeg";
			LookupArray[2][4] = "jpg";

			LookupArray[3][1] = "FFD8FFE0[A-Z0-9]+4578696600";
			LookupArray[3][2] = "Digital camera JPG using Exchangeable Image File Format (EXIF)";
			LookupArray[3][3] = "image/jpeg";
			LookupArray[3][4] = "jpg";

			LookupArray[4][1] = "FFD8FFE0[A-Z0-9]+535049464600";
			LookupArray[4][2] = "Still Picture Interchange File Format (SPIFF)";
			LookupArray[4][3] = "image/jpeg";
			LookupArray[4][4] = "jpg";

			LookupArray[5][1] = "89504E470D0A1A0A";
			LookupArray[5][2] = "Portable Network Graphics Image";
			LookupArray[5][3] = "image/png";
			LookupArray[5][4] = "png";
		</cfscript>
		<cflock type="readonly" name="MimeLock#Hash(Arguments.filePath)#" timeout="10" throwontimeout="no">
			<cffile action="readbinary" file="#Arguments.filePath#" variable="local.theBinaryFile" />
		</cflock>
		<cfdump var="#len(theBinaryFile)#">
		<cfabort>
		<cfset hexFile = BinaryEncode(theBinaryFile,'Hex') />
		<cfloop from="1" to="#ArrayLen(LookupArray)#" step="1" index="i">
			<cfif ReFind(LookupArray[i][1],hexFile,0,false)>
				<cfset resultStruct.typename = LookupArray[i][2] />
				<cfset resultStruct.mimetype = LookupArray[i][3] />
				<cfset resultStruct.extension = LookupArray[i][4] />
				<cfbreak>
			</cfif>
		</cfloop>
		<cfreturn resultStruct />
	</cffunction>

</cfcomponent>


