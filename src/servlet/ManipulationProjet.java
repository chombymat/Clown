package servlet;

import model.Modele;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ManipulationProjet")
public class ManipulationProjet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(request.getParameter("ajouterMedia") != null){
			String type = "pdf";
			if(request.getParameter("ajouterMediaTypePhoto") != null)
				type = "img";
			else if(request.getParameter("ajouterMediaTypeVideo") != null)
				type = "vid";
			new Modele().ajouterMedia(
					(String)request.getParameter("ajouterMediaChemin"),type, 
					Integer.valueOf(request.getParameter("ajouterIdArticlePere")));
		}
		
		
		else if(request.getParameter("supprimerMedia") != null){
			new Modele().supprimerMedia(
					Integer.valueOf(request.getParameter("supprimerMediaId")));
		}
		
		
		else if(request.getParameter("mediasArticle") != null){
			new Modele().getMedias(
					Integer.valueOf(request.getParameter("idArticlePere")));
		}

	}

}
