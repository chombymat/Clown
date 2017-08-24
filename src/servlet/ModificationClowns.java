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
import tools.Clown;
import tools.Media;

@WebServlet("/ModificationClowns")
@MultipartConfig()
public class ModificationClowns extends HttpServlet 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		ArrayList<Clown> clowns = new ArrayList<Clown>(new Model().getClowns().values());
		
		JSONArray j_array = new JSONArray();
		
		for(Clown clown : clowns)
		{
			JSONObject json = new JSONObject();
			JSONArray medias = new JSONArray();
			
			json.put("nom", clown.getName());
			json.put("id_clown", clown.getId_clown());
			
			for(Media media : clown.getList_media())
			{
				JSONObject j_media = new JSONObject();
				
				j_media.put("type", media.getType());
				j_media.put("id_media", media.getId());
				j_media.put("chemin", media.getChemin());
				j_media.put("nom", media.getNom());
				
				medias.add(j_media);
			}
			json.put("medias", medias);
		
			j_array.add(json);
		}
		
		response.getWriter().print(j_array);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String type = IOUtils.toString(request.getPart("type").getInputStream(), "UTF-8");
		int id_clown = 0;
		String new_name;
		if(request.getPart("id_clown") != null)
			id_clown = Integer.valueOf(IOUtils.toString(request.getPart("id_clown").getInputStream(), "UTF-8"));
		int id_media;
		Model modele = new Model();
		
		switch(type)
		{
		case "rename_clown" :
			new_name = IOUtils.toString(request.getPart("new_name").getInputStream(), "UTF-8");
			modele.renameClown(id_clown, new_name);
			break;
		case "change_portrait_clown" :
			modele.changePortraitClown(request.getServletContext().getRealPath("/"), id_clown, request.getPart("media"));
			break;
		case "add_media" :
			String name_media = IOUtils.toString(request.getPart("name").getInputStream(), "UTF-8");
			Object[] return_values = modele.addPhotoClown(id_clown, getServletContext().getRealPath("/"), name_media, request.getPart("media"));
			JSONObject json = new JSONObject();
			json.put("id_media", return_values[0]);
			json.put("chemin", return_values[1]);
			json.put("name", name_media);
			response.getWriter().print(json);
			break;
		case "delete_media" :
			id_media = Integer.valueOf(IOUtils.toString(request.getPart("id_media").getInputStream(), "UTF-8"));
			String chemin = IOUtils.toString(request.getPart("chemin").getInputStream(), "UTF-8");
			modele.deleteMediaClown(getServletContext().getRealPath("/"), chemin, id_media);
			break;
		case "rename_media" :
			new_name = IOUtils.toString(request.getPart("new_name").getInputStream(), "UTF-8");
			id_media = Integer.valueOf(IOUtils.toString(request.getPart("id_media").getInputStream(), "UTF-8"));
			modele.renameMediaClown(id_media, new_name);
			break;
		case "delete_clown" :
			modele.deleteClown(getServletContext().getRealPath("/"), id_clown);
			break;
		case "add_clown" :
			String name_clown = IOUtils.toString(request.getPart("name_clown").getInputStream(), "UTF-8");
			modele.addClown(getServletContext().getRealPath("/"), name_clown, request.getPart("media"));
			break;
		}
	}
}
