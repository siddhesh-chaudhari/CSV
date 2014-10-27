<?php
session_start();



	$userID = $_GET['uid'];
	$userPass = $_GET['upass'];

	
	if($userID==""){
		header("location:index.php?error=1");
	}
	if($userPass==""){
		header("location:index.php?error=1");
	}
	
	if($userID=="megaadmin" && $userPass=="nsmedia@123@786"){
	
		$_SESSION['loggedin']=true;
		$_SESSION['uid']=$userID;
		$_SESSION['uname']=$userPass;
		
                header("location:csv.php");

		
	}else{
		header("location:index.php?error=1");
	}	
	

?>

