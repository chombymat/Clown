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
		Modele modele = new Modele();
		
		try {
			
			String tokenConfirmation = (String)request.getParameter("confirmation");
			String mail = modele.getMailUtilisateur(tokenConfirmation);
			if(tokenConfirmation != null){
				
				System.out.println("inscription confirmée");
				modele = new Modele();
				modele.ajoutRoleUtilisateur(tokenConfirmation);
				modele = new Modele();
				modele.envoyerMailInscriptionRetourUtilisateur(mail);
				response.sendRedirect("./confirmationInscription.jsp");
			}
			
			else if((String)request.getParameter("refus") != null){
				tokenConfirmation = (String)request.getParameter("refus");
				if(tokenConfirmation != null){
					System.out.println("inscription refusée");
					modele.suprimerUtilisateur(tokenConfirmation);
					modele.envoyerMailInscriptionRefusUtilisateur(tokenConfirmation, mail);
					response.sendRedirect("./refusInscription.jsp");
				}
			}
			
		} catch (Exception e) {
			response.getWriter().print(e.getMessage());
		}
	}
	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Modele modele = new Modele();
		try {
			if((String)request.getParameter("initialisation") != null)
			{
				System.out.println("inscription demandée");
				String nom = (String)request.getParameter("inscriptionNom");
				String prenom = (String)request.getParameter("inscriptionPrenom");
				String mail = (String)request.getParameter("inscriptionMail");
				String login = (String)request.getParameter("inscriptionLogin");
				String pass = (String)request.getParameter("inscriptionPass");
				
				String token = modele.ajoutUtilisateur(nom, prenom, login, mail, pass);
				if(token.length() == 10){
					modele = new Modele();
					modele.envoyerMailInscription(	
							nom, prenom , mail, login,
							"https://localhost:8443/Clown/Inscription?confirmation=" + token,
							"https://localhost:8443/Clown/Inscription?refus=" + token);
				}
				response.getWriter().print(token);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}