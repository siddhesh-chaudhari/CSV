<html>
<head>
<style>
tr:nth-child(even) {background: #ffffb3}
tr:nth-child(odd) {background: #FFF}
table{border:solid 1px #000;}
td{padding:10px;}
th{border:solid 1px #000;padding:10px;}
</style>
</head>
<body>
<?php
session_start();
include "settings.php";

if(!isset($_SESSION['loggedin'])){
	header("location:index.php");
}


$con = mysqli_connect($host,$user,$password,$database);

$query = "SELECT * FROM ".$db_prefix."category_description";

$result=mysqli_query($con,$query);

echo "<table><tr><th>Name</th><th>Category ID</th></tr>";
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
	
	echo "<tr><td>".$str."</td><td>".$row['category_id']."</td></tr>";

}
echo "</table>";

mysqli_close($con);

?>
</body></html>