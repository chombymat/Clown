package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.Modele;
import tools.Clown;
import tools.Media;

@WebServlet("/ModificationClowns")
public class ModificationClowns extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		ArrayList<Clown> clowns = new ArrayList<Clown>(new Modele().getClowns().values());
		
		JSONArray j_array = new JSONArray();
		
		for(Clown clown : clowns)
		{
			JSONObject json = new JSONObject();
			JSONArray medias = new JSONArray();
			
			json.put("nom", clown.getName());
			json.put("id", clown.getId_clown());
			
			for(Media media : clown.getList_media())
			{
				
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// doGet(request, response);
	}

}
