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