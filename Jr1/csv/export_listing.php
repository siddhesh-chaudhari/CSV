<?php
session_start();
include "settings.php";

if(!isset($_SESSION['loggedin'])){
	header("location:index.php");
}

if(!isset($_GET['ct'])){
	header("location:index.php");
}

if($_GET['ct']=="all"){
	header("location:export_process.php?ct=all");
}
?>
<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var c = 0;
	var v = 0;
	
    $('#credit').click(function() {
	if(c==0){
		$("#credit").animate({top:"0px"});
		c=1;
	}else{
		$("#credit").animate({top:"-192px"});
		c=0;
	}
});	

$('#help').click(function() {
	if(v==0){
		$("#slide").animate({top:"0px"});
		v=1;
	}else{
		$("#slide").animate({top:"-100px"});
		v=0;
	}
});
						  
});
</script>

<style>
tr:nth-child(even) {background: #ffffb3}
tr:nth-child(odd) {background: #FFF}
table{border:solid 1px #000;}
td{padding:10px;font-family:arial;}
th{border:solid 1px #000;padding:10px;font-family:arial;}
table{-webkit-box-shadow: 0px 0px 10px 5px rgba(0,0,0,0.30);
-moz-box-shadow: 0px 0px 10px 5px rgba(0,0,0,0.30);
box-shadow: 0px 0px 10px 5px rgba(0,0,0,0.30);}
</style>
</head>
<body>
<div id="credit" class="credit">
<ul style="list-style-type: none;">
<a href="csv.php"><li class="menu">Import</li></a>
<a href="export.php"><li class="menu">Export</li></a>
<a href="csv.php?logout=1"><li class="menu">Logout</li></a>
</ul>
<div class="menu-title">Menu</div>
</div>
<form name='selection' action='export_process.php' method='GET'>
<center>
	<div class="export-top-menu">
		<a class="submit-button export-top-back" href="export.php" >Go Back</a>
		<span style="font-size:40px;font-family:arial;color:#FFF;text-shadow:2px 2px 0px #AAA;">Category Export</span>
		<button class="submit-button export-top-submit" type="submit" >Export</button>
	</div>
</center>
<?php 
 if($_GET['ct']=="only"){

		$con = mysqli_connect($host,$user,$password,$database);

		$query = "SELECT * FROM ".$db_prefix."category_description";

		$result=mysqli_query($con,$query);

		echo "<center><table><tr><th>Select Categories to Export</th></tr>";
		//echo "";
		$count=0;
		while($row=mysqli_fetch_array($result)){
	
	
			$q = "SELECT * FROM ".$db_prefix."category WHERE category_id='".$row['category_id']."'";
			$r = mysqli_query($con,$q);
			$sub = mysqli_fetch_array($r);
	
			$chk = $sub['parent_id'];
			$fstr=$row['name'];
	
			while($chk != 0){
	
				$q = "SELECT * FROM ".$db_prefix."category_description WHERE category_id='".$chk."'";
				$r = mysqli_query($con,$q);
				$sub = mysqli_fetch_array($r);
	
				$fstr .= "-". $sub['name'];
		
				$q = "SELECT * FROM ".$db_prefix."category WHERE category_id='".$chk."'";
				$r = mysqli_query($con,$q);
				$sub = mysqli_fetch_array($r);
	
				$chk = $sub['parent_id'];
	
			}
	
			$arr = array();
			$arr = str_getcsv($fstr,"-");
			$str = "";
	
	
			for($i = sizeof($arr)-1;$i >= 0;$i--){
				if($arr[$i]!=""){
					if($i==0){
						$str .= "<strong>".$arr[$i]."</strong>";
					}else{
						$str .= $arr[$i]." > ";
					}	
				}
			}
	
			echo "<tr><td><input type='checkbox' name='cg".$count."' value='".$row['category_id']."'> ".$str."</td></tr>";
			$count++;
		}
echo "<input type='hidden' name='total' value='".$count."' />"; 
echo "<input type='hidden' name='ct' value='only' />"; 
echo "<tr><td><center><button type='submit' class='submit-button'>Export</button></center></td></tr>";
echo "</form></table></center>";

mysqli_close($con);
}
?>
<footer class="footer-class-list">
	<div style="margin-top:20px;padding:10px;float:left;">
		<a href="http://www.nsmedia.in" target="_blank"><img src="logo.png"></a>
	</div>
	<div class="footer-credit" style="float:left;">
		Powered by : <a href="http://www.nsmedia.in" target="_blank">NS Media solutions</a><br>
		Copyright &copy; 2014. All Rights Reserved.<br>
		<span style="font-size:14px;text-shadow:1px 1px 0px #AAA;">Developer: Siddhesh Chaudhari.</span>
	</div>
	<div class="footer-social">
		<a href="https://www.facebook.com/nsmedia.in" target="_blank"><img src="fb.png"></a>
	</div>
</footer>
</body>
</html>