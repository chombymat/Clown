package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Modele;
import tools.Utilisateur;

@WebServlet("/connexion")
public class Connexion extends HttpServlet 
{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		Modele model = new Modele();
		try
		{
			if((String)request.getParameter("oubliPass") != null){
				response.sendRedirect("./forgotPassword.jsp");
				
			} else {
				String login = request.getParameter("login");
				String pass = request.getParameter("pass");
				HttpSession session = request.getSession();
				Utilisateur user = model.connexion(login, pass);
				session.setAttribute("user", user);
				response.getWriter().print("ok");
			}
		}
		catch(Exception e)
		{
			response.getWriter().print("fail");
		}
	}
}