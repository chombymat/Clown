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
	<p id="p_navbar"><span class="gauche"><button id="bt_contacter" class="btn btn-sample" href="./contact.jsp">Nous contacter</button></span>
			<%
			if(session.getAttribute("user") == null) 
			{
				%>
				<span class="droite"><button id="bt_connexion" type="submit" class="btn btn-sample">connexion</button></span>
				<span class="droite"><button id="bt_inscription" type="submit" class="btn btn-sample">inscription</button>&nbsp;</span>
				<%
			}
			else
			{
				%>
				<span class="droite"><button id="bt_deconnexion" type="submit" class="btn btn-sample">Déconnexion</button></span>
				<span class="droite" id="bonjour">Bonjour ${ user.nom } ${ user.prenom }&nbsp;&nbsp;</span>
				<%
			}
			%>
			<h1 id="name"></h1>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<!-- gauche -->
			<ul class="nav navbar-nav">
				<li><a href="./" class="titre">Accueil</a></li>
				<li class="dropdown"><a class="dropdown-toggle titre" data-toggle="dropdown" >La démarche<span class="caret"></span></a>
			      <ul class="dropdown-menu">
			        <li><a href="./demarche.jsp">Clown</a></li>
			        <li><a href="./demarche.jsp">Pratique et sensoriel</a></li>
			        <li><a href="./demarche.jsp">Expression corporelle</a></li>
			      </ul>
			    </li>
				<li class="dropdown"><a class="dropdown-toggle titre" data-toggle="dropdown">Les ateliers<span class="caret"></span></a>
			      <ul class="dropdown-menu">
			        <li><a href="./atelier.jsp">Le pain</a></li>
			        <li><a href="./atelier.jsp" onclick="showAteLait()">Le lait</a></li>
			        <li><a href="./atelier.jsp">Les 7 familles</a></li>
			        <li><a href="./atelier.jsp">Le menu equilibré</a></li>
			        <li><a href="./atelier.jsp">Alimentation et environnement</a></li>
			        <li><a href="./atelier.jsp">Le spectacle</a></li>
			      </ul>
			    </li>
				<li class="dropdown"><a class="dropdown-toggle titre" data-toggle="dropdown">Ressources<span class="caret"></span></a>
			      <ul class="dropdown-menu">
			        <li><a href="./Galerie">Galerie</a></li>
			        <li><a href="./infosup.jsp">Pour en savoir +</a></li>
			        <li><a href="./partenaires.jsp">Partenaires</a></li>
			      </ul>
			    </li>
			    <li><a href="./formation.jsp" class="titre">Formation</a></li>					
			</ul>
			
		</div>
	</div>
</nav>