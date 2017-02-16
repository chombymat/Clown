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
		
		$('ul.nav li.dropdown').hover(function() {
			  $(this).find('.dropdown-menu').stop(true, true).delay(0).fadeIn(500);
			}, function() {
			  $(this).find('.dropdown-menu').stop(true, true).delay(0).fadeOut(500);
			});
	});

</script>
		<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<!-- gauche -->
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">Home</a></li>
				<li><a href="demarche.jsp">La démarche</a></li>
				<li class="dropdown">
	            <a href="demarche.jsp" class="dropdown-toggle" data-toggle="dropdown">La démarche <b class="caret"></b></a>
	            <ul class="dropdown-menu">
	            	<li><a href="#">Le Clown</a></li>
	                <li><a href="#">Pratique et Sensoriel</a></li>
	                <li><a href="#">Expression Corporelle</a></li>
	            </ul>
	            </li>
				<li><a href="atelier.jsp">Les ateliers</a></li>
				
				<li class="dropdown">
	            <a href="atelier.jsp" class="dropdown-toggle" data-toggle="dropdown">Les ateliers<b class="caret"></b></a>
	            <ul class="dropdown-menu">
	            	<li><a href="#">Le paint</a></li>
	                <li><a href="#">Le lait</a></li>
	                <li><a href="#">Les 7 familles</a></li>
	                <li><a href="#">Le menu equilibré</a></li>
	                <li><a href="#">Alimentation et environement</a></li>
	                <li><a href="#">Le spectacle</a></li>
	            </ul>
	            </li>
				
				
				
				<li><a href="ressources.jsp">Ressources</a></li>
			</ul>
		</div>
	</div>
</nav>