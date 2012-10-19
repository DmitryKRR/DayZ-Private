<?
if (isset($_SESSION['user_id']) and (strpos($_SESSION['user_permissions'],"list")!==false))
{
	$pnumber = 0;
	$tableheader = '';
	$tablerows = '';
	$pageNum = 1;
	$maxPage = 1;
	$rowsPerPage = 30;
	$nav = '';
	$self = 'index.php?view=table&show='.$show;
	$paging = '';

	$formhead = "";
	$formfoot = "";
	
	if (isset($_GET["show"])){
		$show = $_GET["show"];
	}else{
		$show = 0;
	}

	if (isset($_GET["sort"])){
		$sort = $_GET["sort"];
	}else{
		$sort = 0;
	}
	
	switch ($show) {
		case 0:
			$pagetitle = "Online players";
			break;
		case 1:
			switch ($sort) {
				case 0:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '0'";
					break;
				case 1:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '0' ORDER BY `name`";
					break;
				case 2:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '0' ORDER BY `unique_id`";
					break;
				case 3:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '0' ORDER BY `pos`";
					break;
				case 4:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '0' ORDER BY `medical`";
					break;
				case 5:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '0' ORDER BY `inventory`";
					break;
				case 6:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '0' ORDER BY `backpack`";
					break;
			};
			$pagetitle = "Alive players";		
			break;
		case 2:
			switch ($sort) {
				case 0:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '1' AND survivor.inventory NOT LIKE '[[],[]]'"; 
					break;
				case 1:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '1' AND survivor.inventory NOT LIKE '[[],[]]' ORDER BY `name`";
					break;
				case 2:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '1' AND survivor.inventory NOT LIKE '[[],[]]' ORDER BY `unique_id`";
					break;
				case 3:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '1' AND survivor.inventory NOT LIKE '[[],[]]' ORDER BY `pos`";
					break;
				case 4:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '1' AND survivor.inventory NOT LIKE '[[],[]]' ORDER BY `medical`";
					break;
				case 5:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '1' AND survivor.inventory NOT LIKE '[[],[]]' ORDER BY `inventory`";
					break;
				case 6:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id AND survivor.is_dead = '1' AND survivor.inventory NOT LIKE '[[],[]]' ORDER BY `backpack`";
					break;
			};
			$pagetitle = "Dead players";	
			break;
		case 3:
			switch ($sort) {
				case 0:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id"; 
					break;
				case 1:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id ORDER BY `name`";
					break;
				case 2:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id ORDER BY `unique_id`";
					break;
				case 3:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id ORDER BY `pos`";
					break;
				case 4:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id ORDER BY `medical`";
					break;
				case 5:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id ORDER BY `inventory`";
					break;
				case 6:
					$query = "SELECT profile.name, survivor.* FROM `profile`, `survivor` AS `survivor` WHERE profile.unique_id = survivor.unique_id ORDER BY `backpack`";
					break;
			};
			$pagetitle = "All players";	
			break;
		case 4:
			switch ($sort) {
				case 0:
					$query = "SELECT * FROM `objects` WHERE `damage` < 0.95";
					break;
				case 1:
					$query = "SELECT * FROM `objects` WHERE `damage` < 0.95 ORDER BY `id`";
					break;
				case 2:
					$query = "SELECT * FROM `objects` WHERE `damage` < 0.95 ORDER BY `otype`";
					break;
				case 3:
					$query = "SELECT * FROM `objects` WHERE `damage` < 0.95 ORDER BY `uid`";
					break;
				case 4:
					$query = "SELECT * FROM `objects` WHERE `damage` < 0.95 ORDER BY `damage`";
					break;
				case 5:
					$query = "SELECT * FROM `objects` WHERE `damage` < 0.95 ORDER BY `pos`";
					break;
				case 6:
					$query = "SELECT * FROM `objects` WHERE `damage` < 0.95 ORDER BY `inventory`";
					break;
				case 7:
					$query = "SELECT * FROM `objects` WHERE `damage` < 0.95 ORDER BY `health`";
					break;
			};
			$pagetitle = "Ingame vehicles";	
			break;
		default:
			$pagetitle = "Online players";
		};
		
	include ('/tables/'.$show.'.php');

?>

<div id="page-heading">
<?
	echo "<title>".$pagetitle." - ".$sitename."</title>";
	echo "<h1>".$pagetitle."</h1>";
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
				<!--  start message-blue -->
				<div id="message-blue">
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>
					<td class="blue-left"><? echo $pagetitle.": ".$pnumber; ?>. </td>
					<td class="blue-right"><a class="close-blue"><img src="<? echo $path; ?>images/table/icon_close_blue.gif"   alt="" /></a></td>
				</tr>
				</table>
				</div>
				<!--  end message-blue -->
				
				<!--  start paging..................................................... -->
				<? echo $paging; ?>				
				<!--  end paging................ -->
				<br/>
				<br/>
				<!--  start product-table ..................................................................................... -->
				<? echo $formhead;?>	
					<table border="0" width="100%" cellpadding="0" cellspacing="0" id="product-table">
						<? echo $tableheader; ?>
						<? echo $tablerows; ?>				
					</table>
				<? echo $formfoot;?>	
				<!--  end product-table................................... --> 
			</div>
			<!--  end content-table  -->
				
			<!--  start paging..................................................... -->
			<? echo $paging; ?>				
			<!--  end paging................ -->
	
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