package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Modele;
import tools.Article;
import tools.Clown;

@SuppressWarnings("serial")
@WebServlet("/Demarche")
public class Demarche extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HashMap<Integer, Article> articles = new Modele().getDemarche();
		HashMap<String, Clown> clowns = new Modele().getClowns();
		ArrayList<Clown> list_clowns = new ArrayList<Clown>(clowns.values());
		
		request.setAttribute("articles", articles);
		request.setAttribute("list_clowns", list_clowns);
		request.getRequestDispatcher("/WEB-INF/demarche.jsp").forward(request, response);
	}
}
