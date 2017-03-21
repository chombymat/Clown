package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Modele;


@WebServlet("/ForgotPassword")
public class ForgotPassword extends HttpServlet {
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Modele model = null;
		try {
			if((String)request.getParameter("demandeModifPassword") != null){
				
				String login = (String)request.getParameter("login");
				String mail = (String)request.getParameter("mail");
				model = new Modele();
				String mail2 = model.getMailUtilisateur(login);

				if(mail.equals(mail2)){
					model = new Modele();
					model.envoyerMailModifPassword(login, mail,
											"https://localhost:8443/Clown/ForgotPassword?primaUpdate=" + login);
					response.sendRedirect("./connexion.jsp");
				}
				
				
			} else if((String)request.getParameter("confirmationModifPassword") != null){
				System.out.println((String)request.getParameter("login"));
				System.out.println("!!! password modifié in DB");
				model = new Modele();
				
				System.out.println("log :" + (String)request.getParameter("login"));
				System.out.println("mail :" + (String)request.getParameter("mail"));
				System.out.println("pass :" + (String)request.getParameter("passwordModified"));
				
				model.modifierPasswordUtilisateur((String)request.getParameter("login"),
												  (String)request.getParameter("mail"),
												  (String)request.getParameter("passwordModified"));
				response.sendRedirect("./connexion.jsp");
				
			}
		} catch (Exception e) {
			response.getWriter().print(e.getMessage());
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			Modele model = new Modele();
			if((String)request.getParameter("primaUpdate") != null){
				
				String logConfirmation = (String)request.getParameter("primaUpdate");
				String mailConfirmation =  model.getMailUtilisateur(logConfirmation);
				
				if(logConfirmation != null && mailConfirmation != null){

					response.sendRedirect("./modifPassword.jsp");
				}
			}
				
		} catch (Exception e) {
			response.getWriter().print(e.getMessage());
		}
	}

}
