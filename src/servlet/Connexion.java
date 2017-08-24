package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Model;
import tools.Utilisateur;

@WebServlet("/connexion")
public class Connexion extends HttpServlet 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		Model model = new Model();
		try
		{
			String login = request.getParameter("login");
			String pass = request.getParameter("pass");
			HttpSession session = request.getSession();
			Utilisateur user = model.connexion(login, pass);
			session.setAttribute("user", user);
			response.getWriter().print("ok");
		}
		catch(Exception e)
		{
			response.getWriter().print("fail");
		}
	}
}