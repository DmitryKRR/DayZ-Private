<? 
if (isset($_SESSION['user_id']))
{
?>
<!--  start nav-outer-repeat................................................................................................. START -->
<div class="nav-outer-repeat"> 
<!--  start nav-outer -->
<div class="nav-outer"> 

		<!-- start nav-right -->
		<div id="nav-right">
		
			<div class="nav-divider">&nbsp;</div>
			<!-- <div class="showhide-account"><img src="images/shared/nav/nav_myaccount.gif" width="93" height="14" alt="" /></div>
			<a href="/index.php?view=register" id="logout"><img src="images/shared/nav/nav_myaccount.gif" width="64" height="14" alt="" /></a>
			<div class="nav-divider">&nbsp;</div>-->
			<a href="index.php?logout" id="logout"><img src="<?echo $path;?>images/shared/nav/nav_logout.gif" width="64" height="14" alt="" /></a>
			<div class="clear">&nbsp;</div>
		
			<!--  start account-content -->	
			<div class="account-content">
			<div class="account-drop-inner">
				<a href="" id="acc-settings">Settings</a>
				<div class="clear">&nbsp;</div>
				<div class="acc-line">&nbsp;</div>
				<a href="" id="acc-details">Personal details </a>
				<div class="clear">&nbsp;</div>
				<div class="acc-line">&nbsp;</div>
				<a href="" id="acc-project">Project details</a>
				<div class="clear">&nbsp;</div>
				<div class="acc-line">&nbsp;</div>
				<a href="" id="acc-inbox">Inbox</a>
				<div class="clear">&nbsp;</div>
				<div class="acc-line">&nbsp;</div>
				<a href="" id="acc-stats">Statistics</a> 
			</div>
			</div>
			<!--  end account-content -->
		
		</div>
		<!-- end nav-right -->


		<!--  start nav -->
		<div class="mc-nav">
			<div class="table">
				<ul class="select menutop level1">
				<li class="li-dashboard root active"><a href="index.php" style="color:#FFF;" class="dashboard item">Dashboard</a></li>
				<li class="li-users parent root"><span class=" daddy item"><span>Control</span></span>
					<ul class="level2 parent-users">
						<li class="li-mass-mail-users"><a href="index.php?view=admin" class="class:massmail item">Admins</a></li>
						<li class="li- separator"><span></span></li>
						<li class="li-mass-mail-users"><a href="index.php?view=control" class="class:massmail item">Start/Stop</a></li>
					</ul>
				</li>
				<li class="li-users parent root"><span class=" daddy item"><span>Entities</span></span>
					<ul class="level2 parent-users">
						<li class="li-user-manager parent"><a href="#nogo" class="class:user daddy item">Players</a>
							<ul class="level3 parent-user-manager">
								<li class="li-add-new-user"><a href="index.php?view=table&show=0" class="class:newarticle item">Online</a></li>
								<li class="li-add-new-user"><a href="index.php?view=table&show=1" class="class:newarticle item">Alive</a></li>
								<li class="li-add-new-user"><a href="index.php?view=table&show=2" class="class:newarticle item">Dead</a></li>
								<li class="li-add-new-user"><a href="index.php?view=table&show=3" class="class:newarticle item">All</a></li>
							</ul>
						</li>
						<li class="li-groups parent"><a href="#nogo" class="class:groups daddy item">Vehicles</a>
							<ul class="level3 parent-groups">
								<li class="li-add-new-group"><a href="index.php?view=table&show=4" class="class:newarticle item">Ingame</a></li>
								<li class="li-add-new-group"><a href="index.php?view=table&show=5" class="class:newarticle item">Spawn locations</a></li>
							</ul>
						</li>						
						<li class="li- separator"><span></span></li>
						<li class="li-mass-mail-users"><a href="index.php?view=check" class="class:massmail item">Check items</a></li>
						<li class="li- separator"><span></span></li>
						<li class="li-mass-mail-users"><a href="index.php?view=search" class="class:massmail item">Search</a></li>
					</ul>
				</li>
				<li class="li-users parent root"><span class=" daddy item"><span>Map view</span></span>
					<ul class="level2 parent-users">
						<li class="li-user-manager parent"><a href="#nogo" class="class:user daddy item">Players</a>
							<ul class="level3 parent-user-manager">
								<li class="li-add-new-user"><a href="index.php?view=map&show=0" class="class:newarticle item">Online</a></li>
								<li class="li-add-new-user"><a href="index.php?view=map&show=1" class="class:newarticle item">Alive</a></li>
								<li class="li-add-new-user"><a href="index.php?view=map&show=2" class="class:newarticle item">Dead</a></li>
								<li class="li-add-new-user"><a href="index.php?view=map&show=3" class="class:newarticle item">All</a></li>
							</ul>
						</li>
						<li class="li-groups parent"><a href="#nogo" class="class:groups daddy item">Vehicles</a>
							<ul class="level3 parent-groups">
								<li class="li-add-new-group"><a href="index.php?view=map&show=4" class="class:newarticle item">Ingame</a></li>
								<li class="li-add-new-group"><a href="index.php?view=map&show=5" class="class:newarticle item">Spawn locations</a></li>
							</ul>
						</li>
					</ul>
				</li>
				</ul>
				<div class="clear"></div>
			</div>
			<div class="clear"></div>
		</div>
		<!--  start nav -->



</div>
<div class="clear"></div>
<!--  start nav-outer -->
</div>
<!--  start nav-outer-repeat................................................... END -->
<?
}
else
{
	header('Location: index.php');
}
?>