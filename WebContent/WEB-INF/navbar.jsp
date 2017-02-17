<script>
	$(document).ready(function()
	{
		var url = window.location.href;
		var lastIndexSlash = url.lastIndexOf('/');
		var page = url.substring(lastIndexSlash + 1, url.lastIndexOf('?') == -1 ? url.length : url.lastIndexOf('?'));
		$("#video").hide();
		if (page === '')
		{
			$("#accueil").attr('class', 'active');
		} else
		{
			$("#" + page).attr('class', 'active');
		}
		
		var url = window.location.href;
		var captured = /lib=([^&]+)/.exec(url)[1];
		var result = captured ? captured : 'myDefaultValue';
		//Changer ici le contenu des démarches
		switch(result){
			case "Clown":
				document.getElementById("change").innerHTML = "[texte] présentation rapide Clown";
				document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
				break;
			case "Sensoriel":
				document.getElementById("change").innerHTML = "[texte] présentation rapide Sensoriel";
				document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
				break;
			case "Corporelle":
				document.getElementById("change").innerHTML = "[texte] présentation rapide Corporelle";
				document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
				break;
			default:
				document.getElementById("change").innerHTML = "De base";
				document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
				break;
		}
		
		$('ul.nav li.dropdown').hover(function() {
			  $(this).find('.dropdown-menu').stop(true, true).delay(0).fadeIn(100);
			}, function() {
			  $(this).find('.dropdown-menu').stop(true, true).delay(0).fadeOut(100);
			});
		function affiche_text(text){
			document.getElementById("change").innerHTML = text;
		}
		
		
	});

	$(document).ready(function(){
		$('#bt_connexion').on('click', function(){
			document.location="./connexion.jsp";
		});
		$('#bt_contact').on('click', function(){
			document.location="./contact.jsp";
		});
		$('#bt_inscription').on('click', function(){
			document.location="./inscription.jsp";
		});
	});
	
	function displayResult() {
	    document.getElementById("ressource").innerHTML = "Have a nice day!";
	}
</script>

		<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<p><span class="gauche"><button id="bt_contact" type="submit" class="btn btn-sample">Nous contacter</button></span><span class="droite"><button id="bt_connexion" type="submit" class="btn btn-sample">connexion</button></span><span class="droite"><button id="bt_inscription" type="submit" class="btn btn-sample">inscription</button></span><h1 id="ressource" onload="displayResult()">Ressource</h1></p>
		
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