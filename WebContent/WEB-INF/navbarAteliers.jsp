<script>
function changeClown(){
	document.getElementById("change").innerHTML = "[texte] pr�sentation rapide Clown";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
}
function changeSensoriel(){
	document.getElementById("change").innerHTML = "[texte] pr�sentation rapide Sensoriel";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
}
function changeCorporelle(){
	document.getElementById("change").innerHTML = "[texte] pr�sentation rapide Corporelle";
	document.getElementById("video").src="https://www.youtube.com/embed/sDj72zqZakE";
}
//Ateliers et spectacle
function changePain(){
	document.getElementById("change").innerHTML = "[texte] concept de l'atelier Pain";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
}
function changeLait(){
	document.getElementById("change").innerHTML = "[texte] concept de l'atelier Lait";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
}
function changeFamille(){
	document.getElementById("change").innerHTML = "[texte] concept de l'atelier Les 7 familles";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
}
function changeEquilibre(){
	document.getElementById("change").innerHTML = "[texte] concept de l'atelier Menu �quilibr�";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
}
function changeAlimentation(){
	document.getElementById("change").innerHTML = "[texte] concept de l'atelier Alimentation";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
}
function changeSpectacle(){
	document.getElementById("change").innerHTML = "[texte] concept du spectacle et de ses r�p�titions";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
}
/*******/
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
	$('ul.nav li.dropdown').hover(function() {
		  $(this).find('.dropdown-menu').stop(true, true).delay(0).fadeIn(100);
	}, function() {
	  $(this).find('.dropdown-menu').stop(true, true).delay(0).fadeOut(100);
	});
	
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
</script>
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<p><span class="gauche"><button id="bt_contact" type="submit" class="btn btn-sample">Nous contacter</button></span><span class="droite"><button id="bt_connexion" type="submit" class="btn btn-sample">Connexion</button></span><span class="droite"><button id="bt_inscription" type="submit" class="btn btn-sample">Inscription</button></span><h1 id="ressource" onload="displayResult()">Ressource</h1></p>
			<!-- gauche -->
			<ul class="nav navbar-nav">
				<li><a href="index.jsp">Home</a></li>
				<li class="dropdown">
	            <a href="demarche.jsp" class="dropdown-toggle" data-toggle="dropdown">La d�marche <b class="caret"></b></a>
	            <ul class="dropdown-menu">
	            	<li><a onclick="changeClown()">Le Clown</a></li>
	            	<li><a onclick="changeSensoriel()">Pratique et Sensoriel</a></li>
	            	<li><a onclick="changeCorporelle()">Expression Corporelle</a></li>
	            </ul>
	            </li>
				<li class="dropdown">
	            <a href="atelier.jsp" class="dropdown-toggle" data-toggle="dropdown">Les ateliers<b class="caret"></b></a>
	            <ul class="dropdown-menu">
	            	<li><a onclick="changePain()">Le pain</a></li>
	                <li><a onclick="changeLait()">Le lait</a></li>
	                <li><a onclick="changeFamille()">Les 7 familles</a></li>
	                <li><a onclick="changeEquilibre()">Menu equilibr�</a></li>
	                <li><a onclick="changeAlimentation()">Alimentation et environement</a></li>
	                <li><a onclick="changeSpectacle()">Spectacle</a></li>
	            </ul>
	            </li>
				<li><a href="ressources.jsp">Ressources</a></li>
			</ul>
		</div>
	</div>
</nav>