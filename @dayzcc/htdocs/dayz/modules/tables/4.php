<?php
	error_reporting (E_ALL ^ E_NOTICE);
	
	if (isset($_POST["vehicle"])) { 
		$del = $_POST["vehicle"];
		$N = count($del);
		
		for ($i = 0; $i < $N; $i++)
		{ 
			mysql_query("INSERT INTO `log_tool`(`action`, `user`, `timestamp`) VALUES ('DELETE VEHICLE: ID ".$del."', '{$_SESSION['login']}', NOW())");
			mysql_query("DELETE FROM `instance_vehicle` WHERE id = '".$del[$i]."'") or die(mysql_error());
			$delresult = "Vehicle ".$del[$i]." successfully removed!";
			//echo($del[$i]);
		}
	}

	$status = exec('tasklist /FI "IMAGENAME eq '.$exeserver.'" /FO CSV');
	$status = explode(",", strtolower($serverexestatus));
	$status = str_replace('"', "", $serverexestatus[0]);
	$serverrunning = false; if ($status == strtolower($exeserver)) { $serverrunning = true; }
	
	$res = mysql_query($query) or die(mysql_error());
	$pnumber = mysql_num_rows($res);			

	if(isset($_GET['page']))
	{ 
		$pageNum = $_GET['page'];
	}
	
	$offset = ($pageNum - 1) * $rowsPerPage;
	$maxPage = ceil($pnumber / $rowsPerPage);			

	for ($page = 1; $page <= $maxPage; $page++)
	{ 
	   if ($page == $pageNum)
	   { 
		  $nav .= " $page ";
	   }
	   else
	   { 
		  $nav .= "$self&page=$page";
	   }
	}
	
	$query = $query." LIMIT ".$offset.",".$rowsPerPage.";";
	$res = mysql_query($query) or die(mysql_error());
	$number = mysql_num_rows($res);
	
	$chbox = "";
	
	if (!$serverrunning){ 
		$chbox = '<th class="table-header-repeat line-left"><a href="">Delete</a></th>';
		$formhead = '<form action="index.php?view=table&show=4" method="post">';
		$formfoot = '<input type="submit" class="submit-login" /></form>';
	}
	
	$tableheader = header_vehicle($show, $chbox, $order);
	
	while ($row = mysql_fetch_array($res)) { 
		if (!$serverrunning) { $chbox = '<td align="center" class="gear_preview" style="vertical-align:middle;"><input name="vehicle[]" value="'.$row['id'].'" type="checkbox"/></td>'; }	else {$chbox = ''; }
		$tablerows .= row_vehicle($row, $chbox, $serverworld);
	}
	
	include('paging.php');
?>