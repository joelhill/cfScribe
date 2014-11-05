<cfif isDefined("session.user.accessToken") and
	isDefined("session.user.verifier")>
	success
<cfelse>
	<cflocation url="index.cfm" addtoken="false">
</cfif>

<cfset session.cfTwitterAPI = createObject("component", "cfTwitterAPI").init(cfScribeObject=session.cfscribe)>
<!--- <cfset local.APIHit = session.cfTwitterAPI.getAccountSettings(accessToken=session.user.accessToken)> --->
<cfset local.APIHit = session.cfTwitterAPI.getStatusesHomeTimeline(accessToken=session.user.accessToken
															)>
<!---
<cfset local.APIHit = session.cfTwitterAPI.postUpdateProfileBackgroundImage(
							accessToken=session.user.accessToken,
							image='/home/jordan/Pictures/Guild-Wars-fantasy-art-artwork-Guild-Wars.jpg',
							use=1
							)>
--->
<!--- image='/home/jordan/Pictures/Guild-Wars-fantasy-art-artwork-Guild-Wars.jpg', --->
<cfdump var="#local.APIHit#">
<cfdump var="#DeserializeJSON(local.APIHit.getBody())#">
<cfabort>

<cfdump var="#session#">