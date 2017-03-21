<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="clown, éducatif, théâtre, prima, porta, primaporta, association, enfants, éducatif, ateliers, expression, corporelle, rire, humour, compagnie" />
<meta name="description" content="Clown Educatif est une compagnie de clown de théâtre créée en 2010 et implantée à Lille (59)." />
<title>Modification mot de passe</title>
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="./javascript/sha256.js"></script>
<link rel="stylesheet" href="style.css" />
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp" %>
	<script>
		$(document).ready(function(){
			$("#form").on('submit', function(e){
				e.preventDefault();
				
				if($('#passwordModified').val() === $('#passwordModified2').val())
				{
					var $form = $(this);
			        $.ajax({
			            url: $form.attr('action'),
			            type: $form.attr('method'),
			            data: {
			            	login : $('#login').val(),
			            	mail : $('#mail').val(),
			            	passwordModified : SHA256($('#passwordModified').val()),
			            	confirmationModifPassword : "true"
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
				}
				else
				{
					$('#erreur').html("Les mots de passe saisis ne correspondent pas.");
				}
			});
			
			$('#form').show();
		});
	</script>
	${ user.role }
	<noscript>
		<!-- Si pas de javascript pas de formulaire -->
		<p>Veuillez activer le JavaScript afin de continuer.</p>
	</noscript>
	<hr/>
 <form id="form" class="form-horizontal" method="post" action="ForgotPassword" style="display:none">
    <div class="form-group">
      <label class="control-label col-sm-4">Identifiant :</label>
      <div class="col-sm-4">
        <input id="login" type="text" class="form-control" placeholder="Identifiant" name="login" required>
      </div>
    </div>
     <div class="form-group">
      <label class="control-label col-sm-4">Mail :</label>
      <div class="col-sm-4">          
        <input id="mail" type="text" class="form-control" name="mail" placeholder="mail" required>
      </div>
    </div>
    <span id="erreur" class="erreur"></span>
    <div class="form-group">
      <label class="control-label col-sm-4">Mot de passe :</label>
      <div class="col-sm-4">          
        <input id="passwordModified" type="password" class="form-control" name="passwordModified" placeholder="Mot de passe" required>
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-4">Confirmation mot de passe :</label>
      <div class="col-sm-4">          
        <input id="passwordModified2" type="password" class="form-control" name="passwordModified2" placeholder="Mot de passe" required>
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-4 col-sm-4">
        <button type="submit" class="btn btn-sample">Modifier le mot de passe</button>
      </div>
    </div>
  </form>
  <%@include file="/WEB-INF/footer.html"%>
</body>
</html>