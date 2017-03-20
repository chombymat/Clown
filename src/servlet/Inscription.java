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
			String logConfirmation = (String)request.getParameter("confirmation");
			String mailConfirmation =  modele.getMailUtilisateur(logConfirmation);
			if(logConfirmation != null && mailConfirmation != null){
				
					
				System.out.println("inscription confirmée");
				modele.ajoutRoleUtilisateur(logConfirmation);
				modele.envoyerMailInscriptionRetourUtilisateur(logConfirmation, mailConfirmation);
				response.sendRedirect("./confirmationInscription.jsp");
			}
			
			else if((String)request.getParameter("refus") != null){
				logConfirmation = (String)request.getParameter("refus");
				mailConfirmation =  modele.getMailUtilisateur(logConfirmation);
				if(mailConfirmation != null){
					System.out.println("inscription refusée");
					modele.suprimerUtilisateur(logConfirmation);
					modele.envoyerMailInscriptionRefusUtilisateur(logConfirmation, mailConfirmation);
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
				
				modele.envoyerMailInscription(	
						nom, prenom , mail, login,
						"https://localhost:8443/Clown/Inscription?confirmation=" + login,
						"https://localhost:8443/Clown/Inscription?refus=" + login);
				modele = new Modele();
				String retourInscription = modele.ajoutUtilisateur(nom, prenom, login, mail, pass);
				
				response.getWriter().print(retourInscription);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}