<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.HashMap,tools.*" %>
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
<% HashMap<String, Article> articles = (HashMap<String, Article>)request.getAttribute("articles");  %>
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

	function hideAll()
	{
		$('#textAtelier').hide();
		$('#pain').hide();
		$('#lait').hide();
		$('#familles').hide();
		$('#menu').hide();
		$('#alimentation').hide();
		$('#spectacle').hide();
	}
	
	function hideOnglet()
	{
		$('#pain').hide();
		$('#lait').hide();
		$('#familles').hide();
		$('#menu').hide();
		$('#alimentation').hide();
		$('#spectacle').hide();
	}

	$(document).ready(function() 
	{
		hideOnglet();

		<%
		if(request.getParameter("page") != null)
		{
			%>hideAll();<%
			switch(request.getParameter("page"))
			{
			case "pain" :
				%>$('#pain').show();<%
				break;
			case "lait" :
				%>$('#lait').show();<%
				break;
			case "menu" :
				%>$('#menu').show();<%
				break;
			case "alimentation" :
				%>$('#alimentation').show();<%
				break;
			case "spectacle" :
				%>$('#spectacle').show();<%
				break;
			case "famille" :
				%>$('#familles').show();<%
				break;
			}
		}
		%>
		
		var modal = document.getElementById('myModal');
					
		var span = document.getElementsByClassName("close")[0];

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
			
		$('#bt_pain').on('click', function(){
			hideAll();
			$('#pain').show();
		});
		
		$('#bt_lait').on('click', function(){
			hideAll();
			$('#lait').show();
		});
		
		$('#bt_alimentation').on('click', function(){
			hideAll();
			$('#alimentation').show();
		});
		
		$('#bt_menu').on('click', function(){
			hideAll();
			$('#menu').show();
		});
		
		$('#bt_famille').on('click', function(){
			hideAll();
			$('#familles').show();
		});
		
		$('#bt_spectacle').on('click', function(){
			hideAll();
			$('#spectacle').show();
		});
		
		span.onclick = function() {
			$('html, body').css({
				overflow : 'auto',
				height : 'auto'
			});
			modal.style.display = "none";
			$('#id' + current_page).addClass('active');
		}

		var number_of_pages = Math.ceil($('#content').children().length	/ show_per_page);

		var nav = '<ul class="pagination"><li><a id="page" href="javascript:previous();">&laquo;</a>';

		var i = -1;
		while (number_of_pages > ++i) {
			nav += '<li class="page_link'
			if (!i)
				nav += ' active';
			nav += '" id="id' + i + '">';
			nav += '<a id="page" href="javascript:go_to_page(' + i + ')">' + (i + 1) + '</a>';
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
	<div class ="row">
		<div class="row">
			<input id="bt_pain" type="image" class="img-circle bt_image" src="images/1/1/PHOTO_ILLUSTRATION/pain.jpg" title="Atelier 1 : Le pain" alt="image de pain" width="156" height="156" />
			<input id="bt_lait" type="image" class="img-circle bt_image" src="images/1/2/PHOTO_ILLUSTRATION/lait.jpg" title="Atelier 2 : Le lait" alt="image de lait" width="156" height="156">
			<input id="bt_famille" type="image" class="img-circle bt_image" src="images/1/3/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="Atelier 3 : Les 7 familles" alt="image des 7 familles" width="156" height="156">
			<input id="bt_menu" type="image" class="img-circle bt_image" src="images/1/4/PHOTO_ILLUSTRATION/Fotolia_135759645_S-1.jpg" title="Atelier 4 : Le menu &eacute;quilibr&eacute;" alt="image de fruit et legumes" width="156" height="156">
			<input id="bt_alimentation" type="image" class="img-circle bt_image" src="images/1/5/PHOTO_ILLUSTRATION/Fotolia_139412392_S-1.jpg" title="Atelier 5 : Alimentation et environnement" alt="image de yaourt et fraise" width="156" height="156">
			<input id="bt_spectacle" type="image" class="img-circle bt_image" src="images/1/6/PHOTO_ILLUSTRATION/clown-1678004_1920.jpg" title="Le spectacle" alt="image de spectacle" width="156" height="156">
		</div>
		<div class="row col-md-11 col-sm-offset-1" id="textAtelier">
			<p align="justify"><%= articles.get("accueil").getContenu() %></p>
		</div>
	</div>
	<!----------------------------------- fin de categorie ---------------------------------------->
	
	<!----------------------------------- PAIN ---------------------------------------->
	<div id="pain">
		<h2><%= articles.get("Le pain").getTitre() %></h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/1/1/PHOTO_ILLUSTRATION/pain.jpg" title="image de pain" alt="image de pain">
			</div>
			<div class="col-md-5">
				<p align="justify"><%= articles.get("Le pain").getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
					%>
					<a href="images/pdf/FICHE_ATELIER_1_-_DU_BLE_AU_PAIN.pdf" title="Pdf atelier pain">Du blé au pain (.pdf)</a>
					<%
				}
				%>
				<br>
				<div class="scroll-bar-wrap">
				<div class="scroll-box">
				<% 
				for(Media media : articles.get("Le pain").getMedias())
				{
					%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
				}
				%>
				</div>
				<div class="cover-bar"></div>
				</div>
			</div>
		</div>
	</div>
	
	
	<!----------------------------------- LAIT ---------------------------------------->
	<div id="lait">
		<h2><%= articles.get("Le lait").getTitre() %></h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="35%" height="auto" src="images/1/2/PHOTO_ILLUSTRATION/lait.jpg" title="image de lait" alt="image de lait">
			</div>
			<div class="col-md-5">
				<p align="justify"><%= articles.get("Le lait").getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
				%>
				
				<a href="images/pdf/FICHE_ATELIER_2_-_LE_LAIT_ET_SES_DERIVES.pdf" title="Pdf atelier Lait">Le lait et ses dérivés (.pdf)</a>
				<%
				}
				%>
				<br>
				<div class="scroll-bar-wrap">
				<div class="scroll-box">
				<% 
				for(Media media : articles.get("Le lait").getMedias())
				{
					%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
				}
				%>
				</div>
				<div class="cover-bar"></div>
				</div>
				</div>
			</div>
		</div>
	
	
	<!----------------------------------- 7 FAMILLES ---------------------------------------->
	<div id="familles">
		<h2><%= articles.get("Les 7 familles").getTitre() %></h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/1/3/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="image des 7 familles" alt="image des 7 familles">
			</div>
			<div class="col-md-5">
				<p align="justify"><%= articles.get("Les 7 familles").getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
				%>
				<a href="images/pdf/FICHE_ATELIER_3_-_LE_CLASSEMENT_DES_ALIMENTS.pdf" title="Pdf atelier 7 familles">Le classement des aliments (.pdf)</a>
				<%
				}
				%>
				<br>
				<div class="scroll-bar-wrap">
				<div class="scroll-box">
				<% 
				for(Media media : articles.get("Les 7 familles").getMedias())
				{
					%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
				}
				%>
				</div>
				<div class="cover-bar"></div>
				</div>
				</div>
			</div>
		</div>
	
	
	
	<!----------------------------------- MENU EQUILIBRE ---------------------------------------->
	<div id="menu">
		<h2><%= articles.get("Le menu équilibré").getTitre() %></h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/1/4/PHOTO_ILLUSTRATION/Fotolia_135759645_S-1.jpg" title="image de fruits et légumes" alt="image de fruits et légumes">
			</div>
			<div class="col-md-5">

				<p align="justify"><%= articles.get("Le menu équilibré").getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
				%>
				<a href="images/pdf/FICHE_ATELIER_4_-_UN_MENU_EQUILIBRE.pdf" title="Pdf atelier menu équilibré">Un menu equilibré (.pdf)</a>
				<%
				}
				%>
				<br>
				<div class="scroll-bar-wrap">
				<div class="scroll-box">
				<% 
				for(Media media : articles.get("Le menu équilibré").getMedias())
				{
					%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
				}
				%>
				</div>
				<div class="cover-bar"></div>
				</div>
				</div>
			</div>
		</div>
	
	
	
	
	<!----------------------------------- ALIMENTATION ---------------------------------------->
	<div id="alimentation">
		<h2><%= articles.get("Alimentation et environnement").getTitre() %></h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/1/5/PHOTO_ILLUSTRATION/Fotolia_139412392_S-1.jpg" title="image de yaourt et fraise" alt="image de yaourt et fraise">
			</div>
			<div class="col-md-5">

				<p align="justify"><%= articles.get("Alimentation et environnement").getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
				%>
				<a href="images/pdf/FICHE_ATELIER_5_-_LE_PARCOURS_DU_YAOURT_A_LA_FRAISE.pdf" title="Pdf atelier parcours du yaourt à la fraise">Le parcours du yaourt à la fraise (.pdf)</a>
				<%
				}
				%>
				<br>
				<div class="scroll-bar-wrap">
				<div class="scroll-box">
				<% 
				for(Media media : articles.get("Alimentation et environnement").getMedias())
				{
					%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
				}
				%>
				</div>
				<div class="cover-bar"></div>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	<!----------------------------------- SPECTACLE ---------------------------------------->
	<div id="spectacle">
		<h2><%= articles.get("Le spectacle").getTitre() %></h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/1/6/PHOTO_ILLUSTRATION/clown-1678004_1920.jpg" title="Le spectacle" alt="image de spectacle et fraise">
			</div>
			<!-- padding de 5% dans style.css (ligne 59) -->
			<div class="col-md-5">
					<p align="justify"><%= articles.get("Le spectacle").getContenu() %></p>
			</div>
			<div class="col-md-5">
			<%
				if(session.getAttribute("user") != null) 
				{
					%>
					<a href="images/pdf/pdf.pdf" title="PdfdeTest">c'est un pdf de test (.pdf)</a>
					<%
				}
				%>
				<br>
				<div class="scroll-bar-wrap">
				<div class="scroll-box">
				<% 
				for(Media media : articles.get("Le spectacle").getMedias())
				{
					%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
				}
				%>
				</div>
				<div class="cover-bar"></div>
				</div>
				</div>
			</div>
		</div>
	
	
	<!-- The Modal -->
	<div id="myModal" class="modal">
		<span class="close">&times;</span> <img class="modal-content" id="img01">
		<div id="caption"></div>
	</div>
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>