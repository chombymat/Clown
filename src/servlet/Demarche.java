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
		request.setAttribute("articles", articles);
		request.getRequestDispatcher("/WEB-INF/demarche.jsp").forward(request, response);
	}
}
