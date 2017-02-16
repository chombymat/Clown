package servlet;
import model.Modele;
import java.io.IOException;

import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Inscription")
public class Inscription extends HttpServlet {

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Modele modele = new Modele();
		modele.ajoutUtilisateur(
			(String)request.getParameter("inscriptionNom"),
			(String)request.getParameter("inscriptionPrenom"),
			(String)request.getParameter("inscriptionLogin"),
			(String)request.getParameter("inscriptionMail"),
			(String)request.getParameter("inscriptionPass"));
	}

}