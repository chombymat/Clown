package servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Modele;


@WebServlet("/Inscription")
public class Inscription extends HttpServlet {


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Modele modele = new Modele();
		try {
			modele.ajoutUtilisateur(
					(String)request.getParameter("inscriptionNom"),
					(String)request.getParameter("inscriptionPrenom"),
					(String)request.getParameter("inscriptionLogin"),
					(String)request.getParameter("inscriptionMail"),
					(String)request.getParameter("inscriptionPass"));
			modele.envoyerMailInscription(	
					(String)request.getParameter("inscriptionNom"),
					(String)request.getParameter("inscriptionPrenom"),
					(String)request.getParameter("inscriptionMail"),
					(String)request.getParameter("inscriptionLogin"));
			response.getWriter().print("ok");
		} catch (Exception e) 
		{
			response.getWriter().print(e.getMessage());
		}
	}

}