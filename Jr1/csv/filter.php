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

$query = "SELECT * FROM ".$db_prefix."filter_group_description";

$result=mysqli_query($con,$query);

echo "<table><tr><th>Filter Group></th><th>Filter Name</th><th>Filter ID</th></tr>";
while($row=mysqli_fetch_array($result)){
	
	$q = "SELECT * FROM ".$db_prefix."filter_description WHERE filter_group_id='".$row['filter_group_id']."'";
	$result1 = mysqli_query($con,$q);
	
	while($row1=mysqli_fetch_array($result1)){
		echo "<tr><td>".$row['name']."</td><td>".$row1['name']."</td><td>".$row1['filter_id']."</td></tr>";
	}
}
echo "</table>";

mysqli_close($con);

?>
</body></html>