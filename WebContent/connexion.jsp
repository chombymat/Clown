<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>connexion</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
</head>
<body>
	<h1>Se connecter</h1>
	<hr/>
 <form class="form-horizontal" method="post" action="./connexion">
    <div class="form-group">
      <label class="control-label col-sm-4">Identifiant :</label>
      <div class="col-sm-4">
      	<span class="erreur">${ requestScope.erreur }</span>
        <input type="text" class="form-control" placeholder="Identifiant" name="login" required>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-4">Mot de passe :</label>
      <div class="col-sm-4">          
        <input type="password" class="form-control" name="pass" placeholder="Mot de passe">
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-4 col-sm-4">
        <button type="submit" class="btn btn-sample">Se connecter</button>  <button id="reset" class="btn btn-sample">Mot de passe oublié ?</button>
      </div>
    </div>
  </form>
  <%@include file="/footer.html"%>
  
</body>
</html>