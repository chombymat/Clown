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
<%@include file="/WEB-INF/navbar.jsp"%>
	<div id="change">
		<form class="form-horizontal" method="post" action="./connexion">
		   <div class="form-group">
		     <label class="control-label col-sm-5">Civilité:</label>
		     <div class="col-sm-2 col-md-3">          
		       <input type="radio" class="btn btn-sample" name="gender">Monsieur<br>
		       <input type="radio" class="btn btn-sample" name="gender">Madame
		     </div>
		   </div>
		   <div class="form-group">
		     <label class="control-label col-sm-5">Identifiant:</label>
		     <div class="col-sm-2 col-md-3">
		     	<span class="erreur">${ requestScope.erreur }</span>
		       <input type="text" class="form-control" placeholder="Identifiant" name="login" required>
		     </div>
		   </div>
		   <div class="form-group">
		     <label class="control-label col-sm-5">Mot de passe:</label>
		     <div class="col-sm-2 col-md-3">          
		       <input type="password" class="form-control" name="pass" placeholder="Mot de passe">
		     </div>
		   </div>
		   <div class="form-group">        
		     <div class="col-sm-offset-2 col-sm-8">
		       <button type="submit" class="btn btn-sample">Se connecter</button>  <button id="reset" class="btn btn-sample">Mot de passe oublié ?</button>
		     </div>
		   </div>
		</form>
	</div>
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>