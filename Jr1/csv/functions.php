<?php

function csv_parse($filename){
	 if(!file_exists($filename) || !is_readable($filename)){
        return false;
	}	
		$header = null;
		$data = array();
		
		if(($handle = fopen($filename, 'r')) !== False){
			
			while (($row = fgetcsv($handle,1000,',')) !== false){

				if(!$header){
					$header = $row;
				}else{
					$data[] = array_combine($header,$row);
				}
				
			}
			fclose($handle);
		
		}
		return $data;
	
}

function str_csv($str){

	if($str==""){
		return false;
	}
	
	$data = array();
	$data = str_getcsv($str,"-");
		
	return $data;
}

function check(){
	echo "<script>alert('Success');</script>";
}

?>