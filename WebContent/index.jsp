<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Accueil</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
</head>
<body>
<script>
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
<p><span class="gauche"><button id="bt_contact" type="submit" class="btn btn-sample">Nous contacter</button></span><span class="droite"><button id="bt_connexion" type="submit" class="btn btn-sample">connexion</button></span><span class="droite"><button id="bt_inscription" type="submit" class="btn btn-sample">inscription</button></span><h1>Page d'accueil</h1></p>
<%@include file="/WEB-INF/navbar.jsp"%>
<h2>Le projet</h2>
<h2>L'association</h2>
<h2>Le film de 26'</h2>
<%@include file="/footer.html"%>
</body>
</html>