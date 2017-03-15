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
@WebServlet("/Atelier")
public class Atelier extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HashMap<String, tools.Article> articles = new Modele().getAteliers();
		request.setAttribute("articles", articles);
		request.getRequestDispatcher("/WEB-INF/atelier.jsp").forward(request, response);
	}
}
