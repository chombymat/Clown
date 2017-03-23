package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Modele;
import tools.Article;

@WebServlet("/Formation")
public class Formation extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		Modele modele = new Modele();
		Article article = modele.getArticle(12);
		request.setAttribute("article", article);
		request.getRequestDispatcher("/WEB-INF/formation.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	}
}
