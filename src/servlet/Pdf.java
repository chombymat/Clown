package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Pdf")
public class Pdf extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		if(request.getSession().getAttribute("user") != null)
		{
			int id_article = Integer.valueOf(request.getParameter("id_a"));
			int id_media = Integer.valueOf(request.getParameter("id"));
			request.getRequestDispatcher("/WEB-INF/pdf/" + id_article + "/" + id_media + ".pdf").forward(request, response);
		}
		else
			response.sendRedirect("connexion.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

}
