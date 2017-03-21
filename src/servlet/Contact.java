package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Contact")
public class Contact extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try
		{
			new model.Modele().envoyerMailContact(request.getParameter("nom"), request.getParameter("prenom"),
										   request.getParameter("email"), request.getParameter("telephone"),
										   request.getParameter("adresse"), request.getParameter("ville"),
<<<<<<< HEAD
										   request.getParameter("departement"), request.getParameter("sexe"),
										   request.getParameter("message"));
			response.sendRedirect("./contact.jsp");
=======
										   request.getParameter("departement"), request.getParameter("profession"),
										   request.getParameter("etablissement"), request.getParameter("message"));
>>>>>>> 0c3412b8d72d01280e3b6701abc924ac0eaf2f3e

		}
		catch(Exception e)
		{
			response.getWriter().print("fail");
		}
	}

}