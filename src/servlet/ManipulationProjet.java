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
		
		
		if(request.getParameter("ajouterProjet") != null){
			new Modele().ajouterProjet(
					(String)request.getParameter("ajouterProjetTitre"), 
					(String)request.getParameter("ajouterProjetDescription"));
		}
		
		
		else if(request.getParameter("supprimerMedia") != null){
			new Modele().supprimerProjet(
					Integer.valueOf(request.getParameter("supprimerProjetId")));
		}

	}

}
