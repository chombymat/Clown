<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
<title>Inscription</title>
</head>
<body>
	<h1>Inscription</h1>
	<hr/>
	<form class="form-horizontal" method="post" action="./Inscription">
		<div class="form-group">
			<label class="control-label col-sm-5">Identifiant:</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" placeholder="Identifiant" name="inscriptionLogin" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5">Nom:</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" placeholder="Nom" name="inscriptionNom" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5">Prénom:</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" placeholder="Prénom" name="inscriptionPrenom" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5">Mot de passe:</label>
			<div class="col-sm-2">
				<input type="password" class="form-control" name="inscriptionPass" placeholder="Mot de passe" minlength="8" maxlength="16" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5">Confirmation du mot de passe:</label>
			<div class="col-sm-2">
				<input type="password" class="form-control" name="inscriptionPass2" placeholder="Confirmer le Mot de passe" minlength="8" maxlength="16" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5" for="email">Email:</label>
			<div class="col-sm-2">
				<input type="email" class="form-control" name="inscriptionMail" placeholder="Entrer Email" required>
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-5 col-sm-2">
				<button type="submit" class="btn btn-sample">S'inscrire</button>
			</div>
		</div>
	</form>
	<%@include file="/footer.html"%>
	
	</body>
</html>