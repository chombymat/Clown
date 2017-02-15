<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Notre d�marche</title>
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

	<div id="menu_gauche">
		<ul>
			<li><input type="button" value="Le Clown" onclick="affiche_text('[texte] pr�sentation rapide Clown'); change_video('https://www.youtube.com/embed/ZyTw6V5JTwM');"></li>
			<li><input type="button" value="Pratique et Sensoriel" onclick="affiche_text('[texte] pr�sentation rapide Pratique et sensoriel'); change_video('https://www.youtube.com/embed/v1ixBpdhpeI');"></li>
			<li><input type="button" value="Expression Corporelle" onclick="affiche_text('[texte] pr�sentation rapide Expression corporelle'); change_video('https://www.youtube.com/embed/uU-d_DN_LZU');"></li>	
		</ul>
	</div>
	<div id="change">
		[texte] pr�sentation rapide D�marche
	</div>
	<iframe id="video" width="560" height="315" src="https://www.youtube.com/embed/_TSZe3mfGYg" frameborder="0" allowfullscreen></iframe>
	<div id="menu_droite">
		<ul>
		  <li><a href="index.jsp">Home</a></li>
		  <li><a href="atelier.jsp">Les Ateliers</a></li>
		  <li><a href="ressources.jsp">Ressources</a></li>
		</ul>
	</div>
</body>
</html>