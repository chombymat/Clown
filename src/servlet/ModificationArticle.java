package servlet;

import java.io.IOException;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.apache.commons.text.StringEscapeUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import model.Model;
import tools.Media;

@WebServlet("/ModificationArticle")
@MultipartConfig()
public class ModificationArticle extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setCharacterEncoding("UTF-8");
		JSONObject json = new JSONObject();

		tools.Article article = new Model().getArticle(Integer.valueOf(request.getParameter("id_article").toString()));
		json.put("id", article.getId());
		json.put("titre", article.getTitre());
		json.put("contenu", article.getContenu().replaceAll("<br/>", "\r\n").replaceAll("&nbsp;", " "));
		
		JSONArray json_medias = new JSONArray();
		for(Media media : article.getMedias())
		{
			JSONObject json_media = new JSONObject();
			json_media.put("chemin", media.getChemin());
			json_media.put("nom", media.getNom());
			json_media.put("type", media.getType());
			json_media.put("id", media.getId());
			json_media.put("doit_inscrit", media.isDoitInscrit());
			json_medias.add(json_media);
		}
		
		json.put("medias", json_medias);
		response.getWriter().println(json);
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String type = IOUtils.toString(request.getPart("type").getInputStream(), "UTF-8"); 
		Model modele = new Model();
		String id_article = "";
		boolean doit_inscrit;
		int id_media = -1;
		
		if(request.getPart("id_article") != null)
			id_article = IOUtils.toString(request.getPart("id_article").getInputStream(), "UTF-8");
		
		if(request.getPart("id_media") != null)
			id_media = Integer.valueOf(IOUtils.toString(request.getPart("id_media").getInputStream(), "UTF-8"));
		
		switch(type)
		{
		case "add_photo" :
			String nom = IOUtils.toString(request.getPart("nom").getInputStream(), "UTF-8");
			String extension = request.getPart("media").getSubmittedFileName().substring(request.getPart("media").getSubmittedFileName().lastIndexOf("."));
			doit_inscrit = Boolean.valueOf(IOUtils.toString(request.getPart("doit_inscrit").getInputStream(), "UTF-8"));
			id_media = modele.ajouterMedia(Integer.valueOf(id_article), "images/article/" + id_article + "/PHOTOS_ENFANTS/", nom, "photo", extension, doit_inscrit);
			modele.saveMediaOnDisk(getServletContext().getRealPath("/") + "/WEB-INF/images/article/" + id_article + "/PHOTOS_ENFANTS/", request.getPart("media"), id_media);
			JSONObject json_photo = new JSONObject();
			json_photo.put("id_media", id_media);
			json_photo.put("nom", "./Media?id=" + id_media);
			json_photo.put("doit_inscrit", doit_inscrit);
			response.getWriter().println(json_photo);
			break;
		case "texte" :
			try {
				JSONObject listURL = (JSONObject) new JSONParser().parse(request.getParameter("listURL"));
				String texte = IOUtils.toString(request.getPart("texte").getInputStream(), "UTF-8");
				
				Set<String> key = listURL.keySet();
				
				for(String k : key)
				{
					JSONObject o = (JSONObject) listURL.get(k);
					Set<String> keyLabel = o.keySet() ;
					String label = keyLabel.iterator().next();
					texte = texte.replace(k, "<a href=\"" + o.get(label) + "\">" + label + "</a>");
				}
				
				
				modele.updateArticle(id_article, texte);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
			break;
		case "delete_photo" :
			String chemin = IOUtils.toString(request.getPart("chemin").getInputStream(), "UTF-8");
			modele.supprimerMedia(getServletContext().getRealPath("/") + chemin, id_media);
			break;
		case "rename" :
			String new_name = IOUtils.toString(request.getPart("new_name").getInputStream(), "UTF-8");
			modele.renameMedia(id_media, new_name);
			break;
		case "add_pdf" :
			String nom_pdf = IOUtils.toString(request.getPart("nom").getInputStream(), "UTF-8");
			doit_inscrit = Boolean.valueOf(IOUtils.toString(request.getPart("doit_inscrit").getInputStream(), "UTF-8"));
			id_media = modele.addPdf(Integer.valueOf(id_article), nom_pdf, doit_inscrit);
			modele.savePdfOnDisk(getServletContext().getRealPath("/"), Integer.valueOf(id_article), id_media, request.getPart("media"));
			JSONObject json_pdf = new JSONObject();
			json_pdf.put("id_media", id_media);
			json_pdf.put("nom", "Pdf?id=" + id_media + "&id_a=" + id_article);
			response.getWriter().println(json_pdf);
			break;
		case "delete_pdf" :
			modele.deletePdf(getServletContext().getRealPath("/"), id_media, Integer.valueOf(id_article));
			break;
		case "add_video" :
			String url_video = IOUtils.toString(request.getPart("media").getInputStream(), "UTF-8");
			doit_inscrit = Boolean.valueOf(IOUtils.toString(request.getPart("doit_inscrit").getInputStream(), "UTF-8"));
			id_media = modele.addVideo(url_video, Integer.valueOf(id_article), doit_inscrit);
			JSONObject json_video = new JSONObject();
			json_video.put("id_media", id_media);
			response.getWriter().println(json_video);
			break;
		case "delete_video" :
			modele.deleteVideo(id_media);
			break;
		case "access_media" :
			doit_inscrit = Boolean.valueOf(IOUtils.toString(request.getPart("doit_inscrit").getInputStream(), "UTF-8"));
			modele.updateDroitMedia(id_media, doit_inscrit);
			break;
		}
	}
}
