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
				<li id="accueil"><a class="navbar-brand" href="./"><img alt="tweetbook logo" src="tweetbookLogo.png" width="auto" height="100%"></a></li>
				<%
				if (request.getUserPrincipal() != null) 
				{
					%>
					<li id="mur"><a href="./mur">Mur</a></li>
					<li id="profil"><a href="./profil?idUser=<%= session.getAttribute("idUser") %>">Mon profil</a></li>
					<li id="amis"><a href="./amis">Mes amis</a></li>
					<li id="param"><a href="param">Paramètres</a></li>					
					<%
				} 
				%>
			</ul>
			
			<!--  droite -->
			<ul class="nav navbar-nav navbar-right" >
			<li><a class="navbar-brand" href="http://www.univ-lille1.fr/"><img alt="logo de lille 1" src="ulille.svg" width="auto" height="100%"></a></li>
			<li><a class="navbar-brand" href="http://www.iut.univ-lille1.fr/"><img alt="logo de l'iut a de lille 1" src="logo-iut-lille1.svg" width="auto" height="100%"></a></li>
			<li><a class="navbar-brand" href="https://da2i.univ-lille1.fr/"><img alt="logo de l'iut a de lille 1" src="logo-da2i.svg" width="auto" height="100%"></a></li>
			
				<%
				if (request.getUserPrincipal() == null) 
				{
					%>
					<li id="inscription"><a href="./inscription">Inscription</a></li>
					<li id="connexion"><a href="./connexion">Connexion</a></li>
					<%
				} 
				else 
				{
					%><li><a href="./deconnexion">Déconnexion</a></li><%
				}
				%>
			</ul>
		</div>
	</div>
</nav>