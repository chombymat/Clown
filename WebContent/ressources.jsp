<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Notre d�marche</title>
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
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
			<li><input type="button" value="Le Clown" onclick="affiche_text('[diapo photos]'); change_video('https://www.youtube.com/embed/ZyTw6V5JTwM');"></li>
			<li><input type="button" value="Pratique et Sensoriel" onclick="affiche_text('[texte] lien vers autres sites'); change_video('https://www.youtube.com/embed/v1ixBpdhpeI');"></li>
			<li><input type="button" value="Expression Corporelle" onclick="affiche_text('[texte] pr�sentation Comit� Technique / pr�sentation partenaires financiers [lien] vers autres sites'); change_video('https://www.youtube.com/embed/uU-d_DN_LZU');"></li>	
		</ul>
	</div>
	<div id="change">
		[texte] pr�sentation rapide Ressources
	</div>
	<div id="menu_droite">
		<ul>
		  <li><a href="index.jsp">Home</a></li>
		  <li><a href="demarche.jsp">La D�marche</a></li>
		  <li><a href="atelier.jsp">Ateliers</a></li>
		</ul>
	</div>
</body>
</html>