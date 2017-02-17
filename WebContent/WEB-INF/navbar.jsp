<script>
	$(document).ready(function()
	{
		$('ul.nav li.dropdown').hover(function() {
			  $(this).find('.dropdown-menu').stop(true, true).delay(0).fadeIn(100);
			}, function() {
			  $(this).find('.dropdown-menu').stop(true, true).delay(0).fadeOut(100);
			});
		function affiche_text(text){
			document.getElementById("change").innerHTML = text;
		}
		
		$('#bt_connexion').on('click', function(){
			document.location="./connexion.jsp";
		});
		$('#bt_contact').on('click', function(){
			document.location="./contact.jsp";
		});
		$('#bt_inscription').on('click', function(){
			document.location="./inscription.jsp";
		});
		
		if(window.location.href.indexOf("index.jsp") > -1) {
		    document.getElementById("header").innerHTML = "Page d'accueil";
		} else if(window.location.href.indexOf("ressources.jsp") > -1){
		    document.getElementById("header").innerHTML = "Ressources";
		} else if(window.location.href.indexOf("atelier.jsp") > -1){
		    document.getElementById("header").innerHTML = "Les ateliers";
		} else if(window.location.href.indexOf("demarche.jsp") > -1){
		    document.getElementById("header").innerHTML = "La démarche";
		}
		
	});
</script>

		<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<p><span class="gauche"><button id="bt_contact" type="submit" class="btn btn-sample">Nous contacter</button></span><span class="droite"><button id="bt_connexion" type="submit" class="btn btn-sample">connexion</button></span><span class="droite"><button id="bt_inscription" type="submit" class="btn btn-sample">inscription</button></span><h1 id="header">a</h1></p>
		
			<!-- gauche -->
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">Home</a></li>
				<li class="dropdown">
	            <a href="demarche.jsp" class="dropdown-toggle" data-toggle="dropdown">La démarche <b class="caret"></b></a>
	            <ul class="dropdown-menu">
	            	<li><a href="demarche.jsp?lib=Clown" onclick="choice()">Le Clown</a></li>
	            	<li><a href="demarche.jsp?lib=Sensoriel" onclick="choice()">Pratique et Sensoriel</a></li>
	            	<li><a href="demarche.jsp?lib=Corporelle" onclick="choice()">Expression Corporelle</a></li>
	            </ul>
	            </li>
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