<%@ page import="tools.Utilisateur"%>
<script>
	$(document).ready(function()
	{
		var url = window.location.href;
		var lastIndexSlash = url.lastIndexOf('/');
		var page = url.substring(lastIndexSlash + 1, url.lastIndexOf('?') == -1 ? url.length : url.lastIndexOf('?'));

		if (page === '' || page.indexOf('index.jsp') != -1)
		{
			$("#name").html("Accueil");
		} 
		if (page.indexOf('demarche.jsp') != -1)
		{
			$("#name").html("Les démarches");
		}
		if (page.indexOf('atelier.jsp') != -1)
		{
			$("#name").html("Les ateliers");
		}
		if (page.indexOf('galerie.jsp') != -1)
		{
			$("#name").html("La galerie");
		}
		if (page.indexOf('infosup.jsp') != -1)
		{
			$("#name").html("En savoir plus");
		}
		if (page.indexOf('partenaires.jsp') != -1)
		{
			$("#name").html("Nos partenaires");
		}
		if (page.indexOf('contact.jsp') != -1)
		{
			$("#name").html("Nous contacter");
		}
		if (page.indexOf('connexion.jsp') != -1)
		{
			$("#name").html("Se connecter");
		}
		if (page.indexOf('inscription.jsp') != -1)
		{
			$("#name").html("S'inscrire");
		}
		if (page.indexOf('formation.jsp') != -1)
		{
			$("#name").html("Formation");
		}
		
		$('#bt_connexion').on('click', function(){
			window.location.replace('./connexion.jsp');
		});
		
		$('#bt_inscription').on('click', function(){
			window.location.replace('./inscription.jsp');
		});
		
		$('#bt_deconnexion').on('click', function(){
			window.location.replace('./Deconnexion');
		});
		
		$('#bt_contacter').on('click', function(){
			window.location.replace('./contact.jsp');
		});
	});
</script>
<nav class="navbar navbar-default">
	<div class="container-fluid">
	<h2 id="name"></h2>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav navbar-left" >
			<li><button id="bt_contacter" class="btn btn-sample"href="./contact.jsp">Nous contacter</button></li>
			</ul>
			<!-- gauche -->
			<ul class="nav navbar-nav">
				<li><a href="./">Accueil</a></li>
				<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown">La démarche<span class="caret"></span></a>
			      <ul class="dropdown-menu">
			        <li><a href="./demarche.jsp">Clown</a></li>
			        <li><a href="./demarche.jsp">Pratique et sensoriel</a></li>
			        <li><a href="./demarche.jsp">Expression corporelle</a></li>
			      </ul>
			    </li>
				<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown">Les ateliers<span class="caret"></span></a>
			      <ul class="dropdown-menu">
			        <li><a href="./atelier.jsp">Le pain</a></li>
			        <li><a href="./atelier.jsp" onclick="showAteLait()">Le lait</a></li>
			        <li><a href="./atelier.jsp">Les 7 familles</a></li>
			        <li><a href="./atelier.jsp">Le menu equilibré</a></li>
			        <li><a href="./atelier.jsp">Alimentation et environnement</a></li>
			        <li><a href="./atelier.jsp">Le spectacle</a></li>
			      </ul>
			    </li>
				<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown">Ressources<span class="caret"></span></a>
			      <ul class="dropdown-menu">
			        <li><a href="./galerie.jsp">Galerie</a></li>
			        <li><a href="./infosup.jsp">Pour en savoir +</a></li>
			        <li><a href="./partenaires.jsp">Partenaires</a></li>
			      </ul>
			    </li>
			    <li><a href="./formation.jsp">Formation</a></li>					
			</ul>
			
			<!--  droite -->
			<ul class="nav navbar-nav navbar-right" >
			<!-- <li><a class="navbar-brand" href="https://da2i.univ-lille1.fr/"><img alt="logo de l'iut a de lille 1" src="logo-da2i.svg" width="auto" height="100%"></a></li>-->
			
				<%
				if (session.getAttribute("user") == null) 
				{
					%>
					<li><button id="bt_connexion" class="btn btn-sample" >Connexion</button></li>
					<li><button id="bt_inscription" class="btn btn-sample" >Inscription</button></li>
					<%
				} 
				else 
				{
					%>
					<li>Bonjour ${ sessionScope.user.nom } ${ sessionScope.user.prenom }&nbsp&nbsp</li>
					<li><button id="bt_deconnexion" class="btn btn-sample" >Déconnexion</button></li>
					<%
				}
				%>
			</ul>
		</div>
	</div>
</nav>