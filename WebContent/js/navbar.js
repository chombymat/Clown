	$(document).ready(function()
	{
		var url = window.location.href;
		var lastIndexSlash = url.lastIndexOf('/');
		var page = url.substring(lastIndexSlash + 1, url.lastIndexOf('?') == -1 ? url.length : url.lastIndexOf('?'));

		if (page === '' || page.indexOf('index.jsp') != -1)
			$("#name").html("La compagnie la Prima Porta");
		else if (page.indexOf('Demarche') != -1)
			$("#name").html("Les démarches");
		else if (page.indexOf('Atelier') != -1)
			$("#name").html("Les ateliers");
		else if (page.indexOf('Galerie') != -1)
			$("#name").html("La galerie");
		else if (page.indexOf('infosup.jsp') != -1)
			$("#name").html("En savoir plus");
		else if (page.indexOf('partenaires.jsp') != -1)
			$("#name").html("Nos partenaires");
		else if (page.indexOf('contact.jsp') != -1)
			$("#name").html("Nous contacter");
		else if (page.indexOf('connexion.jsp') != -1)
			$("#name").html("Se connecter");
		else if (page.indexOf('inscription.jsp') != -1)
			$("#name").html("S'inscrire");
		else if (page.indexOf('Formation') != -1)
			$("#name").html("Formation");
		else if (page.indexOf('Administration') != -1)
			$("#name").html("Administration");
		else if (page.indexOf('legale.jsp') != -1)
			$("#name").html("Mentions l&eacute;gales");
		else if (page.indexOf('Article') != -1)
			$("#name").html("$ requestScope.article.getTitre() ");
		else if (page.indexOf('modifPassword.jsp') != -1)
			$("#name").html("Modification du mot de passe");
		else if (page.indexOf('refusInscription.jsp') != -1)
			$("#name").html("Demande d'inscription");
		else if (page.indexOf('confirmationInscription.jsp') != -1)
			$("#name").html("Demande d'inscription");
		else if (page.indexOf('ModifPassword') != -1)
			$("#name").html("Modification du mot de passe");
		else
			$("#name").html("Erreur");
		
		$('#bt_connexion').on('click', function(){
			window.location.replace('./connexion.jsp');
		});
		
		$('#bt_inscription').on('click', function(){
			window.location.replace('./inscription.jsp');
		});
		
		$('#bt_deconnexion').on('click', function(){
			window.location.replace('./Deconnexion');
		});
		
		$('#bt_contacter').on('click', function(){
			window.location.replace('./contact.jsp');
		});
		$('#bt_administration').on('click', function(){
			window.location.replace('./Administration');
		});
		
		(function($) {

			$('#header__icon').click(function(e){
				e.preventDefault();
				$('body').toggleClass('with--sidebar');
			});
	    
	    $('#site-cache').click(function(e){
	      $('body').removeClass('with--sidebar');
	    });

		})(jQuery);
	});