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
            <div class="header">cfScribe Examples</div>

            <div class="body bg-gray">
                <form action="authTwitter.cfm?auth=1" method="post">
                    <div class="form-group">
                        <button type="submit" name="btnTwitter" class="btn btn-info btn-block">Twitter</button>
                    </div>
                </form>
                <div class="form-group">
                    <button type="submit" name="btnFacebook" class="btn btn-primary btn-block">Facebook</button>
                </div>
                <div class="form-group">
                    <button type="submit" name="btnGoogle" class="btn btn-danger btn-block">Google+</button>
                </div>
            </div>
            <div class="footer">
                <button type="submit" class="btn bg-olive btn-block disabled">Sign me in</button>
            </div>

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