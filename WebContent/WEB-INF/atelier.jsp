<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<script src="./js/atelier.js"></script>
<link rel="stylesheet" href="style.css" />
<% HashMap<Integer, Article> articles = (HashMap<Integer, Article>)request.getAttribute("articles");  %>
</head>
<body>
	<%@include file="/WEB-INF/navbar.jsp"%>
	<!----------------------------------- categorie ---------------------------------------->
	<div class ="row col-md-12">
		<div class="row">
			<input id="bt_pain" type="image" class="img-circle bt_image" src="images/article/1/PHOTO_ILLUSTRATION/pain.jpg" title="Atelier 1 : Le pain" alt="image de pain" width="156" height="156" />
			<input id="bt_lait" type="image" class="img-circle bt_image" src="images/article/2/PHOTO_ILLUSTRATION/lait.jpg" title="Atelier 2 : Le lait" alt="image de lait" width="156" height="156">
			<input id="bt_famille" type="image" class="img-circle bt_image" src="images/article/3/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="Atelier 3 : Les 7 familles" alt="image des 7 familles" width="156" height="156">
			<input id="bt_menu" type="image" class="img-circle bt_image" src="images/article/4/PHOTO_ILLUSTRATION/Fotolia_135759645_S-1.jpg" title="Atelier 4 : Le menu &eacute;quilibr&eacute;" alt="image de fruit et legumes" width="156" height="156">
			<input id="bt_alimentation" type="image" class="img-circle bt_image" src="images/article/5/PHOTO_ILLUSTRATION/Fotolia_139412392_S-1.jpg" title="Atelier 5 : Alimentation et environnement" alt="image de yaourt et fraise" width="156" height="156">
			<input id="bt_spectacle" type="image" class="img-circle bt_image" src="images/article/6/PHOTO_ILLUSTRATION/PHOTO_SPECTACLE.png" title="Le spectacle" alt="image de spectacle" width="156" height="156">
		</div>
		<div class="row col-md-10 col-sm-offset-1" id="textAtelier">
			<p align="justify" style="text-align: center"><%= articles.get(7).getContenu() %></p>
		</div>
	</div>
	<!----------------------------------- fin de categorie ---------------------------------------->
	
	<!----------------------------------- PAIN ---------------------------------------->
	<div id="pain" style="display: none">
		<h2><%= articles.get(1).getTitre() %></h2><br>
		<div class="row parent col-md-12">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/article/1/PHOTO_ILLUSTRATION/pain.jpg" title="image de pain" alt="image de pain">
			</div>
			<div class="col-md-5 enfant">
				<p align="justify"><%= articles.get(1).getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(1).getMedias())
					{
						if(media.getType().equals("pdf") && media.isDoitInscrit())
						{
							%>
							<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
							<%
						}
					}
				}
				for(Media media : articles.get(1).getMedias())
				{
					if(media.getType().equals("pdf") && !media.isDoitInscrit())
					{
						%>
						<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
						<%
					}
				}
				%>
			</div>
				
		</div>
		<div class="row col-md-12">
			<div class="container-video col-md-6">
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(1).getMedias())
					{
						if(media.getType().equals("video") && media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				else
				{
					for(Media media : articles.get(1).getMedias())
					{
						if(media.getType().equals("video") && !media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				%>
			</div>
			<div class="col-md-6">
				<br>
				<div class="scroll-bar-wrap">
					<div class="scroll-box">
						<% 
						if(session.getAttribute("user") != null) 
						{
							for(Media media : articles.get(1).getMedias())
							{
								if(media.getType().equals("photo") && media.isDoitInscrit())
								{
									%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
								}
							}
						}
						for(Media media : articles.get(1).getMedias())
						{
							if(media.getType().equals("photo") && !media.isDoitInscrit())
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
	
	<!----------------------------------- LAIT ---------------------------------------->
	<div id="lait" style="display: none">
		<h2><%= articles.get(2).getTitre() %></h2><br>
		<div class="row parent col-md-12">
			<div class="col-md-6">
				<img width="35%" height="auto" src="images/article/2/PHOTO_ILLUSTRATION/lait.jpg" title="image de lait" alt="image de lait">
			</div>
			<div class="col-md-5 enfant">
				<p align="justify"><%= articles.get(2).getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(2).getMedias())
					{
						if(media.getType().equals("pdf") && media.isDoitInscrit())
						{
							%>
							<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
							<%
						}
					}
				}
				for(Media media : articles.get(2).getMedias())
				{
					if(media.getType().equals("pdf") && !media.isDoitInscrit())
					{
						%>
						<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
						<%
					}
				}
				%>
			</div>
				
		</div>
		<div class="row col-md-12">
			<div class="container-video col-md-6">
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(2).getMedias())
					{
						if(media.getType().equals("video") && media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				else
				{
					for(Media media : articles.get(2).getMedias())
					{
						if(media.getType().equals("video") && !media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				%>
			</div>
			<div class="col-md-6">
				<br>
				<div class="scroll-bar-wrap">
					<div class="scroll-box">
						<% 
						if(session.getAttribute("user") != null) 
						{
							for(Media media : articles.get(2).getMedias())
							{
								if(media.getType().equals("photo") && media.isDoitInscrit())
								{
									%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
								}
							}
						}
						for(Media media : articles.get(2).getMedias())
						{
							if(media.getType().equals("photo") && !media.isDoitInscrit())
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
	
	<!----------------------------------- 7 FAMILLES ---------------------------------------->
	<div id="familles" style="display: none">
		<h2><%= articles.get(3).getTitre() %></h2><br>
		<div class="row parent col-md-12">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/article/3/PHOTO_ILLUSTRATION/Fotolia_111774771_S.jpg" title="image des 7 familles" alt="image des 7 familles">
			</div>
			<div class="col-md-5 enfant">
				<p align="justify"><%= articles.get(3).getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(3).getMedias())
					{
						if(media.getType().equals("pdf") && media.isDoitInscrit())
						{
							%>
							<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
							<%
						}
					}
				}
				for(Media media : articles.get(3).getMedias())
				{
					if(media.getType().equals("pdf") && !media.isDoitInscrit())
					{
						%>
						<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
						<%
					}
				}
				%>
			</div>
				
		</div>
		<div class="row col-md-12">
			<div class="container-video col-md-6">
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(3).getMedias())
					{
						if(media.getType().equals("video") && media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				else
				{
					for(Media media : articles.get(3).getMedias())
					{
						if(media.getType().equals("video") && !media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				%>
			</div>
			<div class="col-md-6">
				<br>
				<div class="scroll-bar-wrap">
					<div class="scroll-box">
						<% 
						if(session.getAttribute("user") != null) 
						{
							for(Media media : articles.get(3).getMedias())
							{
								if(media.getType().equals("photo") && media.isDoitInscrit())
								{
									%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
								}
							}
						}
						for(Media media : articles.get(3).getMedias())
						{
							if(media.getType().equals("photo") && !media.isDoitInscrit())
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
	
	<!----------------------------------- MENU EQUILIBRE ---------------------------------------->
	
	<div id="menu" style="display: none">
		<h2><%= articles.get(4).getTitre() %></h2><br>
		<div class="row parent col-md-12">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/article/4/PHOTO_ILLUSTRATION/Fotolia_135759645_S-1.jpg" title="image de fruits et légumes" alt="image de fruits et légumes">
			</div>
			<div class="col-md-5 enfant">
				<p align="justify"><%= articles.get(4).getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(4).getMedias())
					{
						if(media.getType().equals("pdf") && media.isDoitInscrit())
						{
							%>
							<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
							<%
						}
					}
				}
				for(Media media : articles.get(4).getMedias())
				{
					if(media.getType().equals("pdf") && !media.isDoitInscrit())
					{
						%>
						<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
						<%
					}
				}
				%>
			</div>
				
		</div>
		<div class="row col-md-12">
			<div class="container-video col-md-6">
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(4).getMedias())
					{
						if(media.getType().equals("video") && media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				else
				{
					for(Media media : articles.get(4).getMedias())
					{
						if(media.getType().equals("video") && !media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				%>
			</div>
			<div class="col-md-6">
				<br>
				<div class="scroll-bar-wrap">
					<div class="scroll-box">
						<% 
						if(session.getAttribute("user") != null) 
						{
							for(Media media : articles.get(4).getMedias())
							{
								if(media.getType().equals("photo") && media.isDoitInscrit())
								{
									%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
								}
							}
						}
						for(Media media : articles.get(4).getMedias())
						{
							if(media.getType().equals("photo") && !media.isDoitInscrit())
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
	
	<!----------------------------------- ALIMENTATION ---------------------------------------->
	<div id="alimentation" style="display: none">
		<h2><%= articles.get(5).getTitre() %></h2><br>
		<div class="row parent col-md-12">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/article/5/PHOTO_ILLUSTRATION/Fotolia_139412392_S-1.jpg" title="image de yaourt et fraise" alt="image de yaourt et fraise">
			</div>
			<div class="col-md-5 enfant">
				<p align="justify"><%= articles.get(5).getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(5).getMedias())
					{
						if(media.getType().equals("pdf") && media.isDoitInscrit())
						{
							%>
							<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
							<%
						}
					}
				}
				for(Media media : articles.get(5).getMedias())
				{
					if(media.getType().equals("pdf") && !media.isDoitInscrit())
					{
						%>
						<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
						<%
					}
				}
				
				%>
			</div>
				
		</div>
		<div class="row col-md-12">
			<div class="container-video col-md-6">
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(5).getMedias())
					{
						if(media.getType().equals("video") && media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				else
				{
					for(Media media : articles.get(5).getMedias())
					{
						if(media.getType().equals("video") && !media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				
				%>
			</div>
			<div class="col-md-6">
				<br>
				<div class="scroll-bar-wrap">
					<div class="scroll-box">
						<% 
						if(session.getAttribute("user") != null) 
						{
							for(Media media : articles.get(5).getMedias())
							{
								if(media.getType().equals("photo") && media.isDoitInscrit())
								{
									%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
								}
							}
						}
						for(Media media : articles.get(5).getMedias())
						{
							if(media.getType().equals("photo") && !media.isDoitInscrit())
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
	
	<!----------------------------------- SPECTACLE ---------------------------------------->
	<div id="spectacle" style="display: none">
		<h2><%= articles.get(6).getTitre() %></h2><br>
		<div class="row parent col-md-12">
			<div class="col-md-6">
				<img width="85%" height="auto" src="images/article/6/PHOTO_ILLUSTRATION/PHOTO_SPECTACLE.png" title="Le spectacle" alt="image de spectacle et fraise">
			</div>
			<div class="col-md-5 enfant">
				<p align="justify"><%= articles.get(6).getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(6).getMedias())
					{
						if(media.getType().equals("pdf") && media.isDoitInscrit())
						{
							%>
							<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
							<%
						}
					}
				}
				for(Media media : articles.get(6).getMedias())
				{
					if(media.getType().equals("pdf") && !media.isDoitInscrit())
					{
						%>
						<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
						<%
					}
				}
				%>
			</div>
				
		</div>
		<div class="row col-md-12">
			<div class="container-video col-md-6">
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : articles.get(6).getMedias())
					{
						if(media.getType().equals("video") && media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				else
				{
					for(Media media : articles.get(6).getMedias())
					{
						if(media.getType().equals("video") && !media.isDoitInscrit())
						{
							%><%= media.getChemin() %><%
						}
					}
				}
				%>
			</div>
			<div class="col-md-6">
				<br>
				<div class="scroll-bar-wrap">
					<div class="scroll-box">
						<% 
						if(session.getAttribute("user") != null) 
						{
							for(Media media : articles.get(6).getMedias())
							{
								if(media.getType().equals("photo") && media.isDoitInscrit())
								{
									%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>"><%
								}
							}
						}
						for(Media media : articles.get(6).getMedias())
						{
							if(media.getType().equals("photo") && !media.isDoitInscrit())
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
	
	<!-- The Modal -->
	<div id="myModal" class="modal">
		<span class="close">&times;</span> <img class="modal-content" id="img01">
		<div id="caption"></div>
	</div>
	<%@include file="/WEB-INF/footer.html"%>
	<script>
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
	</script>
</body>
</html>