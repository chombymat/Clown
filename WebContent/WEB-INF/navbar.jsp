<%@ page import="tools.Utilisateur"%>
<script>
$(document).ready(function() {
	$("#video").hide();

	//Dropdown
	$('ul.nav li.dropdown').hover(function() {
			  $(this).find('.dropdown-menu').stop(true, true).delay(0).fadeIn(100);
		}, function() {
			  $(this).find('.dropdown-menu').stop(true, true).delay(0).fadeOut(100);
			});
	//Redirection
	$('#bt_connexion').on('click', function(){
		document.location="./connexion.jsp";
	});
	$('#bt_contact').on('click', function(){
		document.location="./contact.jsp";
	});
	$('#bt_inscription').on('click', function(){
		document.location="./inscription.jsp";
	});
	$('#bt_deconnexion').on('click', function(){
		document.location="./Deconnexion";
	});
	//Cacher de base
	var x = document.getElementById('photos').style.display = 'none';
	var x = document.getElementById('videos').style.display = 'none';
	var x = document.getElementById('pdfs').style.display = 'none';
});
//Cacher montrer
function azer(){
	var x = document.getElementById('textes');
    if (x.style.display === 'none') {
        x.style.display = 'block';
    } else {
        x.style.display = 'none';
    }
}
/*******/
//Home
function showHome(){
	document.getElementById("textes").innerHTML = "Le projet L'association et le film de 26'";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photos").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
	document.getElementById("titre")="Index youhouhou";
}
//Démarches
function showDemPresentation(){
	document.getElementById("textes").innerHTML = "[texte] Présentation démarche";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	$('#header').html("La démarche");
}
function showDemClown(){
	document.getElementById("textes").innerHTML = "[texte] présentation rapide Clown";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	$('#header').html("La démarche");
}
function showDemSens(){
	document.getElementById("textes").innerHTML = "[texte] présentation rapide Sensoriel";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	$('#header').html("La démarche");
}
function showDemCorps(){
	document.getElementById("textes").innerHTML = "[texte] présentation rapide Corporelle";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	$('#header').html("La démarche");
}
//Ateliers et spectacle
function showAtePresentation(){
	document.getElementById("textes").innerHTML = "[texte] Présentation Ateliers et spectacle";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
	$('#header').html("Les ateliers");
}
function showAtePain(){
	document.getElementById("textes").innerHTML = "[texte] concept de l'atelier Pain";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
	$('#header').html("Les ateliers");
}
function showAteLait(){
	document.getElementById("textes").innerHTML = "[texte] concept de l'atelier Lait";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
	$('#header').html("Les ateliers");
}
function showAteFamille(){
	document.getElementById("textes").innerHTML = "[texte] concept de l'atelier Les 7 familles";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
	$('#header').html("Les ateliers");
}
function showAteMenu(){
	document.getElementById("textes").innerHTML = "[texte] concept de l'atelier Menu équilibré";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
	$('#header').html("Les ateliers");
}
function showAteAlim(){
	document.getElementById("textes").innerHTML = "[texte] concept de l'atelier Alimentation";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
	$('#header').html("Les ateliers");
}
function showAteSpect(){
	document.getElementById("textes").innerHTML = "[texte] concept du spectacle et de ses répétitions";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
	$('#header').html("Les ateliers");
}
// Ressources
function showRessources(){
	document.getElementById("textes").innerHTML = "[texte] Ressources";
	document.getElementById("video").src = "https://www.youtube.com/embed/sDj72zqZakE";
	document.getElementById("photo").src = "1.jpg";
	document.getElementById("pdf").src = "1.pdf";
	document.getElementById("ressource").src = "Coucou";
	$('#header').html("Ressources");
}
</script>
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<p id="p_navbar"><span class="gauche"><button id="bt_contact" type="submit" class="btn btn-sample">Nous contacter</button></span>
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
				<span class="droite">Bonjour ${ user.nom } ${ user.prenom }&nbsp;&nbsp;</span>
				<%
			}
			%>
			<h1 id="header">Accueil</h1></p>
			<!-- gauche -->
			<ul class="nav navbar-nav">
				<li><a href="index.jsp" onclick="showHome()">Home</a></li>
				<li class="dropdown">
	            <a href="demarche.jsp" class="dropdown-toggle" data-toggle="dropdown">La démarche <b class="caret"></b></a>
	            <ul class="dropdown-menu">
	            	<li><a href="#" onclick="showDemPresentation()">Présentation</a></li>
	            	<li><a href="#" onclick="showDemClown()">Le Clown</a></li>
	            	<li><a href="#" onclick="showDemSens()">Pratique et Sensoriel</a></li>
	            	<li><a href="#" onclick="showDemCorps()">Expression Corporelle</a></li>
	            </ul>
	            </li>
				<li class="dropdown">
	            <a href="atelier.jsp" class="dropdown-toggle" data-toggle="dropdown">Les ateliers<b class="caret"></b></a>
	            <ul class="dropdown-menu">
	            	<li><a href="#" onclick="showAtePresentation()">Présentation</a></li>
	            	<li><a href="#" onclick="showAtePain()">Le pain</a></li>
	                <li><a href="#" onclick="showAteLait()">Le lait</a></li>
	                <li><a href="#" onclick="showAteFamille()">Les 7 familles</a></li>
	                <li><a href="#" onclick="showAteMenu()">Le menu equilibré</a></li>
	                <li><a href="#" onclick="showAteAlim()">Alimentation et environement</a></li>
	                <li><a href="#" onclick="showAteSpect()">Le spectacle</a></li>
	            </ul>
	            </li>
				<li><a href="#" onclick="showRessources()">Ressources</a></li>
			</ul>
		</div>
	</div>
</nav>