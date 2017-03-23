<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="keywords" content="clown, éducatif, théâtre, prima, porta, primaporta, association, enfants, éducatif, ateliers, expression, corporelle, rire, humour, compagnie" />
<meta name="description" content="Clown Educatif est une compagnie de clown de théâtre créée en 2010 et implantée à Lille (59)." />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
<title>ClownEducatif.com – Compagnie de clown de théâtre Administration</title>
</head>
<body>
	<%@include file="/WEB-INF/navbar.jsp" %>
	<script>
			var show_per_page = 12;
			var current_page = 0;
		$(document).ready(function()
		{
			/*********************************** Gestion galerie ***********************************/
			
			$('#bt_galerie').on('click', function()
			{
				if($('#gestion_clowns').is(':visible'))
					$('#gestion_clowns').hide();
				
				if($('#page_modif_article').is(':visible'))
					$('#page_modif_article').hide();
				
				if($('#page_galerie').is(':visible'))
					$('#page_galerie').hide();
				else
				{
					getGalerie();
					$('#page_galerie').show();
				}
			});
			
			$('#bt_galerie_get_photo').on('click', function(){
				$('#file_galerie_get_photo').click();
			});
			
			$('#bt_galerie_add_photo_submit').on('click', function(){
				var name = $('#tb_galerie_name_new_photo').val();
 				var file = $('#file_galerie_get_photo')[0].files[0];
 				
 				if(name == null || name == "")
				{
					alert("Veuillez saisir un nom pour l'image");
					return;					
				}
				
				if(file == null)
				{
					alert("Veuillez importer un fichier");
					return;					
				}
 				
				var form_data = new FormData();
				form_data.append('type', 'add');
				form_data.append('media', file);
				form_data.append('name', name);
				$.ajax({
		            url: './ModificationGalerie',
		            type: 'POST',
		            contentType: false,
		            processData: false,
		            data: form_data,
		            success : function(json)
		            {
		            	json = jQuery.parseJSON(json);
		            	
		            	var div = $(document.createElement('div'));
	            		var img = $(document.createElement('img'));
	            		var tb = $(document.createElement('input'));
	            		var bt_rename = $(document.createElement('button'));
	            		var bt_delete = $(document.createElement('button'));
	            		
	            		div.attr('class', 'col-lg-3');
	            		div.attr('id', json.id_media);
	            		div.attr('style', 'margin-top: 2%');
	            		img.attr('class', 'myImg');
	            		img.attr('id', 'img_' + json.id_media);
	            		img.attr('src', json.chemin);
	            		img.attr('alt', json.nom);
	            		tb.attr('type', 'text');
	            		tb.attr('id', 'name_' + json.id_media);
	            		tb.attr('id_media', json.id_media);
	            		tb.val(json.nom);
	            		bt_rename.attr('id_media', json.id_media);
	            		bt_rename.attr('class', 'bt_galerie_rename btn btn-sample');
	            		bt_rename.html('Renommer');
	            		bt_rename.attr('style', 'margin-right: 2%');
	            		bt_delete.attr('id_media', json.id_media);
	            		bt_delete.attr('class', 'bt_galerie_delete btn btn-sample');
	            		bt_delete.html('Supprimer');
	            		
	            		div.append(img);
	            		div.append(tb);
	            		div.append('<br>');
	            		div.append(bt_rename);
	            		div.append(bt_delete);
	            		
	            		$('#content').append(div);
	            		
	            		initialiserGalerie();
		            }
		        });
			});
			
			function getGalerie()
			{
				$.ajax({
		            url: './ModificationGalerie',
		            type: 'GET',
		            success : function(data)
		            {
		            	var j_array = jQuery.parseJSON(data);
		            	$('#content').html("");
		            	for(var i = 0; i < j_array.length; i++)
		            	{
		            		var div = $(document.createElement('div'));
		            		var img = $(document.createElement('img'));
		            		var tb = $(document.createElement('input'));
		            		var bt_rename = $(document.createElement('button'));
		            		var bt_delete = $(document.createElement('button'));
		            		
		            		div.attr('class', 'col-lg-3');
		            		div.attr('id', j_array[i].id_media);
		            		div.attr('style', 'margin-top: 2%');
		            		img.attr('class', 'myImg');
		            		img.attr('id', 'img_' + j_array[i].id_media);
		            		img.attr('src', j_array[i].chemin);
		            		img.attr('alt', j_array[i].nom);
		            		tb.attr('type', 'text');
		            		tb.attr('id', 'name_' + j_array[i].id_media);
		            		tb.attr('id_media', j_array[i].id_media);
		            		tb.val(j_array[i].nom);
		            		bt_rename.attr('id_media', j_array[i].id_media);
		            		bt_rename.attr('class', 'bt_galerie_rename btn btn-sample');
		            		bt_rename.html('Renommer');
		            		bt_rename.attr('style', 'margin-right: 2%');
		            		bt_delete.attr('id_media', j_array[i].id_media);
		            		bt_delete.attr('class', 'bt_galerie_delete btn btn-sample');
		            		bt_delete.html('Supprimer');
		            		
		            		div.append(img);
		            		div.append(tb);
		            		div.append('<br>');
		            		div.append(bt_rename);
		            		div.append(bt_delete);
		            		
		            		$('#content').append(div);
		            		initialiserGalerie();
		            	}
		            }
		        });
			}
			
			function initialiserGalerie()
			{
				$('.bt_galerie_rename').unbind('click');
				$('.bt_galerie_delete').unbind('click');
				
				$('.bt_galerie_rename').on('click', function(){
					var id_media = $(this).attr('id_media');
					var new_name = $('#name_' + id_media).val();
					
					if(new_name == null || new_name == "")
					{
						alert("Veuillez saisir un nom pour l'image");
						return;
					}
					
					console.log(id_media);
					console.log(new_name);
					var form_data = new FormData();
					form_data.append('type', 'rename');
					form_data.append('id_media', id_media);
					form_data.append('new_name', new_name);
					$.ajax({
			            url: './ModificationGalerie',
			            type: 'POST',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            success : function(data)
			            {
			            	$('#img_' + id_media).attr('alt', new_name);
			            	alert("Modification réussie");
			            }
			        });
				});
				
				$('.bt_galerie_delete').on('click', function(){
					var id_media = $(this).attr('id_media');
					var form_data = new FormData();
					form_data.append('id_media', id_media);
					form_data.append('chemin', $('#img_' + id_media).attr('src'));
					form_data.append('type', 'delete');
					$.ajax({
			            url: './ModificationGalerie',
			            type: 'POST',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            success : function(data)
			            {
			            	$('#' + id_media).remove();
			            }
			        });
				});
				
				initialiserModal();
				
				var number_of_pages = Math.ceil($('#content').children().length / show_per_page);
	
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
			}
			
			$('#bt_galerie_add_photo').on('click', function(){
				if($('#galerie_add_photo_info').is(':visible'))
					$('#galerie_add_photo_info').hide();
				else
					$('#galerie_add_photo_info').show();
			});
			
			$('#page_galerie').hide();
			$('#file_galerie_get_photo').hide();
			$('#galerie_add_photo_info').hide();
			
			/*********************************** Modifier article ***********************************/
			
			var id_article = null;
			
			$('#bt_modif_article').on('click', function(){
				if($('#gestion_clowns').is(':visible'))
					$('#gestion_clowns').hide();
				
				if($('#page_galerie').is(':visible'))
					$('#page_galerie').hide();

				if($('#page_modif_article').is(':visible'))
					$('#page_modif_article').hide();
				else
					$('#page_modif_article').show();
			});
			
			$('#select').change(function(){
				id_article = $('option:selected', this).attr('id_article');
				$.ajax({
		            url: './ModificationArticle',
		            type: 'GET',
		            data: {
		            	id_article : id_article,
		            },
		            success : function(data)
		            {
		            	var json = jQuery.parseJSON(data);
		            	var array = json.medias;
		            	id_article = json.id;
		            	
		            	if(id_article != 7 && id_article != 11)
		            	{
			            	$('#modif_article_image').html("");
			            	$('#modif_article_pdf').html("");
			            	$('#modif_article_video').html("");
			            	
			            	for(var i = 0; i < array.length; i++)
			            	{
			            		var div = $(document.createElement('div'));
				            	div.attr('class', array[i].id + ' col-md-2');
				            	
				            	var input = $(document.createElement('input'));
				            	input.attr('id', 'name_' + array[i].id);
				            	input.attr('type', 'text');
				            	input.val(array[i].nom);
				            	
				            	var bt_rename = $(document.createElement('button'));
				            	bt_rename.attr('id_media', array[i].id);
				            	bt_rename.attr('class', 'bt_rename btn btn-sample');
				            	bt_rename.html('Renommer');
				            	
				            	var bt_delete = $(document.createElement('button'));
				            	bt_delete.attr('id_media', array[i].id);
				            	bt_delete.html('Supprimer');
				            	
				            	var checkbox = $(document.createElement('input'));
				            	checkbox.attr('id_media', array[i].id);
				            	checkbox.attr('class', 'update_checkbox');
				            	checkbox.attr('type', 'checkbox');
				            	console.log(array[i].doit_inscrit);
				            	if(array[i].doit_inscrit === true)
				            		checkbox.prop('checked', true);
				            	
			            		if(array[i].type === "photo")
			            		{
					            	var img =  $(document.createElement('img'));
					            	img.attr('id', array[i].id);
					            	img.attr('class', 'myImg img-thumbnail');
					            	img.attr('src',array[i].chemin);
					            	img.attr('alt', array[i].nom);
					            	
					            	bt_delete.attr('class', 'bt_delete_photo btn btn-sample');
					            	
					            	div.append(img);
					            	div.append('<br>');
					            	div.append(input);
					            	div.append('<br>');
					            	div.append(checkbox);
					            	div.append('Inscription requise ?<br>');
					            	div.append(bt_rename);
					            	div.append(bt_delete);
					            	
					            	$('#modif_article_image').append(div);
			            		}
			            		else if(array[i].type === "pdf")
			            		{
			            			var a = $(document.createElement('a'));
			            			a.attr('href', array[i].chemin);
			            			a.html('Voir PDF');
			            			
					            	bt_delete.attr('class', 'bt_delete_pdf btn btn-sample');
					            	
					            	div.append(a);
					            	div.append('<br><br>');
					            	div.append(input);
					            	div.append('<br>');
					            	div.append(checkbox);
					            	div.append('Inscription requise<br>');
					            	div.append(bt_rename);
					            	div.append(bt_delete);
					            	
					            	$('#modif_article_pdf').append(div);
			            		}
			            		else if(array[i].type === "video")
			            		{
					            	bt_delete.attr('class', 'bt_delete_video btn btn-sample');
					            	div.attr('class', array[i].id + ' col-md-6');
					            	div.append(array[i].chemin);
					            	div.append('<br>');
					            	div.append(checkbox);
					            	div.append('Inscription requise ?<br>');
					            	div.append(bt_delete);
					            	
					            	$('#modif_article_video').append(div);
			            		}
			            	}
			            	
			            	$('#onglet_photo').attr('class', 'onglet');
			            	$('#onglet_pdf').attr('class', 'onglet');
			            	$('#onglet_video').attr('class', 'onglet');
		            	}
		            	else
		            	{
		            		$('#onglet_photo').attr('class', 'onglet hide');
			            	$('#onglet_pdf').attr('class', 'onglet hide');
			            	$('#onglet_video').attr('class', 'onglet hide');
		            	}
		            	
		            	$('#contenu_article').val(json.contenu);
		            	$('#update_pdf').hide();
		            	$('#update_gestion_photo').hide();
		            	$('#update_video').hide();
		            	
		            	$('#onglet_contenu').attr('class', 'onglet active');
		            	$('#update_content').show();
		            	
		            	initialiserUpdateArticle();
		            	
		            }
		        });
				
				$('#update_show_article').show();
			});
			
			$('#bt_submit_update_content').on('click', function(){
				var form_data = new FormData();
				form_data.append("type", "texte");
				form_data.append("id_article", id_article);
				form_data.append("texte", $('#contenu_article').val());
				
				$.ajax({
		            url: './ModificationArticle',
		            type: 'POST',
		            mimeType:'multipart/form-data',
		            contentType: false,
		            processData: false,
		            data: form_data,
		            success : function()
		            {
		            	alert("Modification réussie")
		            }
		        });
			});
			
			$('#bt_update_add_photo').on('click', function(){
				if($('#update_add_photo_info').is(':visible'))
					$('#update_add_photo_info').hide();
				else
					$('#update_add_photo_info').show();
			});
			
			$('#bt_update_add_photo_submit').on('click', function(){
				var name = $('#tb_update_name_photo').val();			
				var file = $('#file_update_get_photo')[0].files[0];

				if(name == null || name == "")
				{
					alert("Veuillez saisir un nom pour l'image");
					return;					
				}
				
				if(file == null)
				{
					alert("Veuillez importer un fichier");
					return;					
				}
				
				var form_data = new FormData();
				console.log(id_article);
				form_data.append("type", "add_photo");
				form_data.append("id_article", id_article);
				form_data.append('nom', name);
				form_data.append('media', file);
				form_data.append('doit_inscrit', $('#check_update_add_photo').checked);
				
				$.ajax({
		            url: './ModificationArticle',
		            type: 'POST',
		            mimeType:'multipart/form-data',
		            contentType: false,
		            processData: false,
		            data: form_data,
		            success : function(json)
		            {
		            	json = jQuery.parseJSON(json);
		            	
		            	var div = $(document.createElement('div'));
		            	div.attr('class', json.id_media + ' col-md-2');
		            	var img =  $(document.createElement('img'));
		            	img.attr('id', json.id_media);
		            	img.attr('class', 'myImg img-thumbnail');
		            	img.attr('src',json.nom);
		            	img.attr('alt', $('#tb_update_name_photo').val());
		            	var input = $(document.createElement('input'));
		            	input.attr('id', 'name_' + json.id_media);
		            	input.attr('type', 'text');
		            	input.val($('#tb_update_name_photo').val());
		            	input.attr('maxlength', '50');
		            	var bt_rename = $(document.createElement('button'));
		            	var bt_delete = $(document.createElement('button'));
		            	bt_rename.attr('id_media', json.id_media);
		            	bt_rename.attr('class', 'bt_rename btn btn-sample');
		            	bt_rename.html('Renommer');
		            	bt_delete.attr('id_media', json.id_media);
		            	bt_delete.attr('class', 'bt_delete_photo btn btn-sample');
		            	bt_delete.html('Supprimer');
		            	
		            	div.append(img);
		            	div.append('<br>');
		            	div.append(input);
		            	div.append('<br>');
		            	div.append(bt_rename);
		            	div.append(bt_delete);
		            	
		            	$('#modif_article_image').append(div);

		            	initialiserUpdateArticle();
		            }
		        });
			});
			
			$('#bt_update_get_photo').on('click', function(){
				$('#file_update_get_photo').click();
			});
			
			$('#bt_update_add_pdf').on('click', function(){
				if($('#update_get_pdf').is(':visible'))
					$('#update_get_pdf').hide();
				else
					$('#update_get_pdf').show();
			});
			
			$('#bt_update_get_pdf').on('click', function(){
				$('#file_update_get_pdf').click();
			});
			
			$('#bt_update_submit_pdf').on('click', function(){
				var name = $('#tb_update_name_pdf').val();
				var file = $('#file_update_get_pdf')[0].files[0];
				
				if(name == null || name == "")
				{
					alert("Veuillez saisir un nom pour le PDF");
					return;					
				}
				
				if(file == null)
				{
					alert("Veuillez importer un fichier");
					return;					
				}
				
				var form_data = new FormData();
				form_data.append("type", "add_pdf");
				form_data.append("id_article", id_article);
				form_data.append('nom', name);
				form_data.append('media', file);
				form_data.append('doit_inscrit', $('#check_update_add_pdf').checked);
				
				$.ajax({
		            url: './ModificationArticle',
		            type: 'POST',
		            mimeType:'multipart/form-data',
		            contentType: false,
		            processData: false,
		            data: form_data,
		            success : function(json)
		            {
						json = jQuery.parseJSON(json);
		            	
		            	var div = $(document.createElement('div'));
		            	div.attr('class', json.id_media + ' col-md-2');
		            	var a =  $(document.createElement('a'));
		            	a.attr('href', json.nom);
		            	a.html('Voir PDF');
		            	var input = $(document.createElement('input'));
		            	input.attr('id', 'name_' + json.id_media);
		            	input.attr('type', 'text');
		            	input.val($('#tb_update_name_pdf').val());
		            	var bt_rename = $(document.createElement('button'));
		            	var bt_delete = $(document.createElement('button'));
		            	bt_rename.attr('id_media', json.id_media);
		            	bt_rename.attr('class', 'bt_rename btn btn-sample');
		            	bt_rename.html('Renommer');
		            	bt_delete.attr('id_media', json.id_media);
		            	bt_delete.attr('class', 'bt_delete_pdf btn btn-sample');
		            	bt_delete.html('Supprimer');
		            	
		            	div.append(a);
		            	div.append('<br><br>');
		            	div.append(input);
		            	div.append(bt_rename);
		            	div.append(bt_delete);
		            	
		            	$('#modif_article_pdf').append(div);

		            	initialiserUpdateArticle();
		            }
		        });
			});
			
			$('#page_modif_article').hide();
			$('#file_update_get_photo').hide();
			$('#update_add_photo_info').hide();
			$('#update_show_article').hide();
			$('#file_update_get_pdf').hide();
			
			function initialiserUpdateArticle()
			{
				$('.bt_rename').unbind('click');
				$('#bt_update_add_video').unbind('click');
				$('.bt_delete_photo').unbind('click');
				$('.bt_delete_pdf').unbind('click');
				$('.bt_delete_video').unbind('click');
				$('.update_checkbox').unbind('click');
				$('#bt_update_add_video').unbind('click');
				$('#bt_update_submit_video').unbind('click');
				
				initialiserModal();
				
				$('.update_checkbox').on('change', function(){
					console.log($(this).is(":checked"));
					var id_media = $(this).attr('id_media');
					var form_data = new FormData();
					form_data.append('id_media', id_media);
					form_data.append('doit_inscrit', $(this).is(":checked"));
					form_data.append('type', 'access_media');
					
					$.ajax({
						url: './ModificationArticle',
						type: 'POST',
			            mimeType:'multipart/form-data',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            success : function()
			            {
			            	alert('Droit d\'accès modifié');
			            }
					});
				});
				
				$('.bt_delete_photo').on('click', function(){
					var id_media = $(this).attr('id_media');
					var form_data = new FormData();
					form_data.append("type", "delete_photo");
					form_data.append("id_article", id_article);
					form_data.append("id_media", id_media);
					form_data.append("chemin", $('#' + id_media).attr('src'));
					
					$.ajax({
			            url: './ModificationArticle',
			            type: 'POST',
			            mimeType:'multipart/form-data',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            success : function()
			            {
			            	$('.' + id_media).remove();
			            }
			        });
				});
				
				$('.bt_delete_video').on('click', function(){
					var id_media = $(this).attr('id_media');
					var form_data = new FormData();
					form_data.append("type", "delete_video");
					form_data.append("id_media", id_media);
					
					$.ajax({
			            url: './ModificationArticle',
			            type: 'POST',
			            mimeType:'multipart/form-data',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            success : function()
			            {
			            	$('.' + id_media).remove();
			            }
			        });
				});

				$('.bt_rename').on('click', function(e)
				{
					var id_media = $(this).attr("id_media");
					var new_name = $('#name_' + id_media).val();
					var form_data = new FormData();
					
					if(new_name == null || new_name == "")
					{
						alert("Veuillez saisir un nom pour l'image/PDF");
						return;
					}
					
					form_data.append("type", "rename");
					form_data.append("new_name", new_name);
					form_data.append("id_media", id_media);
					
					$.ajax({
			            url: './ModificationArticle',
			            type: 'POST',
			            mimeType:'multipart/form-data',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            success : function()
			            {
			            	$('#' + id_media).attr('alt', new_name);
			            	alert("Modification réussie");
			            }
			        });
				});
				
				$('.bt_delete_pdf').on('click', function(){
					var id_media = $(this).attr('id_media');
					var form_data = new FormData();
					form_data.append("type", "delete_pdf");
					form_data.append("id_article", id_article);
					form_data.append('id_media', $(this).attr('id_media'));
					
					$.ajax({
			            url: './ModificationArticle',
			            type: 'POST',
			            mimeType:'multipart/form-data',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            success : function(json)
			            {
			            	$('.' + id_media).remove();
			            }
			        });
				});
				
				$('#bt_update_add_video').on('click', function(){
					if($('#update_get_video').is(':visible'))
						$('#update_get_video').hide();
					else
						$('#update_get_video').show();
				});
				
				$('#bt_update_submit_video').on('click',function(){
					var url = $('#tb_update_url_video').val();
					
					if(url == null || url == "")
					{
						alert("Veuillez saisir l'url d'une video");
						return;
					}
					
					var form_data = new FormData();
					form_data.append('id_article', id_article);
					form_data.append('media', url);
					form_data.append('type', 'add_video');
					form_data.append('doit_inscrit', $('#check_update_add_video').checked);
					
					$.ajax({
			            url: './ModificationArticle',
			            type: 'POST',
			            mimeType:'multipart/form-data',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            success : function(json)
			            {
			            	json = jQuery.parseJSON(json);
			            	
			            	var div = $(document.createElement('div'));
			            	div.attr('class', json.id_media + ' col-md-6');
			            	var bt_delete = $(document.createElement('button'));
			            	bt_delete.attr('id_media', json.id_media);
			            	bt_delete.attr('class', 'bt_delete_video btn btn-sample');
			            	bt_delete.html('Supprimer');
			            	
			            	div.append($('#tb_update_url_video').val());
			            	div.append('<br>');
			            	div.append(bt_delete);
			            	
			            	$('#modif_article_video').append(div);

			            	initialiserUpdateArticle();
			            }
			        });
				});
			}
			
			function hideOnglet()
			{
				$('#update_content').hide();
				$('#update_gestion_photo').hide();
				$('#update_video').hide();
				$('#update_pdf').hide();
			}
			
			$('.onglet').on('click', function(){
				
				if(id_article == 7 || id_article == 11)
				{
					$('#onglet_pdf').attr('class', 'onglet hide');
					$('#onglet_photo').attr('class', 'onglet hide');
					$('#onglet_video').attr('class', 'onglet hide');
				}
				else
				{
					$('.onglet').attr('class', 'onglet');
					$(this).attr('class', 'onglet active');
				}
				
				hideOnglet();
				
				switch($(this).attr('id'))
				{
				case 'onglet_contenu' :
					$('#update_content').show();
					break;
				case 'onglet_photo' :
					$('#update_gestion_photo').show();
					break;
				case 'onglet_pdf' :
					$('#update_pdf').show();
					break;
				case 'onglet_video' :
					$('#update_video').show();
					break;
				}
				
			});
			
			//*************************************************************************************
			
			function initialiserModal()
			{
				$('.myImg').unbind('click');
				
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
				
				span.onclick = function() {
					$('html, body').css({
						overflow : 'auto',
						height : 'auto'
					});
					modal.style.display = "none";
					$('#id' + current_page).addClass('active');
				}
			}
			
			// ----------------------	Gestion clown ------------------------
			
			var id_clown;
			
			$('#gestion_clowns').hide();
 			$('#file_change_portrait_clown').hide();
 			$('#file_add_photo_clown').hide();
 			$('#add_clown').hide();
			
			$('#bt_gestion_clowns').on('click', function(){
				if($('#gestion_clowns').is(':visible'))
					$('#gestion_clowns').hide();
				else
				{
					if($('#page_galerie').is(':visible'))
						$('#page_galerie').hide();
					
					if($('#page_modif_article').is(':visible'))
						$('#page_modif_article').hide();
					
					$.ajax({
			            url: './ModificationClowns',
			            type: 'GET',
			            mimeType:'multipart/form-data',
			            success : function(json)
			            {
			            	json = jQuery.parseJSON(json);
			            	$('#select_clown').html("");
			            	$('#select_clown').append("<option disabled selected value hidden></option>");
			            	
							$('#info_clown').html("");

							$.each(json, function(i)
							{
			            		
								var option = $(document.createElement('option'));
								option.attr('id_clown', json[i].id_clown);
								option.attr('id', 'onglet_' + json[i].id_clown);
								option.html(json[i].nom);
	
								$('#select_clown').append(option);
								
								var div = $(document.createElement('div'));
								div.attr('id', 'clown_' + json[i].id_clown);
								div.attr('class', 'info_clown');
								
								var div_medias = $(document.createElement('div'));
								div_medias.attr('id', 'medias_' + json[i].id_clown);
								div_medias.attr('class', 'col-md-6');
								
								var div_scroll_bar_wrap = $(document.createElement('div'));
								div_scroll_bar_wrap.attr('class', 'scroll-bar-wrap');
								
								var div_scroll_box = $(document.createElement('div'));
								div_scroll_box.attr('id', 'medias_content_' + json[i].id_clown);
								div_scroll_box.attr('class', 'scroll-box');
								
								var div_cover_bar = $(document.createElement('div'));
								div_cover_bar.attr('class', 'cover-bar');
								
								div_scroll_bar_wrap.append(div_scroll_box);
								div_scroll_bar_wrap.append(div_cover_bar);
								div_medias.append(div_scroll_bar_wrap);
								
								var div_portrait = $(document.createElement('div'));
								div_portrait.attr('class', 'col-md-6');
								
								
								
								$.each(json[i].medias, function(ii)
								{
									if(json[i].medias[ii].type === "portrait")
									{
										var img = $(document.createElement('img'));
										img.attr('src', json[i].medias[ii].chemin);
										img.attr('id', 'portrait_' + json[i].id_clown);
										img.attr('height', '400px');
										img.attr('width', 'auto');	
										var tb = $(document.createElement('input'));
										tb.attr('type', 'text');
										tb.attr('id', 'tb_clown_' + json[i].id_clown);
										tb.val(json[i].nom);
										
										var bt_renomer = $(document.createElement('button'));
										bt_renomer.attr('id_clown', json[i].id_clown);
										bt_renomer.html('Renommer');
										bt_renomer.attr('class', 'bt_rename_clown btn btn-sample');
										
										var bt_changer_portrait = $(document.createElement('button'));
										bt_changer_portrait.attr('id_clown', json[i].id_clown);
										bt_changer_portrait.html('Changer portrait');
										bt_changer_portrait.attr('class', 'bt_change_portrait_clown btn btn-sample');
										
										div_portrait.append(img);
										div_portrait.append('<br>');
										div_portrait.append(tb);
										div_portrait.append('<br>');
										div_portrait.append(bt_renomer);
										div_portrait.append(bt_changer_portrait);
										
										div.append(div_portrait);
									}
									else if(json[i].medias[ii].type === "photo")
									{
										var div_media = $(document.createElement('div'));
										div_media.attr('id', 'clown_media_' + json[i].medias[ii].id_media);
										div_media.attr('class', 'col-md-4');
										var img = $(document.createElement('img'));
										img.attr('id', 'img_clown_' + json[i].medias[ii].id_media);
										img.attr('src', json[i].medias[ii].chemin);
										img.attr('class', 'myImg img-thumbnail');
										var tb = $(document.createElement('input'));
										tb.attr('type', 'text');
										tb.attr('id', 'tb_clown_media_' + json[i].medias[ii].id_media);
										tb.val(json[i].medias[ii].nom);
										
										var bt_renomer = $(document.createElement('button'));
										bt_renomer.attr('id_media', json[i].medias[ii].id_media);
										bt_renomer.html('Renommer');
										bt_renomer.attr('class', 'bt_rename_media_clown btn btn-sample');
										
										var bt_delete = $(document.createElement('button'));
										bt_delete.attr('id_media', json[i].medias[ii].id_media);
										bt_delete.html('Supprimer');
										bt_delete.attr('class', 'bt_delete_media_clown btn btn-sample');
										
										div_media.append(img);
										div_media.append('<br>');
										div_media.append(tb);
										div_media.append('<br>');
										div_media.append(bt_renomer);
										div_media.append(bt_delete);
										
										div_scroll_box.append(div_media);
									}
								});
								
								var bt_add_photo = $(document.createElement('button'));
								bt_add_photo.attr('id_clown', json[i].id_clown);
								bt_add_photo.attr('class', 'bt_add_photo_clown btn btn-sample');
								bt_add_photo.html('Ajouter photo');
								
								var div_add_photo = $(document.createElement('div'));
								var lb = $(document.createElement('label'));
								var tb_name_photo = $(document.createElement('input'));
								var bt_import_photo = $(document.createElement('button'));
								var bt_submit_photo = $(document.createElement('button'));
								
								div_add_photo.attr('id', 'add_photo_clown_' + json[i].id_clown);
								div_add_photo.attr('class', 'row');
								
								lb.attr('for', 'tb_name_add_photo_clown');
								lb.html('Nom de la photo ')
								
								tb_name_photo.attr('type', 'text');
								tb_name_photo.attr('id', 'tb_name_add_photo_clown_' + json[i].id_clown);
								
								bt_import_photo.attr('class', 'bt_import_photo_clown btn btn-sample');
								bt_import_photo.html('Import photo');
								
								bt_submit_photo.attr('class', 'bt_submit_photo_clown btn btn-sample');
								bt_submit_photo.html('Valider');
								
								div_add_photo.append(lb);
								div_add_photo.append(tb_name_photo);
								div_add_photo.append(bt_import_photo);
								div_add_photo.append(bt_submit_photo);
								div_add_photo.prop('hidden', true);
								
								div_medias.append(bt_add_photo);
								div_medias.append(div_add_photo);
								div.append(div_portrait);
								div.append(div_medias);
								
								var bt_delete_clown = $(document.createElement('button'));
								bt_delete_clown.attr('class', 'bt_clown_delete btn btn-sample');
								bt_delete_clown.html("Supprimer clown");
								
								div_medias.append(div_add_photo);
								div.append(div_portrait);
								div.append(div_medias);
								
								div.append(bt_delete_clown);
								
								div.prop('hidden', true);
								$('#info_clown').append(div);
			            	});
							
							initialiserClown();
			            }
			        });
					
					
					$('#gestion_clowns').show();
				}
			});
			
			$('#select_clown').change(function(){
				id_clown = $('option:selected', this).attr('id_clown');
				$('.info_clown').hide();
				$('#clown_' + id_clown).show();
		    });
			
			$('#file_change_portrait_clown').on('change', function(){
				var form_data = new FormData();
				form_data.append('type', 'change_portrait_clown');
				form_data.append('id_clown', id_clown);
				form_data.append('media', this.files[0]);
				
				$.ajax({
		            url: './ModificationClowns',
		            type: 'POST',
		            contentType: false,
		            processData: false,
		            data: form_data,
		            mimeType:'multipart/form-data',
		            success : function(json)
		            {
		            	$('#portrait_' + id_clown).attr('src', $('#portrait_' + id_clown).attr('src') + "?1");
		            }
		        });
			});
			
			$('#bt_clown_add').on('click', function(){
				if($('#add_clown').is(':visible'))
					$('#add_clown').hide();
				else
					$('#add_clown').show();
			});
			
			$('#bt_submit_add_clown').on('click', function(){
				var name_clown = $('#tb_name_add_clown').val();
				var file = $('#file_add_photo_clown')[0].files[0];
	
				if(name_clown == null || name_clown == "")
				{
					alert("Veuillez saisir le nom du clown");
					return;
				}
				
				if(file == null)
				{
					alert("Veuillez importer l'image de portrait du clown");
					return;
				}
				
				var form_data = new FormData();
				form_data.append('type', 'add_clown');
				form_data.append('name_clown', name_clown);
				form_data.append('media', file);
				
				$.ajax({
			        url: './ModificationClowns',
			        type: 'POST',
			        contentType: false,
			        processData: false,
			        data: form_data,
			        mimeType:'multipart/form-data',
			        success : function(json)
			        {
						location.reload();
			        }
			    });
			});
			
			$('#bt_get_add_clown').on('click', function()
			{
				$('#file_add_photo_clown').click();
			});
			
			function initialiserClown()
			{
				
				$('.bt_rename_clown').unbind('click');
				$('.bt_change_portrait_clown').unbind('click');
 				$('.bt_add_photo_clown').unbind('click');
 				$('.bt_import_photo_clown').unbind('click');
 				$('.bt_submit_photo_clown').unbind('click');
 				$('.bt_delete_media_clown').unbind('click');
 				$('.bt_rename_media_clown').unbind('click');
 				$('.bt_clown_delete').unbind('click');
				
				$('.bt_rename_clown').on('click', function(){
					var id_clown = $(this).attr('id_clown');
					var new_name = $('#tb_clown_' + id_clown).val();
					
					if(new_name == null || new_name == "")
					{
						alert("Veuillez saisir un nom pour l'image");
						return;
					}
					
					var form_data = new FormData();
					form_data.append('type', 'rename_clown');
					form_data.append('id_clown', id_clown);
					form_data.append('new_name', new_name);
					
					$.ajax({
			            url: './ModificationClowns',
			            type: 'POST',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            mimeType:'multipart/form-data',
			            success : function(json)
			            {
			            	alert('Clown renommé');
			            }
			        });
				});
				
				$('.bt_change_portrait_clown').on('click', function(){
					$('#file_change_portrait_clown').click();
				});
				
				$('.bt_add_photo_clown').on('click', function(){
					if($('#add_photo_clown_' + id_clown).is(':visible'))
						$('#add_photo_clown_' + id_clown).hide();
					else
						$('#add_photo_clown_' + id_clown).show();
				});
				
				$('.bt_import_photo_clown').on('click',function(){
					$('#file_add_photo_clown').click();
				});
				
				$('.bt_submit_photo_clown').on('click', function(){
					var name = $('#tb_name_add_photo_clown_' + id_clown).val();
					var file = $('#file_add_photo_clown')[0].files[0];
					console.log(id_clown);
					if(name == null || name == "")
					{
						alert("Veuillez saisir un nom pour l'image");
						return;						
					}
					
					if(file == null)
					{
						alert("Veuillez importer une image");
						return;						
					}
					
					var form_data = new FormData();
					form_data.append('type', 'add_media');
					form_data.append('id_clown', id_clown);
					form_data.append('name', name);
					form_data.append('media', file);
					
					$.ajax({
			            url: './ModificationClowns',
			            type: 'POST',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            mimeType:'multipart/form-data',
			            success : function(json)
			            {
			            	json = $.parseJSON(json);
			            	
			            	var div_media = $(document.createElement('div'));
			            	div_media.attr('id', 'clown_media_' + json.id_media);
							div_media.attr('class', 'col-md-4');
							var img = $(document.createElement('img'));
							img.attr('id', 'img_clown_' + json.id_media);
							img.attr('src', json.chemin);
							img.attr('class', 'myImg img-thumbnail');
							var tb = $(document.createElement('input'));
							tb.attr('type', 'text');
							tb.attr('id', 'tb_clown_media_' + json.id_media);
							tb.val(json.name);
							
							var bt_renomer = $(document.createElement('button'));
							bt_renomer.attr('id_media', json.id_media);
							bt_renomer.html('Renommer');
							bt_renomer.attr('class', 'bt_rename_media_clown btn btn-sample');
							
							var bt_delete = $(document.createElement('button'));
							bt_delete.attr('id_media', json.id_media);
							bt_delete.html('Supprimer');
							bt_delete.attr('class', 'bt_delete_media_clown btn btn-sample');
							
							div_media.append(img);
							div_media.append('<br>');
							div_media.append(tb);
							div_media.append('<br>');
							div_media.append(bt_renomer);
							div_media.append(bt_delete);
							
							$('#medias_content_' + id_clown).append(div_media);
			            }
			        });
				});
				
				$('.bt_delete_media_clown').on('click', function(){
					var id_media = $(this).attr('id_media');
					var form_data = new FormData();
					form_data.append('type', 'delete_media');
					form_data.append('chemin', $('#img_clown_' + id_media).attr('src'));
					form_data.append('id_media', id_media);
					
					$.ajax({
			            url: './ModificationClowns',
			            type: 'POST',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            mimeType:'multipart/form-data',
			            success : function(json)
			            {
							$('#clown_media_' + id_media).remove();
			            }
			        });
				});
				
				$('.bt_rename_media_clown').on('click', function(){
					var id_media = $(this).attr("id_media");
					var new_name = $('#tb_clown_media_' + id_media);
					
					if(new_name == null || new_name == "")
					{
						alert("Veuillez saisir un nom pour l'image");
						return;
					}
					
					var form_data = new FormData();
					form_data.append('type', 'rename_media');
					form_data.append('id_media', id_media);
					form_data.append('new_name', new_name);
					
					$.ajax({
			            url: './ModificationClowns',
			            type: 'POST',
			            contentType: false,
			            processData: false,
			            data: form_data,
			            mimeType:'multipart/form-data',
			            success : function(json)
			            {
			            }
			        });
				});
				
				$('.bt_clown_delete').on('click', function(){
					if(confirm("Voulez-vous vraiment supprimer le clown sélectionné ?\nLe clown ainsi que toutes les photos associées seront supprimées."))
					{
						var form_data = new FormData();
						form_data.append('type', 'delete_clown');
						form_data.append('id_clown', id_clown);
						
						$.ajax({
				            url: './ModificationClowns',
				            type: 'POST',
				            contentType: false,
				            processData: false,
				            data: form_data,
				            mimeType:'multipart/form-data',
				            success : function(json)
				            {
 								location.reload();
				            }
				        });
					}
				});
			}
		});
		
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
	</script>
	<button id="bt_galerie" class="btn btn-sample">Gestion galerie</button> <button id="bt_modif_article" class="btn btn-sample">Modifier article</button> <button id="bt_gestion_clowns" class="btn btn-sample">Gestion des clowns</button> <button id="bt_gestion_users" class="btn btn-sample">Gestion des utilisateurs</button>
	
	<!-- -------------------------------- Gestion galerie -------------------------- -->
	
	<div class="row col-md-12" id="page_galerie">
		<div class="container">
			<div id="content" class="row ">
			</div>
			<div id="page_navigation"></div>
		</div>
		<p>
			<button id="bt_galerie_add_photo" class="btn btn-sample">Ajouter photo</button>
		</p>
		<div id="galerie_add_photo_info">
			<p>
				<label for="tb_galerie_name_new_photo">Nom de la photo </label>
				<input type="text" id="tb_galerie_name_new_photo">
				<button id="bt_galerie_get_photo" class="btn btn-sample">Importer photo</button>
				<input type="file" id="file_galerie_get_photo" accept="image/*">
				<button id="bt_galerie_add_photo_submit" class="btn btn-sample">Valider</button>
			</p>
		</div>
	</div>
	
	<!-- -------------------------------- Fin gestion galerie -------------------------- -->
	
	<!-- -------------------------------- Modifier article -------------------------- -->
	
	<div class="row col-md-12" id="page_modif_article" style="margin-bottom: 2%">
		<div class="row" id="modifier_article"  style="margin-top: 3%">
			<p>Veuillez sélectionner l'article à modifier.</p>
			<select id="select" default="">
				<option disabled selected value hidden></option>
				<option id_article="7">Présentation des ateliers</option>
				<option id_article="1">Le pain</option>
				<option id_article="2">Le lait</option>
				<option id_article="3">Les 7 familles</option>
				<option id_article="4">Le menu équilibré</option>
				<option id_article="5">Alimentation et environnement</option>
				<option id_article="6">Le spectacle</option>
				<option disabled value></option>
				<option id_article="11">Présentation de notre démarche</option>
				<option id_article="8">Clown</option>
				<option id_article="9">Pratique et sensoriel</option>
				<option id_article="10">Expression Corporelle</option>
				<option disabled value></option>
				<option id_article="12">Formation</option>
			</select>
		</div>
		
		<div id="update_show_article" class="row">
		
			<ul class="nav nav-tabs">
			    <li id="onglet_contenu" class="onglet active"><a>Contenu</a></li>
			    <li id="onglet_photo" class="onglet"><a>Photo</a></li>
			    <li id="onglet_video" class="onglet"><a>Vidéo</a></li>
			    <li id="onglet_pdf" class="onglet"><a>PDF</a></li>
			  </ul>
			  
			<div id="update_content">
				<textarea id="contenu_article" rows="15" cols="80" style="margin-top: 2%; margin-left: 2%"></textarea><br><button id="bt_submit_update_content" class="btn btn-sample">Mettre à jour</button>
			</div>
			
			<div id="update_gestion_photo">
				<div class="scroll-bar-wrap-admin">
					<div id="modif_article_image" class="scroll-box-admin">
					</div>
					<div class="cover-bar">
					</div>
				</div>
				<button id="bt_update_add_photo" class="btn btn-sample">Ajouter photo</button>
				<div id="update_add_photo_info" style="margin-top: 2%">
					<label for="tb_update_name_photo">Nom de la photo </label>
					<input type="text" id="tb_update_name_photo">
					<input type="checkbox" id="check_update_add_photo">Inscription requise ?<br>
					<button id="bt_update_get_photo" class="btn btn-sample">Importer photo</button>
					<input type="file" id="file_update_get_photo" accept="image/*">
					<button id="bt_update_add_photo_submit" class="btn btn-sample">Valider</button>
				</div>
			</div>
			
			<div id="update_pdf">
				<div class="scroll-bar-wrap-admin">
					<div id="modif_article_pdf" class="scroll-box-admin">
					</div>
					<div class="cover-bar">
					</div>
				</div>
				<button id="bt_update_add_pdf" class="btn btn-sample">Ajouter PDF</button>
				<div id="update_get_pdf" class="row" hidden>
					<input type="file" id="file_update_get_pdf" accept="application/pdf">
					<label for="tb_update_get_pdf">Nom du PDF :</label>
					<input type="text" id="tb_update_name_pdf">
					<input type="checkbox" id="check_update_add_pdf">Inscription requise ?<br>
					<button id="bt_update_get_pdf" class="btn btn-sample">Importer PDF</button>
					<button id="bt_update_submit_pdf" class="btn btn-sample">Valider</button>
				</div>
			</div>
			
			<div id="update_video">
				<div class="scroll-bar-wrap-admin">
					<div id="modif_article_video" class="scroll-box-admin">
					</div>
					<div class="cover-bar">
					</div>
				</div>
				<button id="bt_update_add_video" class="btn btn-sample">Ajouter vidéo</button>
				<div id="update_get_video" class="row" hidden>
					<label for="tb_update_url_video">Lien de la vidéo :</label>
					<input type="text" id="tb_update_url_video">
					<input type="checkbox" id="check_update_add_video">Inscription requise ?<br>
					<button id="bt_update_submit_video" class="btn btn-sample">Valider</button>
				</div>
			</div>
			
		</div>
	</div>
	
	<!-- -------------------------------- Fin modifier article -------------------------- -->
	
	<!-- -------------------------------- Gestion clowns -------------------------------- -->
	
	<div id="gestion_clowns" class="row col-md-12" style="margin-bottom: 2%">
		<div class="row" style="margin-top: 3%">
			<p>Veuillez sélectionner le clown à modifier.</p>
			<select id="select_clown" default="">
				<option disabled selected value hidden></option>
			</select>
			<button id="bt_clown_add" class="btn btn-sample">Ajouter clown</button>
			<div id="add_clown">
				<label for="tb_name_add_clown">Nom du clown </label>
				<input type="text" id="tb_name_add_clown">
				<button id="bt_get_add_clown" class="btn btn-sample">Importer portrait</button>
				<button id="bt_submit_add_clown" class="btn btn-sample">Valider</button>
			</div>
		</div>
		<input type="file" id="file_change_portrait_clown" accept="image/*">
		<input type="file" id="file_add_photo_clown" accept="image/*">
		<div id="info_clown" class="row col-md-12">
		</div>
		
	</div>
	
	<!--  ------------------------------- Fin gestion des clowns ------------------------ -->
	
	<!--  -------------------------------  Gestion des users ---------------------------- -->
	
	<div id="gestion_users" class="row col-md-12" style="margin-bottom: 2%">
				
	</div>
	
	<!--  ------------------------------- Fin gestion des users ------------------------ -->

	<div id="myModal" class="modal">
		<span class="close">&times;</span> <img class="modal-content" id="img01">
		<div id="caption"></div>
	</div>

	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>