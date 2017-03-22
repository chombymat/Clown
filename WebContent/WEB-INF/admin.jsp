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
				var form_data = new FormData();
				console.log(id_article);
				form_data.append("type", "add_photo");
				form_data.append("id_article", id_article);
				form_data.append('nom', $('#tb_update_name_photo').val());
				form_data.append('media', $('#file_update_get_photo')[0].files[0]);
				
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
				var form_data = new FormData();
				form_data.append("type", "add_pdf");
				form_data.append("id_article", id_article);
				form_data.append('nom', $('#tb_update_name_pdf').val());
				form_data.append('media', $('#file_update_get_pdf')[0].files[0]);
				
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
				$('.bt_delete_photo').unbind('click');
				$('.bt_delete_pdf').unbind('click');
				$('bt_delete_video').unbind('click');
				
				initialiserModal();
				
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
					var form_data = new FormData();
					form_data.append('id_article', id_article);
					form_data.append('media', $('#tb_update_url_video').val());
					form_data.append('type', 'add_video');
					
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
	<button id="bt_galerie" class="btn btn-sample">Gestion galerie</button> <button id="bt_modif_article" class="btn btn-sample">Modifier article</button>
	
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
		<div class="row" id="modifier_article">
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
					<button id="bt_update_submit_video" class="btn btn-sample">Valider</button>
				</div>
			</div>
			
		</div>
	</div>
	
	<!-- -------------------------------- Fin modifier article -------------------------- -->
	
	<!-- -------------------------------- Gestion clowns -------------------------- -->
	

	<div id="myModal" class="modal">
		<span class="close">&times;</span> <img class="modal-content" id="img01">
		<div id="caption"></div>
	</div>

	<%@include file="/WEB-INF/footer.html"%>
</body>
</html>