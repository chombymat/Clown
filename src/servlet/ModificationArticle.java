package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringEscapeUtils;

import model.*;

@WebServlet("/ModificationArticle")
public class ModificationArticle extends HttpServlet 
{
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		tools.Article article = new Modele().getArticle(request.getParameter("onglet").toString());
		response.setCharacterEncoding("UTF8");
		response.getWriter().println(new StringEscapeUtils().unescapeHtml4(article.getContenu()));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		doGet(request, response);
	}
}
