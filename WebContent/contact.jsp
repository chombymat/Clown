<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Notre démarche</title>
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
<script language="JavaScript">
function affiche_text(text){
	document.getElementById("change").innerHTML = text;
}
function change_video(url){
	document.getElementById("video").src = url;
}
function cacher(id){
	document.getElementById(id).style.display = 'none';
}
</script>
</head>
<body>
<p><span class="gauche"><button type="submit" class="btn btn-sample">Nous contacter</button></span><span class="droite"><button type="submit" class="btn btn-sample">connexion</button></span><h1>Nous Contacter</h1></p>
		<%@include file="/WEB-INF/navbar.jsp"%>
	<div id="menu_gauche">
		<ul>
		  <li><img src="http://www.coloriage.tv/dessincolo/clown.png" width="100" height="100" onclick="affiche_text('[diapo photos]');"/></li>
		  <li><img src="http://blog.retif.eu/wp-content/uploads/2014/07/marketing-sensoriel.jpg" width="100" height="100" onclick="affiche_text('[texte] lien vers autres sites');"/></li>
		  <li><img src="http://www.mjcteyran.fr/images/stories/expression_corporelle.jpg" width="100" height="100" onclick="affiche_text('[texte] présentation Comité Technique / présentation partenaires financiers [lien] vers autres sites');"/></li>
		</ul>
	</div>
	<div id="change">
		<p>Merci de votre visite<br>
		Formulaire de contact<br>
		OU<br>
		adresse mail</p>
	</div>
</body>
</html>