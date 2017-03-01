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

<%@include file="/WEB-INF/navbar.jsp"%>

<div id="textes">
<h2>Le projet</h2>
<h2>L'association</h2>
<h2>Le film de 26'</h2>
</div>
<div id="photos">
	<img id="image" width="560" height="315">[photos]</img>
</div>
<div id="videos">
	<iframe id="video" width="560" height="315" src="https://www.youtube.com/embed/_TSZe3mfGYg" frameborder="0" allowfullscreen></iframe>[vidéo]
</div>
<div id="pdfs">
	<iframe id="pdf" src="http://tadao.fr/upload/circuits_scolaires/39.pdf" width="600" height="800" align="middle"></iframe>
	Ici le(s) pdf(s)
</div>
<%@include file="/WEB-INF/footer.html"%>
</body>
</html>