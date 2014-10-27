<?php
$allowedExts = array("csv");
$temp = explode(".", $_FILES["file"]["name"]);
$extension = end($temp);
if($_Files["file"]["error"] != "0"){
	header("location:csv.php?error=1");
}

 move_uploaded_file($_FILES["file"]["tmp_name"], "upload/" . $_FILES["file"]["name"]);

 header("location:process.php?file=".$_FILES["file"]["name"]);

?>