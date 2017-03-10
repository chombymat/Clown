<%@ page language="java" contentType="text/html; charset=UTF-8" import="tools.*" import="model.Modele"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<jsp:useBean id="article" scope="request" type="tools.Article"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=article.getTitre() %></title>
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
<script>
$(document).ready(function(){
	$('#bt_connexion').on('click', function(){
		document.location="./connexion.jsp";
	});
	$('#bt_contact').on('click', function(){
		document.location="./contact.jsp";
	});
});
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
	<%@include file="/WEB-INF/navbarAteliers.jsp"%>
	<div id="change"><%=article.getDescription() %><br>
	</div>
	
	<%for(Media media : article.getMedias()){
		if(media.getType().equals("img")){%>
			<img id="image" src=<%=media.getChemin()%> width="560" height="315">[photos]</img>
		<%}else if(media.getType().equals("video")){%>
			<iframe id="video" width="560" height="315" src=<%=media.getChemin() %> frameborder="0" allowfullscreen></iframe>
		<%}%>
	<%}%>
	
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>