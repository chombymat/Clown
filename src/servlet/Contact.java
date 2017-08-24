package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Contact")
public class Contact extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try
		{
			new model.Model().envoyerMailContact(request.getParameter("nom"), request.getParameter("prenom"),
										   request.getParameter("email"), request.getParameter("telephone"),
										   request.getParameter("adresse"), request.getParameter("ville"),
										   request.getParameter("departement"), request.getParameter("profession"),
										   request.getParameter("etablissement"), request.getParameter("message"));
			
			response.getWriter().print("ok");
		}
		catch(Exception e)
		{
			response.getWriter().print("fail");
		}
	}

}