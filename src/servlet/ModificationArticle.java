package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import model.Modele;
import tools.Media;

@WebServlet("/ModificationArticle")
@MultipartConfig()
public class ModificationArticle extends HttpServlet 
{
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setCharacterEncoding("UTF-8");
		JSONObject json = new JSONObject();

		tools.Article article = new Modele().getArticle(request.getParameter("titre").toString());
		json.put("id", article.getId());
		json.put("id_projet", article.getId_projet());
		json.put("titre", article.getTitre());
		json.put("contenu", article.getContenu());
		
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

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String type = IOUtils.toString(request.getPart("type").getInputStream(), "UTF-8"); 
		Modele modele = new Modele();
		String id_article = "";
		int id_media = -1;
		
		if(request.getPart("id_article") != null)
			id_article = IOUtils.toString(request.getPart("id_article").getInputStream(), "UTF-8");
		
		if(request.getPart("id_media") != null)
			id_media = Integer.valueOf(IOUtils.toString(request.getPart("id_media").getInputStream(), "UTF-8"));
		
		switch(type)
		{
		case "add_photo" :
			String id_projet = IOUtils.toString(request.getPart("id_projet").getInputStream(), "UTF-8");
			String nom = IOUtils.toString(request.getPart("nom").getInputStream(), "UTF-8");
			modele.saveMediaOnDisk(getServletContext().getRealPath("/") + "images/" + id_projet + "/" + id_article + "/PHOTOS_ENFANTS/", request.getPart("media"));
			id_media = modele.ajouterMedia("images/" + id_projet + "/" + id_article + "/PHOTOS_ENFANTS/" + request.getPart("media").getSubmittedFileName(), "photo", Integer.valueOf(id_article), nom);
			JSONObject json = new JSONObject();
			json.put("id_media", id_media);
			json.put("nom", nom);
			response.getWriter().println(json);
			break;
		case "texte" :
			String texte = IOUtils.toString(request.getPart("texte").getInputStream(), "UTF-8");
			modele.updateArticle(id_article, texte);
			break;
		case "delete_photo" :
			String chemin = IOUtils.toString(request.getPart("chemin").getInputStream(), "UTF-8");
			modele.supprimerMedia(getServletContext().getRealPath("/") + chemin, id_media);
			break;
		case "rename_photo" :
			String newName = IOUtils.toString(request.getPart("newName").getInputStream(), "UTF-8");
			modele.renameMedia(id_media, newName);
			break;
		}
	}
}
