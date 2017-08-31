<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*,tools.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="keywords" content="clown, éducatif, théâtre, prima, porta, primaporta, association, enfants, éducatif, ateliers, expression, corporelle, rire, humour, compagnie" />
<meta name="description" content="Clown Educatif est une compagnie de clown de théâtre créée en 2010 et implantée à Lille (59)." />
<title>Notre démarche ClownEducatif.com</title>
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="./js/demarche.js"></script>
<link rel="stylesheet" href="style.css" />
<% HashMap<Integer, Article> articles = (HashMap<Integer, Article>)request.getAttribute("articles");
   ArrayList<Clown> list_clowns = (ArrayList<Clown>) request.getAttribute("list_clowns");%>
</head>
<body>
	<%@include file="/WEB-INF/navbar.jsp"%>
	<!----------------------------------- categorie ---------------------------------------->
	<div class="row col-md-12">
		<input id="bt_clown" type="image" class="img-circle bt_image" src="images/clowns/Clown.JPG" title="Les clowns" alt="image de Claire et Virginie" width="156" height="156" /> <input id="bt_pratique" type="image" class="img-circle bt_image" src="images/article/9/PHOTO_PRATIQUE_ET_SENSOREL.jpg" title="Pratique et sensoriel" alt="Pratique et sensoriel" width="156" height="156" /> <input id="bt_expression" type="image" class="img-circle bt_image" src="images/article/10/PHOTO_EXPRESSION_CORPORELLE.jpg" title="Expression corporelle" alt="Expression corporelle" width="156" height="156" />
	</div>
	<div class="row col-md-10 col-sm-offset-1" id="textDemarche">
		<p align="justify" style="text-align: center"><%= articles.get(11).getContenu() %></p>
	</div>
	<!----------------------------------- fin de categorie ---------------------------------------->
	<!------------------------------------- CLOWN ------------------------------------>
	<div id="presentation_clown" style="display: none">
		<h2><%= articles.get(8).getTitre() %></h2>
		<br>
	</div>
	<div id="les_clowns" style="display: none">
		<div class="row col-md-12">
			<div class="container">
				<div class="row justify-content-center">
					<div class="col-4">
						<p><%= articles.get(8).getContenu() %></p>
						<%
						if(session.getAttribute("user") != null) 
						{
							for(Media media : articles.get(8).getMedias())
							{
								if(media.getType().equals("pdf"))
								{
									%>
						<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
						<%
								}
							}
						}
						%>
					</div>
				</div>
			</div>
		</div>
		<div class="row col-md-12">
			<%
				for(Clown clown : list_clowns)
				{
					%>
			<div class="portraits_clown">
				<% 
						for(Media media : clown.getList_media())
						{ 
							if(media.getType().equals("portrait")) 
							{
								%><img id="<%= clown.getId_clown() %>" class="portrait_clown img-circle ovale" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>">
				<%
								break;
							}
						} 
						%>
				<br> <span class="nom_clown"><%= clown.getName() %></span>
			</div>
			<%
				}
			%>
		</div>
	</div>
	<!--  ------------------------------	Photos_clown	------------------------------ -->
	<div class="container">
		<div class="row col-md-12">
			<%
		for(Clown clown : list_clowns)
		{
			%>
			<div id="photos_<%= clown.getId_clown() %>" class="photo_clown scroll-bar-wrap">
				<div class="scroll-box">
					<% 
					for(Media media : clown.getList_media()) 
					{
						if(media.getType().equals("photo"))
						{
							%><img class="myImg img-thumbnail img-responsive" src="<%= media.getCheminPhysique() %>" alt="<%= media.getNom() %>">
					<%
						}
					}
					%>
				</div>
				<div class="cover-bar"></div>
			</div>
			<%
		}
		%>
		</div>
	</div>
	<!------------------------------------- PRATIQUE ------------------------------------>
	<div id="pratique" style="display: none">
		<h2><%= articles.get(9).getTitre() %></h2>
		<br>
		<div class="row col-md-12">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/article/3/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="image de pratique et sensoriel" alt="image de pratique et sensoriel">
			</div>
			<div class="col-md-5">
				<p align="justify"><%= articles.get(9).getContenu() %></p>
				<%
					if(session.getAttribute("user") != null) 
					{
						for(Media media : articles.get(9).getMedias())
						{
							if(media.getType().equals("pdf"))
							{
								%>
				<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
				<%
							}
						}
					}
					%>
				<br>
				<div id="pratique" class="scroll-bar-wrap">
					<div class="scroll-box">
						<% 
				for(Media media : articles.get(9).getMedias())
				{
					if(media.getType().equals("photo"))
					{
						%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>">
						<%
					}
				}
				%>
					</div>
					<div class="cover-bar"></div>
				</div>
			</div>
		</div>
	</div>
	<!------------------------------------- EXPRESSION ------------------------------------>
	<div id="expression" style="display: none">
		<h2><%= articles.get(10).getTitre() %></h2>
		<br>
		<div class="row col-md-12">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/article/3/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="image d'expression corporelle" alt="image d'expression corporelle">
			</div>
			<div class="col-md-6">
				<p align="justify"><%= articles.get(10).getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(10).getMedias())
					{
						if(media.getType().equals("pdf"))
						{
							%>
				<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
				<%
						}
					}
				}
				%>
				<br>
				<div id="expression" class="scroll-bar-wrap">
					<div class="scroll-box">
						<% 
				for(Media media : articles.get(10).getMedias())
				{
					if(media.getType().equals("photo"))
					{
						%><img class="myImg img-thumbnail portrait" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>">
						<%
					}
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
	<script>
// 	hideOnglet();
	$('.photo_clown').hide();
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
	</script>
</body>
</html>