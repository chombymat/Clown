$(document).ready(function(){

	$("#form").on('submit', function(e){
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
					inscriptionLogin : SHA256($('#inscriptionLogin').val()),
					inscriptionPass : SHA256($('#pass').val()),
					inscriptionNom : $('#inscriptionNom').val(),
					inscriptionPrenom : $('#inscriptionPrenom').val(),
					inscriptionMail : $('#mail').val(),
					initialisation : "true"
				},
				success : function(data, textStatus, jqXHR){
					console.log(data);

					if(data === "mail existant"){
						$('#erreur').html("");
						$('#erreur_login').html("");
						$('#erreur_mail').html("Adresse email déjà existante."); 
					} else if(data === "exception"){
						$('#erreur').html("Un problème est survenu lors de l'inscription");
						$('#erreur_login').html("");
						$('#erreur_mail').html("");   
					} else if(data === "login existant"){
						$('#erreur').html("");
						$('#erreur_mail').html("");
						$('#erreur_login').html("Identifiant déjà existant.");
					} else {
						$('#success_message').show();         	
						$("#form")[0].reset();
					}

				}
			});
		}
		else
		{
			$('#erreur_login').html("");
			$('#erreur_mail').html("");
			$('#erreur').html("Les mots de passe saisis ne correspondent pas.");
		}
	});

	$('#form').show();
});