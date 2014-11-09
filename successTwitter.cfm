<cfif not isDefined("session.user.accessToken") or
	not isDefined("session.user.verifier")>
	<cflocation url="index.cfm" addtoken="false">
</cfif>

<cfset session.cfTwitterAPI = createObject("component", "cfTwitterAPI").init(cfScribeObject=session.cfscribe)>
<cfset local.APIHit = session.cfTwitterAPI.getAccountSettings(accessToken=session.user.accessToken)>
<cfset local.responseContent = DeserializeJSON(local.APIHit.getBody())>

<cfif isDefined("form.status")>
	<!--- if there's a tweet being posted to this page, it means you clicked the tweet button. Try to post the tweet using cfscribe --->
	<!--- The method we're hitting is postStatusesUpdate(), which can be found in the cfTwitterAPI.cfc file - we always pass the access token to every method, along with whatever other attributes we need to pass for that method --->
	<cfset local.sendTweet = session.cfTwitterAPI.postStatusesUpdate(
													accessToken=session.user.accessToken,
													status=trim(form.status)
													)>
	<cfset local.TweetResponse = DeserializeJSON(local.sendTweet.getBody())>
	<cfset sleep(1000)>
	<cfset local.tweetEmbed = session.cfTwitterAPI.getStatusesOembed(
													accessToken=session.user.accessToken,
													id=local.TweetResponse.id,
													maxwidth="320",
													align="center",
													omit_script=true
													)>
	<cfset local.tweetEmbed = local.tweetEmbed.getBody()>
</cfif>

<html lang="en">
    <head>
        <title>cfScribe</title>
        <meta name="keywords" content="" />
		<meta name="description" content="" />
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- <link rel="shortcut icon" href="images/favicon.ico"> -->
        <!-- Fonts -->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,300,300italic,400italic,600,600italic,700,700italic,800,800italic' rel='stylesheet' type='text/css'>
        
        <!-- Stylesheets -->
        <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
    </head>

	<body class="bg-black">

        <div class="form-box" id="login-box">
            <div class="header">Welcome to cfScribe, @<cfoutput>#local.responseContent.screen_name#</cfoutput></div>

            <cfif not isDefined("form.status")>
	            <form action="<cfoutput>#CGI.SCRIPT_NAME#</cfoutput>" method="post">
		            <div class="body bg-gray">
		            	<div class="form-group">
		            		<textarea class="form-control" rows="2" id="status" name="status">I'm tweeting this using #cfscribe, the simple #oauth library for #coldfusion and #railo!</textarea>
		                </div>
		            </div>

		            <div class="footer">
		                <div class="form-group">
		                    <button type="submit" name="btnTwitter" class="btn btn-info btn-block"><i class="fa fa-twitter"></i> Tweet using cfScribe</button>
		                </div>
		            </div>
	            </form>
            <cfelseif isDefined("local.TweetResponse.errors")>
            	<div class="body bg-gray">
	            	<div class="form-group">
	            		<cfdump var="#local.TweetResponse#">
	                </div>
	            </div>

	            <div class="footer">
	            </div>
            <cfelse>
            	<div class="body bg-gray" id="tweet">
	            	<div class="form-group">
						<script>window.twttr = (function (d, s, id) {
						  var t, js, fjs = d.getElementsByTagName(s)[0];
						  if (d.getElementById(id)) return;
						  js = d.createElement(s); js.id = id;
						  js.src= "https://platform.twitter.com/widgets.js";
						  fjs.parentNode.insertBefore(js, fjs);
						  return window.twttr || (t = { _e: [], ready: function (f) { t._e.push(f) } });
						}(document, "script", "twitter-wjs"));
						</script>
						<script>
						var tweetJSON = <cfoutput>#local.tweetEmbed#</cfoutput>;
	            		document.getElementById("tweet").innerHTML = tweetJSON.html;
	            		</script>
	                </div>
	            </div>

	            <div class="footer">
	            </div>
            </cfif>

            <div class="margin">
                <span><a href="/">home</a></span>
                <br/>
            </div>
        </div>

        <!-- javascripts -->
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
        <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/script.js"></script>   

    </body>
</html>