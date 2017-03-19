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

import model.Modele;
import tools.Media;

@WebServlet("/ModificationGalerie")
@MultipartConfig()
public class ModificationGalerie extends HttpServlet 
{
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		Modele modele = new Modele();
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
		Modele modele = new Modele();
		int id_media = -1;
		
		if(request.getPart("id_media") != null)
			id_media = Integer.valueOf(IOUtils.toString(request.getPart("id_media").getInputStream(), "UTF-8"));
		
		switch(type)
		{
		case "add" :
			String nom = IOUtils.toString(request.getPart("name").getInputStream(), "UTF-8");
			modele.saveMediaOnDisk(getServletContext().getRealPath("/") + "images/galerie/", request.getPart("media"));
			id_media = modele.ajouterMedia("images/galerie/" + request.getPart("media").getSubmittedFileName(), "galerie", nom);
			JSONObject json = new JSONObject();
			json.put("id_media", id_media);
			json.put("chemin", "images/galerie/" + request.getPart("media").getSubmittedFileName());
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
