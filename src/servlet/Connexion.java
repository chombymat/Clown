package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import tools.Utilisateur;

@WebServlet("/connexion")
public class Connexion extends HttpServlet 
{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String login = request.getParameter("login");
		String pass = request.getParameter("pass");
		
		try
		{
			HttpSession session = request.getSession();
			Utilisateur user = new model.Modele().connexion(login, pass);
			session.setAttribute("user", user);
			response.sendRedirect("./index.jsp");
		}
		catch(Exception e)
		{
			request.setAttribute("erreur", "Identifiants/mot de passe incorrect.");
			request.getRequestDispatcher("/connexion.jsp").forward(request, response);
		}
	}
}