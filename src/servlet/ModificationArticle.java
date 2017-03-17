package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringEscapeUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.Modele;
import tools.Media;

@WebServlet("/ModificationArticle")
public class ModificationArticle extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setCharacterEncoding("UTF-8");
		JSONObject json = new JSONObject();

		tools.Article article = new Modele().getArticle(request.getParameter("titre").toString());
		json.put("id", article.getId());
		json.put("titre", new StringEscapeUtils().unescapeHtml4(article.getTitre()));
		json.put("contenu", new StringEscapeUtils().unescapeHtml4(article.getContenu()));
		
		JSONArray json_medias = new JSONArray();
		for(Media media : article.getMedias())
		{
			JSONObject json_media = new JSONObject();
			json_media.put("chemin", media.getChemin());
			json_media.put("nom", media.getNom());
			json_media.put("type", media.getType());
			json_media.put("id", media.getId());
			json_medias.add(json_media);
		}
		
		json.put("medias", json_medias);
		response.getWriter().println(json);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String type = request.getParameter("type"); // texte ou photo
		
		if(type.equals("texte"))
		{
			
		}
		else if(type.equals("photo"))
		{
			
		}
	}
}
