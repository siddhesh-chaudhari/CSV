<?php

if(isset($_GET['total'])){
	for($i=0;$i<$_GET['total'];$i++){
		$c="cg".$i;
		if(isset($_GET[$c])){
		echo $_GET[$c];
	}
	}
}

?>