<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="UTF-8"%>
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
		<%@include file="/WEB-INF/navbar.jsp"%>
		<div id="change">
			[texte] présentation rapide Ressources
		</div>
	</body>
	<%@include file="/footer.html"%>
</html>