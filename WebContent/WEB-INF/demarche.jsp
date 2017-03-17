<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.HashMap,tools.*" %>
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
<% HashMap<String, Article> articles = (HashMap<String, Article>)request.getAttribute("articles");  %>
<script>
function hideAll(){
	$('#textDemarche').hide();
	$('#presentation_clown').hide();
	$('#les_clowns').hide();
	$('#pratique').hide();
	$('#expression').hide();
}
function hideOnglet(){
	$('#presentation_clown').hide();
	$('#les_clowns').hide();
	$('#pratique').hide();
	$('#expression').hide();
}
$(document).ready(function() {
	hideOnglet();
	<%
	if(request.getParameter("page") != null)
	{
		%>hideAll();<%
		switch(request.getParameter("page"))
		{
		case "clown" :
			%>$('#presentation_clown').show();
			$('#les_clowns').show();
			<%
			break;
		case "pratique" :
			%>$('#pratique').show();<%
			break;
		case "expression" :
			%>$('#expression').show();<%
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
	$('#bt_clown').on('click', function(){
		hideAll();
		$('#presentation_clown').show();
		$('#les_clowns').show();
	});
	$('#bt_expression').on('click', function(){
		hideAll();
		$('#expression').show();
	});
	$('#bt_pratique').on('click', function(){
		hideAll();
		$('#pratique').show();
	});
	span.onclick = function() {
		$('html, body').css({
			overflow : 'auto',
			height : 'auto'
		});
		modal.style.display = "none";
	}
});
</script>
</head>
<body>
	<%@include file="/WEB-INF/navbar.jsp"%>
	
	<!----------------------------------- categorie ---------------------------------------->
	<div class="row">
	<input id="bt_clown" type="image" class="img-circle bt_image" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/CLAIRE_ET_VIRGINIE.JPG" title="Les clowns" alt="image de Claire et Virginie" width="156" height="156" />
	<input id="bt_pratique" type="image" class="img-circle bt_image" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="Pratique et sensorielle" alt="Pratique et sensorielle" width="156" height="156" />
	<input id="bt_expression" type="image" class="img-circle bt_image" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="Expression corporelle" alt="Expression corporelle" width="156" height="156" />
	</div>
	<div class="row col-md-10 col-sm-offset-1" id="textDemarche">
			<p align="justify"><%= articles.get("accueil").getContenu() %></p>
	</div>
	<!----------------------------------- fin de categorie ---------------------------------------->
	
	<!------------------------------------- CLOWN ------------------------------------>
	
	<div id="presentation_clown">
		<h2><%= articles.get("Clown").getTitre() %></h2><br>
	</div>
	<div id="les_clowns">
		<div class="row">
			<div class="col-sm-offset-1 col-md-3">
				<img class="img-circle ovale" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/CLAIRE_ET_VIRGINIE.JPG" title="CLAIRE_ET_VIRGINIE" alt="CLAIRE_ET_VIRGINIE">
				<h3>Claire</h3><br>
				
			</div>
			<div class="col-md-4">
				<p align="justify"><%= articles.get("Clown").getContenu() %></p>
			</div>
			<div class="col-md-4">
				<img class="img-circle ovale" src="images/ONGLET_LA_DEMARCHE/SOUS_ONGLET_LE_CLOWN/CLAIRE/CLAIRE_ET_VIRGINIE_2.JPG" title="CLAIRE_ET_VIRGINIE" alt="CLAIRE_ET_VIRGINIE">
				<h3>Virginie</h3><br>
				
			</div>
		</div>
		<div class="row">
			<div class="col-sm-offset-1 col-md-5">
				<div id="claire" class="scroll-bar-wrap" >
				<div class="scroll-box">
				<% 
				for(Media media : articles.get("Clown").getMedias()) {
					if(media.getType().equals("photo_claire"))
					{
					%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
					}
				}
				%>
				</div>
				<div class="cover-bar"></div>
				</div>
			</div>
			<div class="col-md-6">
			<div id="virginie" class="scroll-bar-wrap">
				<div class="scroll-box">
				<% 
				for(Media media : articles.get("Clown").getMedias()) {
					if(media.getType().equals("photo_virginie"))
					{
					%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
					}
				}
				%>
				</div>
				<div class="cover-bar"></div>
				</div>
			</div>
		</div>
	</div>
	
	
	<!------------------------------------- PRATIQUE ------------------------------------>
	
	<div id="pratique">
		<h2><%= articles.get("Pratique et sensoriel").getTitre() %></h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="image de pratique et sensoriel" alt="image de pratique et sensoriel">
			</div>
			<div class="col-md-5">
				<p align="justify"><%= articles.get("Pratique et sensoriel").getContenu() %></p>
				<br>
				<div id="pratique" class="scroll-bar-wrap">
				<div class="scroll-box">
				<% 
				for(Media media : articles.get("Pratique et sensoriel").getMedias())
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
	
	<!------------------------------------- EXPRESSION ------------------------------------>
	
	<div id="expression">
		<h2><%= articles.get("Expression Corporelle").getTitre() %></h2><br>
		<div class="row">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/ONGLET_LES_ATELIERS/SOUS_ONGLET_ATELIER_3_LE_CLASSEMENT_DES_ALIMENTS/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="image d'expression corporelle" alt="image d'expression corporelle">
			</div>
			<div class="col-md-5">
				<p align="justify"><%= articles.get("Expression Corporelle").getContenu() %></p>
				<br>
				<div id="expression" class="scroll-bar-wrap">
				<div class="scroll-box">
				<% 
				for(Media media : articles.get("Expression Corporelle").getMedias())
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
	
	<div id="presentationDemarche"><a href="./Demarche"><button class="btn btn-sample">Pr&eacute;sentation de la d&eacute;marche</button></a></div>
	
	<!-- The Modal -->
	<div id="myModal" class="modal">
		<span class="close">&times;</span> <img class="modal-content"
			id="img01">
		<div id="caption"></div>
	</div>
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>