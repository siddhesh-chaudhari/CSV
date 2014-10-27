<?php
error_reporting(E_ALL);
session_start();

if(isset($_SESSION['loggedin'])){
	if($_SESSION['loggedin']){
		header("location:csv.php");
	}
}

?>

<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</head>
<body>
	<div class="top-container">
	<div class="container">
		<div class="title"><div style="padding-top:15px;">CSV IMPORT - Log in<a href="../index.php"><div class="back-to-home">X</div></a></div></div>
		<div class="content">
		<form name="login" id="login" action="login.php" method="GET">
			<div class="login-form">
				<table>
				<tr><td>User Name</td><td><input type="text" name="uid" /></td></tr>
				<tr><td>Password</td><td><input type="password" name="upass" /></td></tr>
				<tr><td></td><td><button type="submit" class="submit-button">Log in</button></td></tr>
				</table>
			</div>
		</form>

		</div>
	</div>
	</div>

<?php 
if(isset($_GET['error'])){
	echo "<script>alert('Invalid Login Credentials');</script>";
}
?>
</body>
</html>