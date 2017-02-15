package servlet;

import model.Modele;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/ManipulationArticle")
public class ManipulationArticle extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("ajouterArticle") != null){
			new Modele().ajouterArticle(
					(String)request.getParameter("ajouterArticleTitre"),
					(String)request.getParameter("ajouterArticleDescription"),
					Integer.valueOf(request.getParameter("ajouterArticleIdProjetPere")));
		}
		else if(request.getParameter("modifierArticle") != null){
			new Modele().modifierArticle(
					Integer.valueOf(request.getParameter("modifierArticleId")),
					(String)request.getParameter("modifierArticleTitre"),
					(String)request.getParameter("modifierArticleDescription"));
		}

	}

}
