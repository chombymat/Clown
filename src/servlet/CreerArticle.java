package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

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

			Collection<Part> parts = request.getParts();
			ArrayList<Part> media = new ArrayList<Part>();
			String contenu = "", titre = "", description = "";
			HashMap<String, Boolean> erreurs = new HashMap<String, Boolean>();
			boolean isAjax = false;

			for(Part part : parts)
			{
				if(part.getName().equals("contenu"))
					contenu = IOUtils.toString(part.getInputStream(), "UTF-8"); 
				if(part.getName().equals("titre"))
					titre = IOUtils.toString(part.getInputStream(), "UTF-8"); 
				if(part.getName().equals("description"))
					description = IOUtils.toString(part.getInputStream(), "UTF-8"); 
				if(part.getName().indexOf("media_") != -1)
					media.add(part);
				if(part.getName().equals("ajax"))
					isAjax = true;
			}

			JSONObject json = new JSONObject();

			if(contenu.equals(""))
			{
				erreurs.put("erreur_contenu", true);
			}
			if(titre.equals(""))
			{
				erreurs.put("erreur_titre", true);
			}
			if(description.equals(""))
			{
				erreurs.put("erreur_description", true);
			}

			if(erreurs.isEmpty())
			{
				int id = model.ajouterArticle(titre, description, contenu);
				
				model.saveMediaOnDisk(getServletContext().getRealPath("/") + "images/article/" + id + "/", media, id);
				
				if(isAjax)
				{
					response.setContentType("application/json");
					json.put("article_creer", "L'article a était créer");
					response.getWriter().print(json);
					response.getWriter().flush();
				}
				else
				{
					request.setAttribute("page_article", true);
					request.setAttribute("article_creer", "L'article a était créer");
					request.getRequestDispatcher("/WEB-INF/admin.jsp").forward(request, response);
				}
			}
			else // Erreurs présente
			{
				if(isAjax)
				{
					response.setContentType("application/json");
					if(erreurs.containsKey("erreur_titre"))
						json.put("erreur_titre", true);
					if(erreurs.containsKey("erreur_description"))
						json.put("erreur_description", true);
					if(erreurs.containsKey("erreur_contenu"))
						json.put("erreur_contenu", true);
					response.getWriter().print(json);
					response.getWriter().flush();
				}
				else
				{
					request.setAttribute("page_article", true);
					if(erreurs.containsKey("erreur_titre"))
						request.setAttribute("erreur_titre", true);
					if(erreurs.containsKey("erreur_description"))
						request.setAttribute("erreur_description", true);
					if(erreurs.containsKey("erreur_contenu"))
						request.setAttribute("erreur_contenu", true);
					request.getRequestDispatcher("/WEB-INF/admin.jsp").forward(request, response);
				}
			}
		}
	}
}
