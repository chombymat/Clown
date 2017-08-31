function hideAll(){
	$('#textDemarche').hide();
	$('.photo_clown').hide();
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
$(document).ready(function() 
{
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
	
	$('.portrait_clown').on('click', function(){
		$('.photo_clown').hide();
		
		var id_clown = $(this).attr('id');
		console.log(id_clown);
		$('#photos_' + id_clown).show();
	});
	
});