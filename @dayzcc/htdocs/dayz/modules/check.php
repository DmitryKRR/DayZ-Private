<?
if (isset($_SESSION['user_id']) and (strpos($_SESSION['user_permissions'],"table") !== false))
{
	$pagetitle = "Items check";
	$query = "INSERT INTO `log_tool`(`action`, `user`, `timestamp`) VALUES ('ITEMS CHECK','{$_SESSION['login']}',NOW())";
	$sql2 = mysql_query($query) or die(mysql_error());
	
?>
<div id="page-heading">
<?
	echo "<title>".$pagetitle." - ".$sitename."</title>";
	echo "<h1>".$pagetitle."</h1>";

	error_reporting (E_ALL ^ E_NOTICE);

	$xml = file_get_contents('/items.xml', true);
	require_once($path.'modules/xml2array.php');
	$items_xml = XML2Array::createArray($xml);
	
	$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id";
	$res = mysql_query($query) or die(mysql_error());
	$number = mysql_num_rows($res);
	$rows = null;
	$itemscount = 0;		
	if ($number == 0) {
	  echo "<CENTER>Not found!</CENTER>";
	} else {
		while ($row=mysql_fetch_array($res)) {
		
		$Worldspace = str_replace("[", "", $row['pos']);
		$Worldspace = str_replace("]", "", $Worldspace);
		$Worldspace = str_replace("|", ",", $Worldspace);
		$Worldspace = explode(",", $Worldspace);

		$Inventory = $row['inventory'];	
		$Inventory = str_replace("|", ",", $Inventory);
		$Inventory  = json_decode($Inventory);	

		$Backpack  = $row['backpack'];
		$Backpack = str_replace("|", ",", $Backpack);
		$Backpack  = json_decode($Backpack);

		$Unknown = null;
		$Unknown = array();
		if (is_array($Inventory[0])){
			if (is_array($Inventory[1])){$Inventory = (array_merge($Inventory[0], $Inventory[1]));}
		} else {
			if (is_array($Inventory[1])){$Inventory = $Inventory[1];}			
		}		
		
		$bpweaponscount = count($Backpack[1][0]);
		$bpweapons = array();
		for ($m=0; $m<$bpweaponscount; $m++){
			for ($mi=0; $mi<$Backpack[1][1][$m]; $mi++){
				$bpweapons[] = $Backpack[1][0][$m];
			}
			/*if(array_key_exists(0,$Backpack[1][$m])){
				$bpweapons[] = $Backpack[1][$m][0];
			}*/
		}		
		$bpitemscount = count($Backpack[2][0]);
		$bpitems = array();
		for ($m=0; $m<$bpitemscount; $m++){
			for ($mi=0; $mi<$Backpack[2][1][$m]; $mi++){
				$bpitems[] = $Backpack[2][0][$m];
			}
		}
		
		$Backpack = (array_merge($bpweapons, $bpitems));
		$Inventory = (array_merge($Inventory, $Backpack));
							
		for ($i=0; $i<count($Inventory); $i++){
			if(array_key_exists($i,$Inventory)){
				$curitem = $Inventory[$i];
				if (is_array($curitem)){$curitem = $Inventory[$i][0];}
				if(!array_key_exists('s'.$curitem,$items_xml['items'])){
					$Unknown[] = $curitem;
				}
			}
		}

		if (count($Unknown)>0){
			$rows .= "<tr>
				<td>".$row['name']."</td>
				<td>".$row['unique_id']."</td>
				<td>";
				foreach($Unknown as $uitem => $uval)
				{
					$rows .= $uval."; ";
					$itemscount++;
				}
			$rows .= "</td></tr>";
		}
		}
	}								
?>
</div>
<table border="0" width="100%" cellpadding="0" cellspacing="0" id="content-table">
	<tr>
		<th rowspan="3" class="sized"><img src="<?echo $path;?>images/shared/side_shadowleft.jpg" width="20" height="300" alt="" /></th>
		<th class="topleft"></th>
		<td id="tbl-border-top">&nbsp;</td>
		<th class="topright"></th>
		<th rowspan="3" class="sized"><img src="<?echo $path;?>images/shared/side_shadowright.jpg" width="20" height="300" alt="" /></th>
	</tr>
	<tr>
		<td id="tbl-border-left"></td>
		<td>
		<!--  start content-table-inner ...................................................................... START -->
		<div id="content-table-inner">	
			<!--  start table-content  -->
			<div id="table-content">
			<!--  start message-red -->
			<?
			if ($itemscount>0){
			?>
				<div id="message-red">
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="red-left">Warning! <? echo $itemscount;?> unknown items found!</td>
					<td class="red-right"><a class="close-red"><img src="<?echo $path;?>images/table/icon_close_red.gif"   alt="" /></a></td>
				</tr>
				</table>
				</div>			
			<!--  end message-red -->
			
			<!--  start product-table ..................................................................................... -->
				<table border="0" width="100%" cellpadding="0" cellspacing="0" id="product-table">
				<tr>
					<th class="table-header-repeat line-left minwidth-1"><a href="">Player Name</a>	</th>
					<th class="table-header-repeat line-left minwidth-1"><a href="">Player UID</a></th>
					<th class="table-header-repeat line-left minwidth-1"><a href="">Unknown</a></th>
				</tr>
				<?
					echo $rows;
				?>				
				</table>
				<!--  end product-table................................... --> 
			<?
			}
			else{
			?>
			<div id="message-green">
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="green-left">No unknown items found!</td>
					<td class="green-right"><a class="close-red"><img src="<?echo $path;?>images/table/icon_close_green.gif"   alt="" /></a></td>
				</tr>
				</table>
				</div>
			<?
			}
			?>
			</div>
			<!--  end content-table  -->
			
			<div class="clear"></div>
		</div>
		<!--  end content-table-inner ............................................END  -->
		
		</td>
		<td id="tbl-border-right"></td>
	</tr>
	<tr>
		<th class="sized bottomleft"></th>
		<td id="tbl-border-bottom">&nbsp;</td>
		<th class="sized bottomright"></th>
	</tr>
	</table>
	<div class="clear">&nbsp;</div>
<?
}
else
{
	header('Location: index.php');
}
?>