package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tools.Utilisateur;

@WebServlet("/Administration")
public class Administration extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		if(((Utilisateur)request.getSession().getAttribute("user")) == null)
		{
			response.sendRedirect("./connexion.jsp");
		}
		else if(((Utilisateur)request.getSession().getAttribute("user")).getRole().equals("role4"))
		{
			request.getRequestDispatcher("/WEB-INF/admin.jsp").forward(request, response);
		}
		else
		{
			request.setAttribute("erreur", "Vous n'avez pas les privilèges suffisant pour accéder à cette page.");
			request.getRequestDispatcher("/WEB-INF/erreur.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}
}
