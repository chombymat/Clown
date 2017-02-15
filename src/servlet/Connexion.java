package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Connexion")
public class Connexion extends HttpServlet 
{
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String login = request.getParameter("login");
		String pass = request.getParameter("pass");
		
		try
		{
			/*HttpSession session = request.getSession();
			//String[] infos = new model.Connexion().connexion(login, pass);
			session.setAttribute("id_utilisateur", infos[1]);
			session.setAttribute("role", infos[0]);*/
		}
		catch(Exception e)
		{
			request.setAttribute("erreur", "Identifiants/mot de passe incorrect.");
		}
	}
}