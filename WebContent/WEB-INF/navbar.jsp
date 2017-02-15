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
				<li id="mur"><input class="btn btn-sample" value="Home" href="./"></li>
				<li id="mur"><input class="btn btn-sample" value="La demarche" href="./"></li>
				<li id="mur"><input class="btn btn-sample" value="Les ateliers" href="./"></li>
				<li id="mur"><input class="btn btn-sample" value="Ressources" href="./"></li>
			</ul>
		</div>
	</div>
</nav>