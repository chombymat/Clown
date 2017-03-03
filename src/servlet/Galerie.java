package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Modele;
import tools.Media;

@SuppressWarnings("serial")
@WebServlet("/Galerie")
public class Galerie extends HttpServlet {
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Modele modele = new Modele();
		try {
			ArrayList<Media> galerie = modele.getGalerie();
			request.setAttribute("galerie", galerie);
			request.getRequestDispatcher("/WEB-INF/galerie.jsp").forward(request, response);
		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
