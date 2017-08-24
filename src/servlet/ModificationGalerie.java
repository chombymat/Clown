package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.Model;
import tools.Media;

@WebServlet("/ModificationGalerie")
@MultipartConfig()
public class ModificationGalerie extends HttpServlet 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		Model modele = new Model();
		ArrayList<Media> galerie = modele.getGalerie();
		
		JSONArray j_array = new JSONArray();
		
		for(Media media : galerie)
		{
			JSONObject json = new JSONObject();
			
			json.put("id_media", media.getId());
			json.put("nom", media.getNom());
			json.put("chemin", media.getChemin());
			
			j_array.add(json);
		}
		
		response.getWriter().print(j_array);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String type = IOUtils.toString(request.getPart("type").getInputStream(), "UTF-8"); 
		Model modele = new Model();
		int id_media = -1;
		
		if(request.getPart("id_media") != null)
			id_media = Integer.valueOf(IOUtils.toString(request.getPart("id_media").getInputStream(), "UTF-8"));
		
		switch(type)
		{
		case "add" :
			String nom = IOUtils.toString(request.getPart("name").getInputStream(), "UTF-8");
			String extension = request.getPart("media").getSubmittedFileName().substring(request.getPart("media").getSubmittedFileName().lastIndexOf("."));
			id_media = modele.ajouterMedia("images/galerie/", "galerie", nom, extension);
			modele.saveMediaOnDisk(getServletContext().getRealPath("/") + "images/galerie/", request.getPart("media"), id_media);
			JSONObject json = new JSONObject();
			json.put("id_media", id_media);
			json.put("chemin", "images/galerie/" + id_media + extension);
			json.put("nom", nom);
			response.getWriter().println(json);
			break;
		case "rename" :
			String new_name = IOUtils.toString(request.getPart("new_name").getInputStream(), "UTF-8");
			modele.renameMedia(id_media, new_name);
			break;
		case "delete" :
			String chemin = IOUtils.toString(request.getPart("chemin").getInputStream(), "UTF-8");
			modele.supprimerMedia(getServletContext().getRealPath("/") + chemin , id_media);
			break;
		}
	}
}
