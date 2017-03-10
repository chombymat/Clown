<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="keywords" content="clown, éducatif, théâtre, prima, porta, primaporta, association, enfants, éducatif, ateliers, expression, corporelle, rire, humour, compagnie" />
<meta name="description" content="Clown Educatif est une compagnie de clown de théâtre créée en 2010 et implantée à Lille (59)." />
<title>Les ateliers ClownEducatif.com</title>
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

$(document)
		.ready(
				function() {
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
	<div id="pain">
		<h2>Le Pain</h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTO_ILLUSTRATION/pain.jpg" title="image de pain" alt="image de pain">
			</div>
			<div class="col-md-5">
				<p align="justify">Donec id elit non mi porta gravida at eget
					ac cursus commodo, tortor mauris condimentum nibh, ut fermentum
					massa justo sit amet risus. Etiam porta sem malesuada magna mollis
					euismod. Donec sed odio dui.</p>
				<a href="images/pdf/pdf.pdf" title="PdfdeTest">c'est un pdf de test (.pdf)</a>
				<br>
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070515.JPG" alt="photo enfant - atelier pain">
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070524.JPG" alt="photo enfant - atelier pain">
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070533.JPG" alt="photo enfant - atelier pain">
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070543.JPG" alt="photo enfant - atelier pain">
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070552.JPG" alt="photo enfant - atelier pain">
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_1_DU_BLE_AU_PAIN/PHOTOS_ENFANTS/P1070554.JPG" alt="photo enfant - atelier pain">
			</div>
		</div>
	</div>
	
	<div id="lait">
		<h2>Le Lait</h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="35%" height="auto" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTO_ILLUSTRATION/lait.jpg" title="image de lait" alt="image de lait">
			</div>
			<div class="col-md-5">
				<p align="justify">Donec id elit non mi porta gravida at eget
					ac cursus commodo, tortor mauris condimentum nibh, ut fermentum
					massa justo sit amet risus. Etiam porta sem malesuada magna mollis
					euismod. Donec sed odio dui.</p>
				<a href="images/pdf/pdf.pdf" title="PdfdeTest">c'est un pdf de test (.pdf)</a>
				<br>
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_144603.jpg" alt="photo enfant - atelier lait">
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_145415.jpg" alt="photo enfant - atelier lait">
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_145430.jpg" alt="photo enfant - atelier lait">
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_145841.jpg" alt="photo enfant - atelier lait">
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_150600.jpg" alt="photo enfant - atelier lait">
				<img class="myImg img-thumbnail" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_2_LE_LAIT_ET_SES_DERIVES/PHOTOS_ENFANTS/P_20170209_150818.jpg" alt="photo enfant - atelier lait">
			</div>
		</div>
	</div>
	<!-- The Modal -->
	<div id="myModal" class="modal">
		<span class="close">&times;</span> <img class="modal-content"
			id="img01">
		<div id="caption"></div>
	</div>
			
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>