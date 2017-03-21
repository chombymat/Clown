<%@ page import="tools.Utilisateur,tools.Article"%>
<script>
	$(document).ready(function()
	{
		var url = window.location.href;
		var lastIndexSlash = url.lastIndexOf('/');
		var page = url.substring(lastIndexSlash + 1, url.lastIndexOf('?') == -1 ? url.length : url.lastIndexOf('?'));

		if (page === '' || page.indexOf('index.jsp') != -1)
		{
			$("#name").html("La compagnie la Prima Porta");
		} 
		if (page.indexOf('Demarche') != -1)
		{
			$("#name").html("Les démarches");
		}
		if (page.indexOf('Atelier') != -1)
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
		if (page.indexOf('legale.jsp') != -1)
		{
			$("#name").html("Mentions l&eacute;gales");
		}
		if (page.indexOf('Article') != -1)
		{
			$("#name").html("${ requestScope.article.getTitre() }");
		}
		if (page.indexOf('forgotPassword.jsp') != -1)
		{
			$("#name").html("Demande de modification de mot de passe");
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
		$('#bt_administration').on('click', function(){
			window.location.replace('./Administration');
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
	<div class="container-fluid">
	<p id="p_navbar"><span class="gauche bouton_nav"><button id="bt_contacter" class="btn btn-sample" href="./contact.jsp">Nous contacter</button></span>
			<%
			if(session.getAttribute("user") == null) 
			{
				%>
				<span class="droite bouton_nav"><button id="bt_connexion" type="submit" class="btn btn-sample">Connexion</button></span>
				<span class="droite bouton_nav"><button id="bt_inscription" type="submit" class="btn btn-sample">Inscription</button>&nbsp;</span>
				<%
			}
			else
			{
				%>
				<span class="droite bouton_nav"><button id="bt_deconnexion" type="submit" class="btn btn-sample">Déconnexion</button>&nbsp;</span>
				<!-- test administrateur ou non -->
				<% if (session.getAttribute("user") != null)
				{ 
					if(((Utilisateur)session.getAttribute("user")).getRole().equals("role4"))
					{
						%>
						<span class="droite bouton_nav"><button id="bt_administration" type="submit" class="btn btn-sample">Administration</button>&nbsp;</span>
						<% 
					}
				} %>
				<span class="droite bouton_nav" id="bonjour">Bonjour ${ user.nom } ${ user.prenom }&nbsp;&nbsp;</span>
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
            <a class="navbar-brand titre" href="./">Accueil</a>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="dropdown"><a class="dropdown-toggle titre" data-toggle="dropdown" >La démarche<span class="caret"></span></a>
			      <ul class="dropdown-menu">
    			    <li><a href="./Demarche">Présentation de la démarche</a></li>
			        <li><a href="./Demarche?page=clown">Le clown</a></li>
			        <li><a href="./Demarche?page=pratique">Pratique et sensoriel</a></li>
			        <li><a href="./Demarche?page=expression">Expression corporelle</a></li>
			      </ul>
			    </li>
				<li class="dropdown"><a class="dropdown-toggle titre" data-toggle="dropdown">Les ateliers<span class="caret"></span></a>
			      <ul class="dropdown-menu">
			      <li><a href="./Atelier">Présentation des ateliers</a></li>
			        <li><a href="./Atelier?page=pain">Atelier 1 : Le pain</a></li>
			        <li><a href="./Atelier?page=lait">Atelier 2 : Le lait</a></li>
			        <li><a href="./Atelier?page=famille">Atelier 3 : Les 7 familles</a></li>
			        <li><a href="./Atelier?page=menu">Atelier 4 : Le menu equilibré</a></li>
			        <li><a href="./Atelier?page=alimentation">Atelier 5 : Alimentation et environnement</a></li>
			        <li><a href="./Atelier?page=spectacle">Le spectacle</a></li>
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