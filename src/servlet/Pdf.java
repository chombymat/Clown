package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Model;

@WebServlet("/Pdf")
public class Pdf extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			int id_article = Integer.valueOf(request.getParameter("id_a"));
			int id_media = Integer.valueOf(request.getParameter("id"));
			boolean doit_inscrit = new Model().getDoitInscrit(id_media, id_article);
			
			if(doit_inscrit)
			{
				if(request.getSession().getAttribute("user") != null)
				{
					request.getRequestDispatcher("/WEB-INF/pdf/" + id_article + "/" + id_media + ".pdf").forward(request, response);
				}
				else
					response.sendRedirect("connexion.jsp");
			}
			else
				request.getRequestDispatcher("/WEB-INF/pdf/" + id_article + "/" + id_media + ".pdf").forward(request, response);
		}
		catch(Exception e)
		{
			request.setAttribute("erreur", e.getMessage());
			request.getRequestDispatcher("/WEB-INF/erreur.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

}
