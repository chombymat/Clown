<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="keywords" content="clown, éducatif, théâtre, prima, porta, primaporta, association, enfants, éducatif, ateliers, expression, corporelle, rire, humour, compagnie" />
<meta name="description" content="Clown Educatif est une compagnie de clown de théâtre créée en 2010 et implantée à Lille (59)." />
<title>Notre démarche ClownEducatif.com</title>
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
<script>
var show_per_page = 18;
var current_page = 0;

function set_display(first, last) {
	$('#content').children().css('display', 'none');
	$('#content').children().slice(first, last).css('display', 'block');
}

function previous() {
	if ($('.active').prev('.page_link').length)
		go_to_page(current_page - 1);
}

function next() {
	if ($('.active').next('.page_link').length)
		go_to_page(current_page + 1);
}

function go_to_page(page_num) {
	current_page = page_num;
	start_from = current_page * show_per_page;
	end_on = start_from + show_per_page;
	set_display(start_from, end_on);
	$('.active').removeClass('active');
	$('#id' + page_num).addClass('active');
}

$(document).ready(function() {
					$('#presentation_clown').hide();
					$('#les_clowns').hide();
					$('#pratique').hide();
					$('#expression').hide();
					if(location.search == "?page=clown"){
						$('#presentation_clown').show();
						$('#les_clowns').show();
						$('#textDemarche').hide();
						$('#pratique').hide();
						$('#expression').hide();
					}
					if(location.search == "?page=pratique"){
						$('#presentation_clown').hide();
						$('#textDemarche').hide();
						$('#les_clowns').hide();
						$('#pratique').show();
						$('#expression').hide();
					}
					if(location.search == "?page=expression"){
						$('#presentation_clown').hide();
						$('#textDemarche').hide();
						$('#les_clowns').hide();
						$('#pratique').hide();
						$('#expression').show();
					}
	
					var modal = document.getElementById('myModal');
					
					// Get the <span> element that closes the modal
					var span = document.getElementsByClassName("close")[0];

					// When the user clicks on <span> (x), close the modal
					$('.myImg').on('click', function() {
						$('html, body').css({
							overflow : 'hidden',
							height : '100%'
						});
						$('#myModal').attr('style', 'display: block');
						$('#img01').attr('src', $(this).attr('src'));
						$('#caption').html($(this).attr('alt'));
						$('#id' + current_page).removeClass('active');
					});
					
					span.onclick = function() {
						$('html, body').css({
							overflow : 'auto',
							height : 'auto'
						});
						modal.style.display = "none";
						$('#id' + current_page).addClass('active');
					}


					var number_of_pages = Math.ceil($('#content')
							.children().length
							/ show_per_page);

					var nav = '<ul class="pagination"><li><a id="page" href="javascript:previous();">&laquo;</a>';

					var i = -1;
					while (number_of_pages > ++i) {
						nav += '<li class="page_link'
						if (!i)
							nav += ' active';
						nav += '" id="id' + i + '">';
						nav += '<a id="page" href="javascript:go_to_page('
								+ i + ')">' + (i + 1) + '</a>';
					}
					nav += '<li><a id="page" href="javascript:next();">&raquo;</a></ul>';

					$('#page_navigation').html(nav);
					set_display(0, show_per_page);

				});
</script>
</head>
<body>
	<%@include file="/WEB-INF/navbar.jsp"%>
	
	<!----------------------------------- categorie ---------------------------------------->
	<div class="row">
	<a href="./demarche.jsp?page=clown" class="bulle"><img class="img-circle" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/CLAIRE_ET_VIRGINIE.JPG" title="Les clowns" alt="image de CLaire et Viginie" width="156" height="156"></a>
	<a href="./demarche.jsp?page=pratique" class="bulle"><img class="img-circle" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="Pratique et sensorielle" alt="Pratique et sensorielle" width="156" height="156"></a>
	<a href="./demarche.jsp?page=expression" class="bulle"><img class="img-circle" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="Expression corporelle" alt="Expression corporelle" width="156" height="156"></a>
	</div>
	<div class="row col-md-10 col-sm-offset-1" id="textDemarche">
					<p align="justify">Donec id elit non mi porta gravida at eget
					ac cursus commodo, tortor mauris condimentum nibh, ut fermentum
					massa justo sit amet risus. Etiam porta sem malesuada magna mollis
					euismod. Donec sed odio dui.Donec id elit non mi porta gravida at eget
					ac cursus commodo, tortor mauris condimentum nibh, ut fermentum
					massa justo sit amet risus. Etiam porta sem malesuada magna mollis
					euismod. Donec sed odio dui.Donec id elit non mi porta gravida at eget
					ac cursus commodo, tortor mauris condimentum nibh, ut fermentum
					massa justo sit amet risus. Etiam porta sem malesuada magna mollis
					euismod. Donec sed odio dui.Donec id elit non mi porta gravida at eget
					ac cursus commodo, tortor mauris condimentum nibh, ut fermentum
					massa justo sit amet risus. Etiam porta sem malesuada magna mollis
					euismod. Donec sed odio dui.Donec id elit non mi porta gravida at eget
					ac cursus commodo, tortor mauris condimentum nibh, ut fermentum
					massa justo sit amet risus. Etiam porta sem malesuada magna mollis
					euismod. Donec sed odio dui.</p>
	</div>
	<!----------------------------------- fin de categorie ---------------------------------------->
	
	<!------------------------------------- CLOWN ------------------------------------>
	
	<div id="presentation_clown">
		<div class="row">
			<h2>Les Clowns</h2><br>
			<div class="col-md-12">
				<img class="img-circle ovale" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/CLAIRE_ET_VIRGINIE.JPG" title="CLAIRE_ET_VIRGINIE" alt="CLAIRE_ET_VIRGINIE">
				<img class="img-circle ovale" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/CLAIRE_ET_VIRGINIE_2.JPG" title="CLAIRE_ET_VIRGINIE" alt="CLAIRE_ET_VIRGINIE">
			</div>
		</div>
	</div>
	
	<div id="les_clowns">
		<div class="row">
			<div class="col-sm-offset-1 col-md-5">
				<h3>Claire</h3><br>
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/Deambulation-clowns-prima-porta-bien-etre-21.jpg" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/Deambulation-clowns-prima-porta-bien-etre-32.jpg" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/MG_4032.jpg" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/MG_4037.jpg" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/MG_4204.jpg" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/MG_4211.jpg" alt="photo clown">
			</div>
			<div class="col-md-5">
				<h3>Virginie</h3><br>
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P_20170209_141428.jpg" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P_20170209_142253.jpg" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P_20170209_142753.jpg" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1060614.JPG" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1060617.JPG" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1060691.JPG" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1060700.JPG" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1070070.JPG" alt="photo clown">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/VIRGINIE2/P1070097.JPG" alt="photo clown">
			</div>
		</div>
	</div>
	
	
	<!------------------------------------- PRATIQUE ------------------------------------>
	
	<div id="pratique">
	<h2>Pratique et Sensoriel</h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="image de pratique et sensoriel" alt="image de pratique et sensoriel">
			</div>
			<div class="col-md-5">
				<p align="justify">Donec id elit non mi porta gravida at eget
					ac cursus commodo, tortor mauris condimentum nibh, ut fermentum
					massa justo sit amet risus. Etiam porta sem malesuada magna mollis
					euismod. Donec sed odio dui.</p>
				<br>
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/2015-12-17_15.43.00.jpg" alt="photo enfant - pratique et sensoriel">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/2015-12-17_15.30.53.jpg" alt="photo enfant - pratique et sensoriel">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/2015-12-17_15.34.01.jpg" alt="photo enfant - pratique et sensoriel">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/2015-12-17_15.37.09.jpg" alt="photo enfant - pratique et sensoriel">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/2015-12-17_15.40.34.jpg" alt="photo enfant - pratique et sensoriel">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_ATELIER_PRATIQUE_ET_SENSORIEL/P1070143.JPG" alt="photo enfant - pratique et sensoriel">
			</div>
		</div>
	</div>
	
	
	<!------------------------------------- EXPRESSION ------------------------------------>
	
	<div id="expression">
	<h2>Expression Corporelle</h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="image d'expression corporelle" alt="image d'expression corporelle">
			</div>
			<div class="col-md-5">
				<p align="justify">Donec id elit non mi porta gravida at eget
					ac cursus commodo, tortor mauris condimentum nibh, ut fermentum
					massa justo sit amet risus. Etiam porta sem malesuada magna mollis
					euismod. Donec sed odio dui.</p>
				<br>
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/Capture_lenny_2.PNG" alt="photo enfant - expression corporelle">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/2015-12-17_15.47.33.jpg" alt="photo enfant - expression corporelle">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/2015-12-17_15.51.44.jpg" alt="photo enfant - expression corporelle">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/2015-12-17_15.52.08.jpg" alt="photo enfant - expression corporelle">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/2015-12-17_15.52.29.jpg" alt="photo enfant - expression corporelle">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/2015-12-17_15.53.30.jpg" alt="photo enfant - expression corporelle">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/P_20170209_151653.jpg" alt="photo enfant - expression corporelle">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/P_20170209_153232.jpg" alt="photo enfant - expression corporelle">
				<img class="myImg img-thumbnail" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_EXPRESSION_CORPORELLE/P_20170209_153311.jpg" alt="photo enfant - expression corporelle">
			</div>
		</div>
	</div>
	
	<div id="presentationDemarche"><a href="./demarche.jsp"><button class="btn btn-sample">Pr&eacute;sentation de la d&eacute;marche</button></a></div>
	
	<!-- The Modal -->
	<div id="myModal" class="modal">
		<span class="close">&times;</span> <img class="modal-content"
			id="img01">
		<div id="caption"></div>
	</div>
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>