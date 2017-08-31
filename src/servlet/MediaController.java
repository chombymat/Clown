package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Model;
import sun.net.www.protocol.http.HttpURLConnection;
import tools.Media;

@WebServlet("/Media")
public class MediaController extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			if(request.getParameter("id") != null)
			{
				int id = Integer.valueOf(request.getParameter("id"));
				Media media = new Model().getMedia(id);
				
				if(media.isDoitInscrit() && request.getSession().getAttribute("user") == null)
					response.sendRedirect("connexion.jsp");
				else
				{
					request.getRequestDispatcher("/WEB-INF/" + media.getCheminPhysique()).forward(request, response);
				}
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.sendError(HttpURLConnection.HTTP_BAD_METHOD);
	}

}
