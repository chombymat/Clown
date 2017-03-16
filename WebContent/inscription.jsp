<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="clown, éducatif, théâtre, prima, porta, primaporta, association, enfants, éducatif, ateliers, expression, corporelle, rire, humour, compagnie" />
<meta name="description" content="Clown Educatif est une compagnie de clown de théâtre créée en 2010 et implantée à Lille (59)." />
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="./javascript/sha256.js"></script>
<link rel="stylesheet" href="style.css" />
<title>Inscrivez-vous ClownEducatif.com</title>
</head>
<body>
	<%@include file="/WEB-INF/navbar.jsp" %>
	<script>
		$(document).ready(function()
		{

			$("#form").on('submit', function(e)
			{
				e.preventDefault();
				
				$('#erreur_mail').html("");
				$('#erreur_login').html("");

				if($('#pass').val() === $('#pass2').val())
				{
					var $form = $(this);

			        $.ajax({
			            url: $form.attr('action'),
			            type: $form.attr('method'),
			            data: {
			            	inscriptionLogin : $('#inscriptionLogin').val(),
			            	inscriptionPass : SHA256($('#pass').val()),
			            	inscriptionNom : $('#inscriptionNom').val(),
			            	inscriptionPrenom : $('#inscriptionPrenom').val(),
			            	inscriptionMail : $('#mail').val(),
			            	initialisation : "true"
			            },
			            success : function(data, textStatus, jqXHR){
			            	console.log(data);

			            	if(data === "inscription ok"){
			            		$('#success_message').show();         	
			            		$("#form")[0].reset();
			            	} else if(data === "mail existant"){
			            		$('#erreur').html("");
			            		$('#erreur_login').html("");
			            		$('#erreur_mail').html("Adresse email déjà existante.");         	
			            	} else if(data === "login existant"){
			            		$('#erreur').html("");
			            		$('#erreur_mail').html("");
			            		$('#erreur_login').html("Identifiant déjà existant.");
			            	}
			            }
			        });
				}
				else
				{
            		$('#erreur_login').html("");
            		$('#erreur_mail').html("");
					$('#erreur').html("Les mots de passe saisie ne correspondent pas.");
				}
			});
			
			$('#form').show();
		});
	</script>
	<hr/>
	<noscript>
		<!-- Si pas de javascript pas de formulaire -->
		<p>Veuillez activer le JavaScript afin de continuer.</p>
	</noscript>
	<form id="form" class="form-horizontal form-inscription" method="post" action="./Inscription">
		<span id="erreur_login" class="erreur">${ erreur }</span>
		<div class="form-group">
			<label class="control-label col-sm-5">Identifiant:</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" placeholder="Identifiant" id="inscriptionLogin" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5">Nom:</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" placeholder="Nom" id="inscriptionNom" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5">Prénom:</label>
			<div class="col-sm-2">
				<input type="text" class="form-control" placeholder="Prénom" id="inscriptionPrenom" required>
			</div>
		</div>
		<span id="erreur" class="erreur">${ erreur }</span>
		<div class="form-group">
			<label class="control-label col-sm-5">Mot de passe:</label>
			<div class="col-sm-2">
				<input id="pass" type="password" class="form-control" placeholder="Mot de passe" minlength="8" maxlength="16" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5">Confirmation du mot de passe:</label>
			<div class="col-sm-2">
				<input id="pass2" type="password" class="form-control" placeholder="Confirmer le Mot de passe" minlength="8" maxlength="16" required>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-5" for="email">Email:</label>
			<div class="col-sm-2">
			<span id="erreur_mail" class="erreur">${ erreur }</span>
				<input type="email" class="form-control" id="mail" placeholder="Entrer Email" required>
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-5 col-sm-2">
				<button type="submit" class="btn btn-sample">S'inscrire</button>
			</div>
		</div>
	</form>
	<div class="alert alert-success" role="alert" id="success_message"><i class="glyphicon glyphicon-thumbs-up"></i> Votre inscription a été pris en compte, nous faisons notre possible pour vous répondre rapidement par mail.</div>
		
	<%@include file="/WEB-INF/footer.html"%>
	
	</body>
</html>