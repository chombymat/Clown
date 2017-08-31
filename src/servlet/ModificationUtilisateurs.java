package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.ObjectUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import model.Model;
import tools.Utilisateur;

@WebServlet("/ModificationUtilisateurs")
public class ModificationUtilisateurs extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		JSONObject jFinal = new JSONObject();
		JSONArray jArray = new JSONArray();
		response.setCharacterEncoding("UTF-8");
		ArrayList<Utilisateur> listUser = new Model().getUsers();
		
		for(Utilisateur user : listUser)
		{
			JSONObject jUser = new JSONObject();
			
			jUser.put("id", user.getId());
			jUser.put("nom", user.getNom());
			jUser.put("prenom", user.getPrenom());
			jUser.put("mail", user.getMail());
			jUser.put("role", user.getRole());
			
			jArray.add(jUser);
		}
		jFinal.put("users", jArray);
		
		response.getWriter().print(jFinal.toJSONString());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		Model model = new Model();
		String type = request.getParameter("type");
		int id = -1;
		
		if(request.getParameter("id") != null)
			id = Integer.valueOf(request.getParameter("id"));
		
		if(id == -1)
		{
			response.getWriter().print("fail");
			return;
		}
		
		switch(type)
		{
		case "update" :
			String nom = ObjectUtils.defaultIfNull(request.getParameter("nom"), "");
			String prenom = ObjectUtils.defaultIfNull(request.getParameter("prenom"), "");
			String mail = ObjectUtils.defaultIfNull(request.getParameter("mail"), "");
			String privilege = request.getParameter("privilege");
			
			if("".equalsIgnoreCase(nom) || "".equalsIgnoreCase(prenom) || "".equalsIgnoreCase(mail))
			{
				response.getWriter().print("fail");
				return;
			}
			
			if(model.updateUtilisateur(id, nom, prenom, mail, privilege))
				response.getWriter().print("ok");
			else
				response.getWriter().print("fail");
			break;
		case "delete" :
			if(model.deleteUtilisateur(id))
				response.getWriter().print("ok");
			else
				response.getWriter().print("fail");
			break;
		default :
			response.getWriter().print("fail");
			break;
		}
	}

}
