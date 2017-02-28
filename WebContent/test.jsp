<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Galerie Photos</title>
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

  <div class="container">
    <div id="content" class="row">
        <div class="col-lg-2"><img src="images/logo/Logo_PNA2.png" alt="Tigre"></div>
        <div class="col-lg-2"><img src="images/t2.jpg" alt="Tigre" class="img-thumbnail"></div>
        <div class="col-lg-2"><img src="images/t3.jpg" alt="Tigre" class="img-thumbnail"></div>
        <div class="col-lg-2"><img src="images/t4.jpg" alt="Tigre" class="img-thumbnail"></div>
        <div class="col-lg-2"><img src="images/t5.jpg" alt="Tigre" class="img-thumbnail"></div>
        <div class="col-lg-2"><img src="images/t6.jpg" alt="Tigre" class="img-thumbnail"></div>
        <div class="col-lg-2"><img src="images/t7.jpg" alt="Tigre" class="img-thumbnail"></div>
        <div class="col-lg-2"><img src="images/t8.jpg" alt="Tigre" class="img-thumbnail"></div>
        <div class="col-lg-2"><img src="images/t9.jpg" alt="Tigre" class="img-thumbnail"></div>
        <div class="col-lg-2"><img src="images/t10.jpg" alt="Tigre" class="img-thumbnail"></div>
        <div class="col-lg-2"><img src="images/t11.jpg" alt="Tigre" class="img-thumbnail"></div>
        <div class="col-lg-2"><img src="images/t12.jpg" alt="Tigre" class="img-thumbnail"></div>
    </div>
    <div id="page_navigation"> </div>
  </div>

  <script src="assets/js/jquery.js"></script>
  <script> 

    var show_per_page = 3; 
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
      
      var nav = '<ul class="pagination"><li><a href="javascript:previous();">&laquo;</a>';

      var i = -1;
      while(number_of_pages > ++i){
        nav += '<li class="page_link'
        if(!i) nav += ' active';
        nav += '" id="id' + i +'">';
        nav += '<a href="javascript:go_to_page(' + i +')">'+ (i + 1) +'</a>';
      }
      nav += '<li><a href="javascript:next();">&raquo;</a></ul>';

      $('#page_navigation').html(nav);
      set_display(0, show_per_page);
      
    });

  </script>

</body>
</html>