package servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Model;


@WebServlet("/Inscription")
public class Inscription extends HttpServlet {
	
	private static final long serialVersionUID = 1L;



	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Model modele = new Model();
		
		try {
			
			String tokenConfirmation = (String)request.getParameter("confirmation");
			String mail = modele.getMailUtilisateurWithToken(tokenConfirmation);
			if(tokenConfirmation != null){
				
				modele.ajoutRoleUtilisateur(tokenConfirmation);
				modele.envoyerMailInscriptionRetourUtilisateur(mail);
				response.sendRedirect("./confirmationInscription.jsp");
			}
			else if((String)request.getParameter("refus") != null){
				tokenConfirmation = (String)request.getParameter("refus");
				if(tokenConfirmation != null){
					modele.suprimerValidationAndUser(tokenConfirmation);
					modele.envoyerMailInscriptionRefusUtilisateur(tokenConfirmation, mail);
					response.sendRedirect("./refusInscription.jsp");
				}
			}
		} catch (Exception e) {
			response.getWriter().print(e.getMessage());
		}
	}
	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Model modele = new Model();
		try {
			if((String)request.getParameter("initialisation") != null)
			{
				String nom = (String)request.getParameter("inscriptionNom");
				String prenom = (String)request.getParameter("inscriptionPrenom");
				String mail = (String)request.getParameter("inscriptionMail");
				String login = (String)request.getParameter("inscriptionLogin");
				String pass = (String)request.getParameter("inscriptionPass");
				
				String token = modele.ajoutUtilisateur(nom, prenom, login, mail, pass);
				if(token.length() == 10){
					modele = new Model();
					modele.envoyerMailInscription(	
							nom, prenom , mail, login,
							request.getRequestURL() + "?confirmation=" + token,
							request.getRequestURL() + "?refus=" + token);
				}
				response.getWriter().print(token);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}