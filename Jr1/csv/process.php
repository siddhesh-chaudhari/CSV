<?php 
include "functions.php";
include "settings.php";

$file = $_GET['file'];
$path = "upload/".$file;

echo "<div style='font-size:40px;margin-left:42%;'>Processing</div>";
$check = csv_parse($path);
if($check == false){
	echo "<script>alert('CSV Parsing Failed');</script>";
}

$con = mysqli_connect($host,$user,$password,$database);
$count = 0;
$updated = 0;
for ($i=0;$i<sizeof($check);$i++){

	if($check[$i]['product_id']==""){

		$query = "INSERT INTO ".$db_prefix."product (model,quantity,image,manufacturer_id,shipping,price,points,date_available,weight,weight_class_id,length,width,height,status,date_added,date_modified) VALUES ('".$check[$i]['model']."','".$check[$i]['quantity']."','".$check[$i]['image']."','".$check[$i]['manufacturer_id']."','".$check[$i]['shipping']."','".$check[$i]['price']."','".$check[$i]['points']."','".date("Y-m-d")."','".$check[$i]['weight']."','".$check[$i]['weight_class_id']."','".$check[$i]['length']."','".$check[$i]['width']."','".$check[$i]['height']."','".$check[$i]['status']."','".date("Y-m-d")."','".date("Y-m-d")."')";
	
		$result = mysqli_query($con,$query);
	
		$id = mysqli_insert_id($con);
	
		$query = "INSERT INTO ".$db_prefix."product_description (product_id,language_id,name) VALUES ('".$id."','1','".$check[$i]['name']."')";
		$result = mysqli_query($con,$query);
	
		$query = "INSERT INTO ".$db_prefix."product_to_store (product_id,store_id) VALUES ('".$id."','0')";
		$result = mysqli_query($con,$query);
	
		if($check[$i]['category_id']!=""){
			$data = str_csv($check[$i]['category_id']);
		
			for($j = 0;$j <sizeof($data);$j++){
				if($data[$j]!=""){
					$query = "INSERT INTO ".$db_prefix."product_to_category (product_id,category_id) VALUES('".$id."','".intval($data[$j])."')";
					$result = mysqli_query($con,$query);
				}
			}
	
		}
	
		if($check[$i]['filter_id']!=""){
			$data = str_csv($check[$i]['filter_id']);
		
			for($j = 0;$j <sizeof($data);$j++){
				if($data[$j]!=""){
					$query = "INSERT INTO ".$db_prefix."product_filter (product_id,filter_id) VALUES('".$id."','".intval($data[$j])."')";
					$result = mysqli_query($con,$query);
				}
			}
	
		}
	
		$count++;
	
	}else{
		$query = "UPDATE ".$db_prefix."product SET model='".$check[$i]['model']."',quantity='".$check[$i]['quantity']."',image='".$check[$i]['image']."',manufacturer_id='".$check[$i]['manufacturer_id']."',shipping='".$check[$i]['shipping']."',price='".$check[$i]['price']."',points='".$check[$i]['points']."',weight='".$check[$i]['weight']."',weight_class_id='".$check[$i]['weight_class_id']."',length='".$check[$i]['length']."',width='".$check[$i]['width']."',height='".$check[$i]['height']."',status='".$check[$i]['status']."' WHERE product_id='".$check[$i]['product_id']."'";
		$result = mysqli_query($con,$query);
		
		$query = "UPDATE ".$db_prefix."product_description SET name='".$check[$i]['name']."' WHERE product_id='".$check[$i]['product_id']."'";
		$result = mysqli_query($con,$query);
		
		if($check[$i]['category_id']!=""){
			$data = str_csv($check[$i]['category_id']);
			
			$query = "DELETE * FROM ".$db_prefix."product_to_category WHERE product_id='".$check[$i]['product_id']."'";
			$result = mysqli_query($con,$query);
		
			for($j = 0;$j <sizeof($data);$j++){
				if($data[$j]!=""){
					$query = "INSERT INTO ".$db_prefix."product_to_category (product_id,category_id) VALUES('".$check[$i]['product_id']."','".intval($data[$j])."')";
					$result = mysqli_query($con,$query);
				}
			}
	
		}
		
		if($check[$i]['filter_id']!=""){
			$data = str_csv($check[$i]['filter_id']);
			
			$query = "DELETE * FROM ".$db_prefix."product_filter WHERE product_id='".$check[$i]['product_id']."'";
			$result = mysqli_query($con,$query);
		
			for($j = 0;$j <sizeof($data);$j++){
				if($data[$j]!=""){
					$query = "INSERT INTO ".$db_prefix."product_filter (product_id,filter_id) VALUES('".$id."','".intval($data[$j])."')";
					$result = mysqli_query($con,$query);
				}
			}
	
		}
		
		
		$updated++;
	}
}


mysqli_close($con);
//print_r($check);

//header("location:index.php?products=".$count); 
echo "<script>setTimeout(function(){window.location='csv.php?products=".$count."&updated=".$updated."'}, 1000);</script>";
?>