<script>
	$(document).ready(function()
	{
		var url = window.location.href;
		var lastIndexSlash = url.lastIndexOf('/');
		var page = url.substring(lastIndexSlash + 1, url.lastIndexOf('?') == -1 ? url.length : url.lastIndexOf('?'));

		if (page === '')
		{
			$("#accueil").attr('class', 'active');
		} else
		{
			$("#" + page).attr('class', 'active');
		}
	});
</script>
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<!-- gauche -->
			<ul class="nav navbar-nav">
				<li id="inscription"><a href="Home">Home</a></li>
				<li id="inscription"><a href="demarche">La demarche</a></li>
				<li id="inscription"><a href="ateliers">Les ateliers</a></li>
				<li id="inscription"><a href="Ressources">Ressources</a></li>
			</ul>
		</div>
	</div>
</nav>