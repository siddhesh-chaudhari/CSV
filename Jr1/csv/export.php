<?php
session_start();
if(!isset($_SESSION['loggedin'])){
	header("location:index.php");
}

if(isset($_GET['logout'])){
	session_destroy();
	header("location:index.php");
}

?>

<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
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
	<div class="top-container">
	<div class="container">
		<div class="title"><div style="padding-top:15px;">CSV EXPORT<a href="csv.php?logout=1"><div class="back-to-home">X</div></a></div></div>
		<div class="content">
			
			<form name="exportForm" id="exportForm" action="export_listing.php" method="GET">
			<div class="form-title">Import Options</div>
			<div class="form-file-select">
			
			Categories : <select name="ct" >
			<option value="all">ALL</option>
			<option value="only">ONLY SELECTED</option>
			</select>
			&nbsp;&nbsp;&nbsp;
			<button type="submit" class="submit-button">Next</button>
			<div><?php if(isset($_GET['export'])){echo "<a href='download.php' target='_blank'>Download the Exported CSV</a>";}?></div>
			</div>
			<hr style="margin-top:60px;border-color:#EEE;">
			</form>
			
			<div style="padding:10px;">
				<a href="demo.csv"><button id="dummy_file" class="submit-button" style="width:300px;">Download Demo CSV File</button></a>&nbsp;&nbsp;&nbsp;
				<a href="template.xlsx"><button id="dummy_file1" class="submit-button" style="width:300px;">Download Template XLS File</button></a>
			</div>
			
		</div>
	</div>
	
	
	<div class="slide-panel" id="slide">
		<div class="slide-content">
			<div style="padding:10px;">
				<a href="category.php" target="_blank"><button id="category" class="submit-button" style="width:130px;">Category ID's</button></a>
				<a href="filter.php" target="_blank"><button id="filter" class="submit-button">Filter ID's</button></a>
			</div>
		</div>
		<div class="slide-pull" id="help">
		<div class="slide-label">HELP</div>
		</div>
	</div>
	
	</div>
	
	
	
	<?php if (isset($_GET['error'])){
				if($_GET['error']==1){
					echo "<script>alert('Invalid File Format'); window.location='index.php';</script>";
				}	
			}
			
			if(isset($_GET['products'])){
				echo "<script>alert('".$_GET['products']." Products added in Database.'); window.location='index.php';</script>";
			}
			
	?>
	
<?php include "footer.php"; ?>
</body>
</html>