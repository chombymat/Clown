package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Model;

@WebServlet("/ModifPassword")
public class ModifPassword extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		if(request.getParameter("type") != null)
		{
			doPost(request, response);
			return;
		}
		request.getRequestDispatcher("modifPassword.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		Model model = new Model();
		String type = request.getParameter("type");
		String token = null;
		
		switch(type)
		{
		case "request" :
			String login = request.getParameter("login");
			String mail = request.getParameter("mail");
			String pass = request.getParameter("passwordModified");
			token = model.generateToken();
			
			if("".equalsIgnoreCase(login.trim()) || "".equalsIgnoreCase(mail.trim()) || "".equalsIgnoreCase(pass.trim()))
			{
				response.getWriter().print("fail");
				return;
			}
			
			String mailBDD = model.getMailUtilisateurWithLogin(login);
			
			if(mailBDD == null || !mail.equals(mailBDD))
			{
				response.getWriter().print("fail");
				return;
			}
			
			int idUser = model.getIdUserWithLogin(login);
			
			if(idUser == -1 )
			{
				response.getWriter().print("fail");
				return;
			}
			
			model.addValidation(idUser, token, pass);
			
			model.envoyerMailModifPassword(login,mail, request.getRequestURL() + "?type=confirm&token=" + token);
			response.getWriter().print("ok");
			break;
		case "confirm" :
			token = request.getParameter("token");
			
			if(token == null || "".equalsIgnoreCase(token))
			{
				request.setAttribute("erreur", "Erreur, information manquante");
				request.getRequestDispatcher("/WEB-INF/erreur.jsp").forward(request, response);
				return;
			}
			
			model.confirmModificationPassword(token);
			model.deleteValidation(token);
			response.sendRedirect("./connexion.jsp");
			break;
		default :
			request.setAttribute("erreur", "Erreur, informations incorrectes.");
			request.getRequestDispatcher("/WEB-INF/erreur.jsp").forward(request, response);
			break;
		}
	}

}
