<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="tools.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="clown, éducatif, théâtre, prima, porta, primaporta, association, enfants, éducatif, ateliers, expression, corporelle, rire, humour, compagnie, formation" />
<meta name="description" content="Clown Educatif est une compagnie de clown de théâtre créée en 2010 et implantée à Lille (59)." />
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
<title>Formation ClownEducatif.com</title>
</head>
<body>
	<% Article article = (Article)request.getAttribute("article"); %>
	<%@include file="/WEB-INF/navbar.jsp"%>
	<script>
	$(document).ready(function(){
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
	<div id="formation" style="font-family: serif">
		<h2><%= article.getTitre() %></h2>
		<br>
		<div class="row parent col-md-12">
			<div class="col-md-5 enfant">
				<p align="justify"><%= article.getContenu() %></p>
				<%
				if(session.getAttribute("user") != null) 
				{
					for(Media media : article.getMedias())
					{
						if(media.getType().equals("pdf") && media.isDoitInscrit())
						{
							%>
				<a href="<%= media.getChemin() %>" title="<%= media.getNom() %>"><%= media.getNom() %></a><br>
				<%
						}
					}
				}
				for(Media media : article.getMedias())
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
					for(Media media : article.getMedias())
					{
						if(media.getType().equals("video") && media.isDoitInscrit())
						{
							%><%= media.getChemin() %>
				<%
						}
					}
				}
				for(Media media : article.getMedias())
				{
					if(media.getType().equals("video") && !media.isDoitInscrit())
					{
						%><%= media.getChemin() %>
				<%
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
							for(Media media : article.getMedias())
							{
								if(media.getType().equals("photo") && media.isDoitInscrit())
								{
									%><img class="myImg img-thumbnail" src="<%= media.getChemin() %>" alt="<%= media.getNom() %>">
						<%
								}
							}
						}
						for(Media media : article.getMedias())
						{
							if(media.getType().equals("photo") && !media.isDoitInscrit())
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
	<!-- The Modal -->
	<div id="myModal" class="modal">
		<span class="close">&times;</span> <img class="modal-content" id="img01">
		<div id="caption"></div>
	</div>
	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>