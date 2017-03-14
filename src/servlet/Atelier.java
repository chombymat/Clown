package servlet;

import java.io.IOException;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Modele;

@WebServlet("/Atelier")
public class Atelier extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HashMap<String, tools.Article> articles = new Modele().getAteliers();
		request.setAttribute("pain", articles.get("pain").getContenu());
		request.setAttribute("menu", articles.get("menu").getContenu());
		request.setAttribute("famille", articles.get("famille").getContenu());
		request.setAttribute("lait", articles.get("lait").getContenu());
		request.setAttribute("alimentation", articles.get("alimentation").getContenu());
		request.setAttribute("spectacle", articles.get("spectacle").getContenu());
		request.setAttribute("accueil_atelier", articles.get("accueil_atelier").getContenu());
		request.getRequestDispatcher("/WEB-INF/atelier.jsp").forward(request, response);
	}
}
