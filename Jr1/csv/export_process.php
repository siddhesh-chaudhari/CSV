<?php 
session_start();
if(!isset($_SESSION['loggedin'])){
	header("location:index.php");
}

include "settings.php";


if(!isset($_GET['ct'])){
	header("location:index.php");
}

$con = mysqli_connect($host,$user,$password,$database);

if($_GET['ct']=="all"){		// ALL CODE

	$query = "SELECT * FROM ".$db_prefix."product";
	$result = mysqli_query($con,$query) or die;

	$fp = fopen('download.csv', 'w');
	$str="";

	$str = "product_id,model,name,quantity,image,manufacturer_id,shipping,price,points,weight,weight_class_id,length,width,height,status,category_id,filter_id".PHP_EOL;
	fwrite($fp, $str);
	$str = "";

	while($row=mysqli_fetch_array($result)){

		$q = "SELECT * FROM ".$db_prefix."product_description WHERE product_id='".$row['product_id']."'";
		$result1 = mysqli_query($con,$q);
		$row1 = mysqli_fetch_array($result1);

		$q2 = "SELECT * FROM ".$db_prefix."product_to_category WHERE product_id='".$row['product_id']."'";
		$result2 = mysqli_query($con,$q2);

		$cats ="";
		while($row2=mysqli_fetch_array($result2)){
			$cats .= "-".$row2['category_id'];
		}
		$cats = substr($cats,1,strlen($cats));

		$str = $row['product_id'].",".$row['model'].",".$row1['name'].",".$row['quantity'].",".$row['image'].",".$row['manufacturer_id'].",".$row['shipping'].",".intval($row['price']).",".intval($row['points']).",".intval($row['weight']).",".$row['weight_class_id'].",".intval($row['length']).",".intval($row['width']).",".intval($row['height']).",".$row['status'].",".$cats.",".PHP_EOL;

		fwrite($fp, $str);
	
	}
	fclose($fp);	
}else if($_GET['ct']=="only"){	// ONLY Code

	$fp = fopen('download.csv', 'w');
	$str="";
	
	$str = "product_id,model,name,quantity,image,manufacturer_id,shipping,price,points,weight,weight_class_id,length,width,height,status,category_id,filter_id".PHP_EOL;
	fwrite($fp, $str);
	$str = "";

	if(isset($_GET['total'])){
		for($i=0;$i<$_GET['total'];$i++){
			$c="cg".$i;
			if(isset($_GET[$c])){
			
				$q = "SELECT * FROM ".$db_prefix."product_to_category WHERE category_id='".$_GET[$c]."'";
				$r = mysqli_query($con,$q);
				
				while($row = mysqli_fetch_array($r)){
					$q1 = "SELECT * FROM ".$db_prefix."product_description WHERE product_id='".$row['product_id']."'";
					$r1 = mysqli_query($con,$q1);
					$row1 = mysqli_fetch_array($r1);
					
					$q2 = "SELECT * FROM ".$db_prefix."product WHERE product_id='".$row['product_id']."'";
					$r2 = mysqli_query($con,$q2);
					$row2 = mysqli_fetch_array($r2);
					
					$q3 = "SELECT * FROM ".$db_prefix."product_to_category WHERE product_id='".$row['product_id']."'";
					$r3 = mysqli_query($con,$q3);
					
					$cats = "";
					
					while($row3=mysqli_fetch_array($r3)){
						$cats .= "-".$row3['category_id'];
					}			
					$cats = substr($cats,1,strlen($cats));
					
					$str = $row2['product_id'].",".$row2['model'].",".$row1['name'].",".$row2['quantity'].",".$row2['image'].",".$row2['manufacturer_id'].",".$row2['shipping'].",".intval($row2['price']).",".intval($row2['points']).",".intval($row2['weight']).",".$row2['weight_class_id'].",".intval($row2['length']).",".intval($row2['width']).",".intval($row2['height']).",".$row2['status'].",".$cats.",".PHP_EOL;

					fwrite($fp, $str);
					
					
				}
				
			}
		}
		
	}
	fclose($fp);	

}

mysqli_close($con);
header("location:export.php?export=1");

?>