<?php
if (isset($_SESSION['user_id']))
{

function GenerateSalt($n=3)
{
	$key = '';
	$pattern = '1234567890abcdefghijklmnopqrstuvwxyz.,*_-=+';
	$counter = strlen($pattern)-1;
	for($i=0; $i<$n; $i++)
	{
		$key .= $pattern{rand(0,$counter)};
	}
	return $key;
}

if (empty($_POST))
{
	?>
	<div id="page-heading">
		<h1>Registration</h1>
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
				<h2>Enter login, password and privileges for new user</h2>
				
				<form id="regform" action="index.php?view=register">
				
					<table border="0" cellpadding="0" cellspacing="0"  id="id-form">
					<tr>
						<th valign="top">Login:</th>
						<td><input type="text" class="inp-form" name="login" /></td>
						<td></td>
					</tr>
					<tr>
						<th valign="top">Password:</th>
						<td><input type="text" class="inp-form" name="password" /></td>
						<td></td>
					</tr>
					<tr>
						<th valign="top">Privileges:</th>
						<td><input type="text" class="inp-form" name="privileges" /></td>
						<td>&nbsp;&nbsp;(Possible permissions: map, list, user, control")</td>
						<td></td>
					</tr>
					<tr>
						<th>&nbsp;</th>
						<td valign="top">
							<input type="submit" value="" class="form-submit" />
						</td>
						<td></td>
					</tr>
					</table>
				</form>		
			</div>
			<div id="result"></div>
			<!--  end table-content  -->
			<script>
				  /* attach a submit handler to the form */
				  $("#regform").submit(function(event) {

					/* stop form from submitting normally */
					event.preventDefault(); 
						
					/* get some values from elements on the page: */
					var $form = $( this ),
						term = $form.find( 'input[name="login"]' ).val(),
						term2 = $form.find( 'input[name="password"]' ).val(),
						term3 = $form.find( 'input[name="privileges"]' ).val(),
						url = $form.attr( 'action' );
						
					var d = document.getElementById('content-table-inner');
					var olddiv = document.getElementById('table-content');
					d.removeChild(olddiv);
					
					var d = document.getElementById('dvPopup');
					var olddiv = document.getElementById('closebutton');
					d.removeChild(olddiv);

					/* Send the data using post and put the results in a div */
					$.post( url, { login: term, password: term2, privileges: term3 },
					  function( data ) {
						  var content = $( data ).find( '#content' );
						  $( "#result" ).empty().append( content );
					  }
					);
				  });
			</script>
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
<?php
}
else
{

	$login = (isset($_POST['login'])) ? mysql_real_escape_string($_POST['login']) : '';
	$password = (isset($_POST['password'])) ? mysql_real_escape_string($_POST['password']) : '';
	$permissions = (isset($_POST['privileges'])) ? mysql_real_escape_string($_POST['privileges']) : '';

	$error = false;
	$errort = '';
	
	if (strlen($login) < 2)
	{
		$error = true;
		$errort .= 'Login must be at least 2 characters.<br />';
	}
	if (strlen($password) < 6)
	{
		$error = true;
		$errort .= 'Password must be at least 6 characters.<br />';
	}

	$query = "SELECT `id` FROM `users` WHERE `login`='{$login}' LIMIT 1";
	$sql = mysql_query($query) or die(mysql_error());
	if (mysql_num_rows($sql)==1)
	{
		$error = true;
		$errort .= 'Login already used.<br />';
	}

	if (!$error)
	{
		$salt = GenerateSalt();
		$hashed_password = md5(md5($password) . $salt);
		
		$query = "INSERT INTO `users` SET
						`login`='{$login}',
						`password`='{$hashed_password}',
						`salt`='{$salt}',
						`permissions`='{$permissions}'";
		$sql = mysql_query($query) or die(mysql_error());

		$query = "INSERT INTO `log_tool`(`action`, `user`, `timestamp`) VALUES ('REGISTER USER: {$login}','{$_SESSION['login']}',NOW())";
		$sql2 = mysql_query($query) or die(mysql_error());
		?>
		<!--  start message-green -->
		<div id="msg">
			<div id="message-green">
			<table border="0" width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td class="green-left">New user is succesfully registered!</td>
				<td class="green-right"><a href="#" onclick="window.location.href = 'index.php?view=admin';" class="close-green"><img src="<?echo $path;?>images/table/icon_close_green.gif" alt="" /></a></td>
			</tr>
			</table>
			</div>
		</div>
		<!--  end message-green -->
		<?
	}
	else
	{
		?>
		<div id="msg">
			<div id="message-red">
			<table border="0" width="100%" cellpadding="0" cellspacing="0">
			<tr>
				<td class="red-left">Error in registration process!</td>
				<td class="red-right"><a href="#" onclick="window.location.href = 'index.php?view=admin';" class="close-red"><img src="<?echo $path;?>images/table/icon_close_red.gif" alt="" /></a></td>
			</tr>
			</table>
			</div>
			<? print $errort;?>
		</div>
		<?
		
	}

}
}
else
{
	header('Location: index.php');
}
?>