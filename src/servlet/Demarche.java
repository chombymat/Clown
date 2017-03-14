package servlet;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Modele;

@SuppressWarnings("serial")
@WebServlet("/Demarche")
public class Demarche extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HashMap<String, tools.Article> articles = new Modele().getDemarche();
		request.setAttribute("clown", articles.get("clown").getContenu());
		request.setAttribute("pratique", articles.get("pratique_sensoriel").getContenu());
		request.setAttribute("expression", articles.get("expression_corporelle").getContenu());
		request.setAttribute("accueil_demarche", articles.get("accueil_demarche").getContenu());
		request.getRequestDispatcher("/WEB-INF/demarche.jsp").forward(request, response);
	}
}
