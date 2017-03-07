package servlet;

import java.io.File;
import java.io.IOException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.IOUtils;

import model.Modele;
import tools.Utilisateur;

@WebServlet("/creerArticle")
@MultipartConfig()
public class CreerArticle extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.getWriter().append("get");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		if(((Utilisateur)request.getSession().getAttribute("user")) == null)
		{
			response.sendRedirect("./connexion.jsp");
		}
		else if(!((Utilisateur)request.getSession().getAttribute("user")).getRole().equals("role4"))
		{
			request.setAttribute("erreur", "Vous n'avez pas les privilèges suffisant pour accéder à cette page.");
			request.getRequestDispatcher("/WEB-INF/erreur.jsp").forward(request, response);
		}
		else
		{
			Modele model = new Modele();
			
			Collection<Part> media = request.getParts();
			for(Part p : media)
			{
				if(p.getName().equals("contenu") || p.getName().equals("titre") || p.getName().equals("description"))
				{
					String theString = IOUtils.toString(p.getInputStream(), "UTF-8"); 
					System.out.println(p.getName() + " : " + theString);
				}
				if(p.getName().indexOf("media_") != -1)
					model.saveMediaOnDisqk(getServletContext().getRealPath("/") + "images/article/", p);
			}			
		}
	}
}
