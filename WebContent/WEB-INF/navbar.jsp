<%@ page import="tools.Utilisateur"%>
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
		
		$('#bt_connexion').on('click', function(){
			window.location.replace('./connexion.jsp');
		});
		
		$('#bt_inscription').on('click', function(){
			window.location.replace('./inscription.jsp');
		});
		
		$('#bt_deconnexion').on('click', function(){
			window.location.replace('./deconnexion.jsp');
		});
	});
</script>
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav navbar-left" >
			<li><a href="./contact.jsp">Nous contacter</a></li>
			</ul>
			<!-- gauche -->
			<ul class="nav navbar-nav">
				<li id="mur"><a href="./">Accueil</a></li>
				<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown">La d�marche<span class="caret"></span></a>
			      <ul class="dropdown-menu">
			        <li><a href="./demarche.jsp">Clown</a></li>
			        <li><a href="./demarche.jsp">Pratique et sensoriel</a></li>
			        <li><a href="./demarche.jsp">Expression corporelle</a></li>
			      </ul>
			    </li>
				<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown">Les ateliers<span class="caret"></span></a>
			      <ul class="dropdown-menu">
			        <li><a href="./atelier.jsp">Le pain</a></li>
			        <li><a href="./atelier.jsp">Le lait</a></li>
			        <li><a href="./atelier.jsp">Les 7 familles</a></li>
			        <li><a href="./atelier.jsp">Le menu equilibr�</a></li>
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
					%><li><button id="bt_deconnexion" class="btn btn-sample" >D�connexion</button></li><%
				}
				%>
			</ul>
		</div>
	</div>
</nav>