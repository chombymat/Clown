<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="clown, éducatif, théâtre, prima, porta, primaporta, association, enfants, éducatif, ateliers, expression, corporelle, rire, humour, compagnie" />
<meta name="description" content="Clown Educatif est une compagnie de clown de théâtre créée en 2010 et implantée à Lille (59)." />
<title>Connectez-vous ClownEducatif.com</title>
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="./js/sha256.js"></script>
<link rel="stylesheet" href="style.css" />
</head>
<body>
	<%@include file="/WEB-INF/navbar.jsp"%>
	<script>
		$(document).ready(function(){
			$("#form").on('submit', function(e){
				e.preventDefault();
				
				var $form = $(this);
		        $.ajax({
		            url: $form.attr('action'),
		            type: $form.attr('method'),
		            data: {
		            	login : SHA256($('#login').val()),
		            	pass : SHA256($('#pass').val())
		            },
		            success : function(data, textStatus, jqXHR)
		            {
		            	if(data === "ok")
		            	{
		            		window.location.replace("./");
		            	}
		            	else if(data === "fail")
		            	{
		            		$('#erreur').html("Identifiant/mot de passe incorrect");         	
		            	}
		            }
		        });
			});
			
			$('#form').show();
		});
	</script>
	${ user.role }
	<noscript>
		<!-- Si pas de javascript pas de formulaire -->
		<p>Veuillez activer le JavaScript afin de continuer.</p>
	</noscript>
	<hr />
	<form id="form" class="form-horizontal" method="post" action="./connexion" style="display: none">
		<div class="form-group">
			<label class="control-label col-sm-4">Identifiant :</label>
			<div class="col-sm-4">
				<span id="erreur" class="erreur"></span> <input id="login" type="text" class="form-control" placeholder="Identifiant" name="login" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-4">Mot de passe :</label>
			<div class="col-sm-4">
				<input id="pass" type="password" class="form-control" name="pass" placeholder="Mot de passe">
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-4 col-sm-4">
				<button type="submit" class="btn btn-sample">Se connecter</button>
			</div>
		</div>
	</form>
	<a href="./ModifPassword"><button class="btn btn-sample">Mot de passe oublié ?</button></a>
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>