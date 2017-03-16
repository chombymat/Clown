<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="keywords" content="clown, éducatif, théâtre, prima, porta, primaporta, association, enfants, éducatif, ateliers, expression, corporelle, rire, humour, compagnie" />
<meta name="description" content="Clown Educatif est une compagnie de clown de théâtre créée en 2010 et implantée à Lille (59)." />
<title>Nous contacter ClownEducatif.com</title>
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
<script>
$(document).ready(function() {
    $('#contact_form').bootstrapValidator({
        // To use feedback icons, ensure that you use Bootstrap v3.1.0 or later
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            nom: {
                validators: {
                        stringLength: {
                        min: 2,
                    },
                        notEmpty: {
                        message: 'veuillez entrer votre nom'
                    }
                }
            },
             prenom: {
                validators: {
                     stringLength: {
                        min: 2,
                    },
                    notEmpty: {
                        message: 'veuillez entrer votre prénom'
                    }
                }
            },
            email: {
                validators: {
                    notEmpty: {
                        message: 'veuillez entrer votre addresse email'
                    },
                    emailAddress: {
                        message: 'veuillez entrer une addresse email valide'
                    }
                }
            },
            message: {
                validators: {
                      stringLength: {
                        min: 10,
                        max: 1000,
                        message:'veuillez entrer votre 10 characters au minimum et pas plus de 1000'
                    },
                    notEmpty: {
                        message: 'veuillez entrer votre message'
                    }
                    }
                }
            }
        })
        .on('success.form.bv', function(e) {
            $('#success_message').slideDown({ opacity: "show" }, "slow") // Do something ...
                $('#contact_form').data('bootstrapValidator').resetForm();

            // Prevent form submission
            e.preventDefault();

            // Get the form instance
            var $form = $(e.target);

            // Get the BootstrapValidator instance
            var bv = $form.data('bootstrapValidator');

            // Use Ajax to submit form data
            $.post($form.attr('action'), $form.serialize(), function(result) {
                console.log(result);
            }, 'json');
        });
});


</script>
</head>
<body>
<%@include file="/WEB-INF/navbar.jsp"%>
	<div class="container">

    <form class="well form-horizontal form-contact" action="./Contact" method="post"  id="contact_form">
<fieldset>

<!-- Form Name -->
<legend class="legend-contact">Contactez-nous !</legend>

<!-- Text input-->

<div class="form-group">
  <label class="col-md-4 control-label">Nom *</label>  
  <div class="col-md-4 inputGroupContainer">
  <div class="input-group">
  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
  <input name="nom" placeholder="Nom" class="form-control" type="text" required>
    </div>
  </div>
</div>

<!-- Text input-->

<div class="form-group">
  <label class="col-md-4 control-label" >Prénom *</label> 
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
  <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
  <input name="prenom" placeholder="Prénom" class="form-control" type="text" required>
    </div>
  </div>
</div>

<!-- Text input-->
       <div class="form-group">
  <label class="col-md-4 control-label">E-Mail *</label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
  <input type="email" name="email" placeholder="Adresse E-Mail" class="form-control" type="text" required>
    </div>
  </div>
</div>


<!-- Text input-->
       
<div class="form-group">
  <label class="col-md-4 control-label">Téléphone</label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
		  <input name="telephone" placeholder="03 12 34 56 78" class="form-control" type="text">
    </div>
  </div>
</div>

<!-- Text input-->
      
<div class="form-group">
  <label class="col-md-4 control-label">Addresse</label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
  <input name="adresse" placeholder="Addresse" class="form-control" type="text">
    </div>
  </div>
</div>

<!-- Text input-->
 
<div class="form-group">
  <label class="col-md-4 control-label">Ville</label>  
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-home"></i></span>
  <input name="ville" placeholder="Ville" class="form-control"  type="text">
    </div>
  </div>
</div>

<!-- Select Basic -->
   
<div class="form-group"> 
  <label class="col-md-4 control-label">Département</label>
    <div class="col-md-4 selectContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span>
    <select name="departement" class="form-control selectpicker" >
      <option value=" " >Sélectionnez votre région.</option>
      <option value="Auvergne" >Auvergne-Rhône-Alpes</option>
      <option value="Bourgogne" >Bourgogne-Franche-Comté</option>
      <option value="Bretagne">Bretagne</option>
      <option >Centre-Val de Loire</option>
      <option >Corse</option>
      <option >Grand Est</option>
      <option >Hauts-de-France</option>
      <option >Île-de-France</option>
      <option >Normandie</option>
      <option> Nouvelle-Aquitaine</option>
      <option >Occitanie</option>
      <option >Pays de la Loire</option>
      <option >Provence-Alpes-Côte d'Azur</option>
    </select>
  </div>
</div>
</div>


<!-- radio checks -->
 <div class="form-group">
                        <label class="col-md-4 control-label">Sexe ?</label>
                        <div class="col-md-4">
                            <div class="radio">
                                <label>
                                    <input type="radio" name="sexe" value="H" /> Homme
                                </label>
                            </div>
                            <div class="radio">
                                <label>
                                    <input type="radio" name="sexe" value="F" /> Femme
                                </label>
                            </div>
                        </div>
                    </div>

<!-- Text area -->
  
<div class="form-group">
  <label class="col-md-4 control-label">Votre message : *</label>
    <div class="col-md-4 inputGroupContainer">
    <div class="input-group">
        <span class="input-group-addon"><i class="glyphicon glyphicon-pencil"></i></span>
        	<textarea class="form-control" name="message" placeholder="Votre message ici ..." required></textarea>
  </div>
  </div>
</div>

<!-- Success message -->
<div class="alert alert-success" role="alert" id="success_message">Success <i class="glyphicon glyphicon-thumbs-up"></i> Merci de nous avoir contactez, nous faisons notre possible pour vous répondre rapidement.</div>

<!-- Button -->
<div class="form-group">
  <label class="col-md-4 control-label"></label>
  <div class="col-md-4">
    <button type="submit" class="btn btn-warning" >Envoyer <span class="glyphicon glyphicon-send"></span></button>
  </div>
</div>
* : Champs obligatoires.
</fieldset>
</form>
</div>
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>