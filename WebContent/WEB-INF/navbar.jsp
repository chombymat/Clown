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
		if (page.indexOf('Galerie') != -1)
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
		if (page.indexOf('Administration') != -1)
		{
			$("#name").html("Administration");
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
		
		(function($) {

			$('#header__icon').click(function(e){
				e.preventDefault();
				$('body').toggleClass('with--sidebar');
			});
	    
	    $('#site-cache').click(function(e){
	      $('body').removeClass('with--sidebar');
	    });

		})(jQuery);
	});
</script>
<nav class="navbar navbar-default">
	<div id="navbar" class="container-fluid">
	
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

      <!-- Static navbar -->
      <nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="./">Accueil</a>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
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
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    </div>
</nav>