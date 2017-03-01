<%@ page import="tools.Media"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Galerie Photos La Prima Porta.com</title>
<link href="assets/css/bootstrap.css" rel="stylesheet">
<link rel="icon" type="image/png" href="http://www.laprimaporta.com/wp-content/uploads/2016/01/fav.png" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="style.css" />
</head>
<%@include file="/WEB-INF/navbar.jsp"%>
</head>
<body>
<script>
// Get the modal

$(document).ready(function(){
	var modal = document.getElementById('myModal');

	// Get the image and insert it inside the modal - use its "alt" text as a caption

	$('.myImg').on('click', function(){
		$('html, body').css({
			overflow: 'hidden',
			height: '100%'
		});
		$('#myModal').attr('style', 'display: block');
		$('#img01').attr('src', $(this).attr('src'));
		$('#caption').html($(this).attr('alt'));
	});
	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() { 
		$('html, body').css({
			overflow: 'auto',
			height: 'auto'
		});
	    modal.style.display = "none";
	}
	
});
</script>

<div class="container">
    <div id="content" class="row ">
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Capture-2.png" alt="Trolltunga, Norway"></div>
        <div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Plage deserte.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/logo_NordActif_3500x900.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Capture-2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/Logo_PNA2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Plage deserte.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/logo_NordActif_3500x900.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/Logo_PNA2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Plage deserte.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Capture-2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/logo_NordActif_3500x900.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Capture-2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/Logo_PNA2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Plage deserte.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/logo_NordActif_3500x900.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/Logo_PNA2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Plage deserte.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Capture-2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/logo_NordActif_3500x900.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Capture-2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/Logo_PNA2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Plage deserte.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/logo_NordActif_3500x900.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/Logo_PNA2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Plage deserte.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Capture-2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Capture-2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/logo_NordActif_3500x900.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/Logo_PNA2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Plage deserte.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/logo_NordActif_3500x900.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/Logo_PNA2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/Logo_PNA2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Plage deserte.jpg" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/images/Capture-2.png" alt="Trolltunga, Norway"></div>
		<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2"><img class="myImg img-thumbnail" src="images/logo/logo_NordActif_3500x900.jpg" alt="Trolltunga, Norway"></div>
	    </div>
    <div id="page_navigation"> </div>
  </div>

  <script src="assets/js/jquery.js"></script>
  <script> 

    var show_per_page = 18; 
    var current_page = 0;

    function set_display(first, last) {
      $('#content').children().css('display', 'none');
      $('#content').children().slice(first, last).css('display', 'block');
    }

    function previous(){
        if($('.active').prev('.page_link').length) go_to_page(current_page - 1);
    }

    function next(){
        if($('.active').next('.page_link').length) go_to_page(current_page + 1);
    }

    function go_to_page(page_num){
      current_page = page_num;
      start_from = current_page * show_per_page;
      end_on = start_from + show_per_page;
      set_display(start_from, end_on);
      $('.active').removeClass('active');
      $('#id' + page_num).addClass('active');
    }  

    $(document).ready(function() {

      var number_of_pages = Math.ceil($('#content').children().length / show_per_page);
      
      var nav = '<ul class="pagination"><li><a id="page" href="javascript:previous();">&laquo;</a>';

      var i = -1;
      while(number_of_pages > ++i){
        nav += '<li class="page_link'
        if(!i) nav += ' active';
        nav += '" id="id' + i +'">';
        nav += '<a id="page" href="javascript:go_to_page(' + i +')">'+ (i + 1) +'</a>';
      }
      nav += '<li><a id="page" href="javascript:next();">&raquo;</a></ul>';

      $('#page_navigation').html(nav);
      set_display(0, show_per_page);
      
    });

  </script>

<!-- The Modal -->
<div id="myModal" class="modal">
  <span class="close">&times;</span>
  <img class="modal-content" id="img01">
  <div id="caption"></div>
</div>

<%@include file="/WEB-INF/footer.html"%>
</body>
</html>