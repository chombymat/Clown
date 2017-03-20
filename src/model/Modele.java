package model;

import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.Part;
import javax.sql.DataSource;


import tools.Article;
import tools.Media;
import tools.Utilisateur;

public class Modele 
{
	protected ResultSet result;
	protected DataSource ds = null;
	protected PreparedStatement statement = null;
	private String mailEntreprise = "aurelia.catrice@etudiant.univ-lille1.fr";

	public Modele(){
		try 
		{
			ds = (DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase");

		} catch(Exception e){
			e.printStackTrace();
		}
	}


	public Utilisateur connexion(String login, String pass) throws Exception {

		Utilisateur user = null;
		Connection con = null;

		try 
		{
			con = ds.getConnection();
			PreparedStatement ps_connection = con.prepareStatement(
					"select role, utilisateur.id_utilisateur, nom, prenom, adresse_mail from utilisateur, role where role.id_utilisateur = utilisateur.id_utilisateur and login = ? and prima_pass = ?");
			ps_connection.setString(1, login);
			ps_connection.setString(2, cryptPass(pass));
			ResultSet result = ps_connection.executeQuery();

			if(result.next())
			{
				user = new Utilisateur(result.getInt("id_utilisateur"), result.getString("nom"), result.getString("prenom"), result.getString("adresse_mail"), login, result.getString("role"));
			}
			else
				throw new Exception();
		} catch (SQLException | NamingException e) 
		{
			e.printStackTrace();
		}
		catch(Exception e)
		{
			throw e;
		}
		finally{try{con.close();}catch(Exception e){}}

		return user;
	}

	private String cryptPass(String pass){
		byte[] salt = new String("Clown").getBytes();

		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			digest.reset();
			digest.update(salt);
			byte[] bDigest = digest.digest(pass.getBytes("UTF-8"));

			for (int i = 0; i < 10; i++) 
			{
				digest.reset();
				bDigest = digest.digest(bDigest);
			}

			return new String(Base64.getEncoder().encode(bDigest));
		} catch (java.security.NoSuchAlgorithmException | java.io.UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return null;
	}

	//------------------------------------------------------CONTACT------------------------------------------------------------

	public void envoyerMailContact(String nom, String prenom, String mail, String  numero_telephone, String adresse, String ville, String departement, String sexe, String message){
		try{

			if(sexe != null){
				if(sexe.equals("F"))
					message += "\n- - - -\nDe Madame " + prenom + " " + nom;
				else if(sexe.equals("H"))
					message += "\n- - - -\nDe Monsieur " + prenom + " " + nom;
			} else if(sexe == null)
				message += "\n- - - -\nDe " + prenom + " " + nom;

			message += "\n- - - -\nPossibilité de contacter ultérieurement via:\n";
			if(numero_telephone.length() >0)
				message += "numero de telephone : " + numero_telephone + "\n";
			if(mail.length() >0)
				message += "adresse mail : " + mail + "\n";
			if(adresse.length() >0 && departement.length() >0)
				message += "adresse physique : " + adresse + "\n" + ville + "\n" + departement;

			Session session_mail = (Session)((Context)new InitialContext().lookup("java:comp/env")).lookup("mail/Session");
			Message msg = new MimeMessage(session_mail);
			msg.setFrom(new InternetAddress("tweetbookda2i@gmail.com"));
			msg.setRecipients(RecipientType.TO, InternetAddress.parse(mailEntreprise));
			msg.setSubject("prise de contact " + nom + " " + prenom);
			msg.setText(message);
			Transport.send(msg);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	//-------------------------------------------------------------INFORMATIONS PAR MAIL---------------------------------------------------------------------------

	public void envoyerMailInscription(String nom, String prenom, String mail, String  pseudo, String lienConfirmation, String lienRefus){
		try{

			String message = "Nouvelle demande d'inscription de " + nom + " " + prenom + "\nmail : " + mail + "\nidentifiant : " + pseudo;
			message += "\nVeuillez cliquer sur ce lien pour confirmer l'inscription : " + lienConfirmation;
			message += "\nVeuillez cliquez sur celui-ci si vous refusez l'inscription de cet individu : " + lienRefus;
			Session session_mail = (Session)((Context)new InitialContext().lookup("java:comp/env")).lookup("mail/Session");
			Message msg = new MimeMessage(session_mail);
			msg.setFrom(new InternetAddress("tweetbookda2i@gmail.com"));
			msg.setRecipients(RecipientType.TO, InternetAddress.parse(mailEntreprise));
			msg.setSubject("demande d'inscription " + nom + " " + prenom);
			msg.setText(message);
			Transport.send(msg);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	public void envoyerMailInscriptionRetourUtilisateur(String pseudo, String mail){
		try{

			String message = "Votre demande d'inscription sous le login " + pseudo + " a bien été validée par l'administrateur.";
			Session session_mail = (Session)((Context)new InitialContext().lookup("java:comp/env")).lookup("mail/Session");
			Message msg = new MimeMessage(session_mail);
			msg.setFrom(new InternetAddress(mailEntreprise));
			msg.setRecipients(RecipientType.TO, InternetAddress.parse(mail));
			msg.setSubject("comfirmation d'inscription La Prima Porta");
			msg.setText(message);
			Transport.send(msg);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	public void envoyerMailModifPassword(String pseudo, String mail, String lienModifPassword){
		try{

			String message = "Votre demande de modification de mot de passe sous le login " + pseudo +
							 " a bien été prise en compte. Veuillez cliquez sur le lien ci-dessous pour modifier ce champ :\n" +
							 lienModifPassword;
			Session session_mail = (Session)((Context)new InitialContext().lookup("java:comp/env")).lookup("mail/Session");
			Message msg = new MimeMessage(session_mail);
			msg.setFrom(new InternetAddress(mailEntreprise));
			msg.setRecipients(RecipientType.TO, InternetAddress.parse(mail));
			msg.setSubject("modification de mot de passe La Prima Porta");
			msg.setText(message);
			Transport.send(msg);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	public void envoyerMailInscriptionRefusUtilisateur(String pseudo, String mail){
		try{

			String message = "Votre demande d'inscription sous le login " + pseudo + " a été refusée par l'administrateur.";
			Session session_mail = (Session)((Context)new InitialContext().lookup("java:comp/env")).lookup("mail/Session");
			Message msg = new MimeMessage(session_mail);
			msg.setFrom(new InternetAddress(mailEntreprise));
			msg.setRecipients(RecipientType.TO, InternetAddress.parse(mail));
			msg.setSubject("refus d'inscription La Prima Porta");
			msg.setText(message);
			Transport.send(msg);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}



	//------------------------------------------------------UTILISATEUR------------------------------------------------------------	

	public String ajoutUtilisateur(String nom, String prenom, String login, String mail, String pass) throws Exception {
		try{
			statement = ds.getConnection().prepareStatement("select from utilisateur where adresse_mail = ?");
			statement.setString(1, mail);
			result = statement.executeQuery();

			if(result.next())
				return "mail existant";

			statement = ds.getConnection().prepareStatement("select from utilisateur where login = ?");
			statement.setString(1, login);
			result = statement.executeQuery();

			if(result.next())
				return "login existant";

			statement = ds.getConnection().prepareStatement("insert into utilisateur (nom, prenom, adresse_mail, login, prima_pass) values(?, ?, ?, ?, ?)");
			statement.setString(1, nom);
			statement.setString(2, prenom);
			statement.setString(3, mail);
			statement.setString(4, login);
			statement.setString(5, cryptPass(pass));

			statement.executeUpdate();
			return "inscription ok";
		} catch (Exception e) {
			e.printStackTrace();
			return "exception";
		} finally{
			try{
				statement.getConnection().close();
			} catch(SQLException e){
				e.printStackTrace();
			}
		}
	}

	public void ajoutRoleUtilisateur(String login) throws Exception {
		try {	

			statement = ds.getConnection().prepareStatement("select id_utilisateur from utilisateur where login = ?");
			statement.setString(1,login);
			result = statement.executeQuery();

			if(result.next()){
				int id = result.getInt(1);

				statement = ds.getConnection().prepareStatement("insert into role (id_utilisateur, role) values(?, ?)");
				statement.setInt(1, id);
				statement.setString(2, "role2");

				statement.executeUpdate();
				System.out.println("ajout confirmé de l'utiliateur : " + login);
			}

		}catch (SQLException e) {
			e.printStackTrace();

		} catch (Exception e){
			throw e;

		} finally{
			try{
				statement.getConnection().close();

			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}


	public void suprimerUtilisateur(String login) throws Exception {
		try {	

			statement = ds.getConnection().prepareStatement("delete from utilisateur where login = ?");
			statement.setString(1,login);

			statement.executeUpdate();
			System.out.println("suppression confirmée de l'utiliateur : " + login);

		}catch (SQLException e) {
			e.printStackTrace();

		} catch (Exception e){
			throw e;

		} finally{
			try{
				statement.getConnection().close();

			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}


	public String getMailUtilisateur(String login) throws Exception {
		String mail = null;
		try {	
			statement = ds.getConnection().prepareStatement("select adresse_mail from utilisateur where login = ?");
			statement.setString(1,login);

			result = statement.executeQuery();
			if(result.next())
				mail = result.getString(1);
			return mail;
		} catch (SQLException e) {
			e.printStackTrace();
			return mail;

		} catch (Exception e){
			throw e;

		} finally{
			try{
				statement.getConnection().close();
			} catch(SQLException e) {
				e.printStackTrace();
				return mail;
			}
		}
	}
	
	public void modifierPasswordUtilisateur(String login, String mail, String pass) throws Exception {
		try {	
			statement = ds.getConnection().prepareStatement("udpate utilisateur set prima_pass = ? where login = ? and adresse_mail = ?");
			statement.setString(1, cryptPass(pass));
			statement.setString(2, login);
			statement.setString(3, mail);
			
			statement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();

		} catch (Exception e){
			throw e;

		} finally{
			try{
				statement.getConnection().close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	//------------------------------------------------------ARTICLE------------------------------------------------------------



	public int ajouterArticle(String titre, String description, String contenu)
	{
		int id_article = -1;

		try
		{
			statement = ds.getConnection().prepareStatement("insert into Article (titre, description, contenu) values(?, ?, ?) returning id_article");
			statement.setString(1, titre);
			statement.setString(2, description);
			statement.setString(3, contenu);
			ResultSet result = statement.executeQuery();
			result.next();
			id_article = result.getInt("id_article");
			System.out.println("ajout de l'article " + id_article + " : " + titre);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}

		return id_article;
	}



	public void modifierArticle(int id, String titre, String description){
		try{
			statement = ds.getConnection().prepareStatement("update from Article set titre = ?, description= ? where id_article = ?");
			statement.setString(1, titre);
			statement.setString(2, description);
			statement.setInt(3, id);
			statement.executeUpdate();
			System.out.println("modif de l'article : " + titre);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}



	public void supprimerArticle(int id){
		try{
			statement = ds.getConnection().prepareStatement("delete from Article where id_article = ?");
			statement.setInt(1, id);
			statement.executeUpdate();
			System.out.println("suppression de l'article : " + id);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	public Article getArticle(int id){
		Article article = null;
		try{
			statement = ds.getConnection().prepareStatement("select titre, description, contenu from article where id_article = ?");
			statement.setInt(1, id);
			result = statement.executeQuery();
			if(result.next()){
				//article = new Article(id, result.getString("titre"), result.getString("description"), result.getString("contenu"));
			}
			else
				return null;

			String regex = "<\\s(.+)\\s>";
			String regex2 = "\\r";

			String subst = "<a href=\"images/article/" + id + "/$1\"><img src=\"images/article/" + id + "/$1\" width=\"50%\" height=\"auto\"/></a>";

			Pattern pattern = Pattern.compile(regex);
			Matcher matcher = pattern.matcher(article.getContenu());
			article.setContenu(matcher.replaceAll(subst));

			pattern = Pattern.compile(regex2);
			matcher = pattern.matcher(article.getContenu());
			article.setContenu(matcher.replaceAll("<br>"));


			return article;

		} catch (Exception e){
			e.printStackTrace();
			return null;
		} finally{
			try{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	public HashMap<String, tools.Article> getAteliers() 
	{
		HashMap<String, Article> articles = new HashMap<String, Article>();
		try
		{
			statement = ds.getConnection().prepareStatement(
					"select article.id_article, article.titre as article_titre, contenu from projet, article where projet.id_projet = article.id_projet and projet.titre like 'atelier'");
			result = statement.executeQuery();
			while(result.next())
			{
				switch(result.getString("article_titre"))
				{
				case "Le pain" :
					articles.put("Le pain", new Article(result.getInt("id_article"),result.getString("article_titre"), result.getString("contenu")));
					break;
				case "Le lait" :
					articles.put("Le lait", new Article(result.getInt("id_article"),result.getString("article_titre"), result.getString("contenu")));
					break;
				case "Les 7 familles" :
					articles.put("Les 7 familles", new Article(result.getInt("id_article"),result.getString("article_titre"), result.getString("contenu")));
					break;
				case "Le menu équilibré" :
					articles.put("Le menu équilibré", new Article(result.getInt("id_article"),result.getString("article_titre"), result.getString("contenu")));
					break;
				case "Alimentation et environnement" :
					articles.put("Alimentation et environnement", new Article(result.getInt("id_article"),result.getString("article_titre"), result.getString("contenu")));
					break;
				case "Le spectacle" :
					articles.put("Le spectacle", new Article(result.getInt("id_article"),result.getString("article_titre"), result.getString("contenu")));
					break;
				case "accueil" :
					articles.put("accueil", new Article(result.getInt("id_article"),result.getString("article_titre"), result.getString("contenu")));
					break;
				}
			}
			
			statement.close();
			String query = "select chemin, titre, nom from media, article where media.id_article = article.id_article and media.id_article in (";
			
			boolean firstLine = true;					
			for(Map.Entry<String, Article> article : articles.entrySet())
			{
				if(firstLine)
				{
					query += article.getValue().getId();
					firstLine = false;
				}
				else
					query += "," + article.getValue().getId();
			}
			
			query += ")";
			statement = ds.getConnection().prepareStatement(query);
			result = statement.executeQuery();
			
			while(result.next())
			{
				articles.get(result.getString("titre")).getMedias().add(new Media(result.getString("chemin"), result.getString("nom")));
			}
		} catch (Exception e){
			e.printStackTrace();
			return null;
		} finally
		{
			try
			{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		return articles;
	}
	
	public HashMap<String, tools.Article> getDemarche() 
	{
		HashMap<String, Article> articles = new HashMap<String, Article>();
		try
		{
			statement = ds.getConnection().prepareStatement("select onglet, contenu from article where onglet = 'clown' or onglet = 'pratique_sensoriel' or onglet = 'expression_corporelle' or onglet = 'accueil_demarche'");
			result = statement.executeQuery();
			while(result.next())
			{
				switch(result.getString("onglet"))
				{
				case "clown" :
					//articles.put("clown", new Article(-1,"","",result.getString("contenu")));
					break;
				case "pratique_sensoriel" :
					//articles.put("pratique_sensoriel", new Article(-1,"","",result.getString("contenu")));
					break;
				case "expression_corporelle" :
					//articles.put("expression_corporelle", new Article(-1,"","",result.getString("contenu")));
					break;
				case "accueil_demarche" :
					//articles.put("accueil_demarche", new Article(-1,"","",result.getString("contenu")));
					break;
				}
			}

		} catch (Exception e){
			e.printStackTrace();
			return null;
		} finally
		{
			try
			{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e)
			{
				e.printStackTrace();
			}
		}
		
		return articles;
	}
	
	public Article getArticle(String onglet)
	{
		Article article = null;
		
		try
		{
			statement = ds.getConnection().prepareStatement("select contenu from article where onglet = ?");
			statement.setString(1, onglet);
			result = statement.executeQuery();
			
			if(result.next())
			{
				//article = new Article(-1, "", "", result.getString("contenu"));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{ statement.close(); ds.getConnection().close(); }catch(Exception e){}
		}
		
		return article;
	}
	
	public void updateArticle(String onglet, String contenu)
	{
		try
		{
			statement = ds.getConnection().prepareStatement("update article set contenu = ? where onglet = ?");
			statement.setString(1, contenu);
			statement.setString(2, onglet);
			result = statement.executeQuery();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{ statement.close(); ds.getConnection().close(); }catch(Exception e){}
		}
	}

	//------------------------------------------------------MEDIA------------------------------------------------------------


	public void ajouterMedia(String chemin, String type, int idArticle){
		try{
			statement = ds.getConnection().prepareStatement("insert into Media (chemin, type, id_article) values(?, ?, ?)");
			statement.setString(1, chemin);
			statement.setString(2, type);
			statement.setInt(3, idArticle);
			statement.executeUpdate();
			System.out.println("ajout du media : " + chemin);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}


	public void supprimerMedia(int id){
		try{
			statement = ds.getConnection().prepareStatement("delete from Media where id_media = ?");
			statement.setInt(1, id);
			statement.executeUpdate();
			System.out.println("suppression du media : " + id);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}



	public ArrayList<Media> getMedias(int idArticle){
		ArrayList<Media> medias = new ArrayList<Media>();
		try{
			statement = ds.getConnection().prepareStatement("select chemin, type, nom from media where id_article = ?");
			statement.setInt(1, idArticle);
			result = statement.executeQuery();
			while(result.next()){
				medias.add(new Media(result.getString(1), result.getString(2), result.getString(3)));
			}
			return medias;

		} catch (Exception e){
			e.printStackTrace();
			return null;
		} finally{
			try{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	public ArrayList<Media> getGalerie(){
		ArrayList<Media> medias = new ArrayList<Media>();
		try{
			statement = ds.getConnection().prepareStatement("select chemin, nom from media where type = 'galerie'");
			result = statement.executeQuery();
			while(result.next()){
				medias.add(new Media(result.getString("chemin"), result.getString("nom")));
			}
			return medias;

		} catch (Exception e){
			e.printStackTrace();
			return null;
		} finally{
			try{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	public void saveMediaOnDisk(String chemin, Collection<Part> medias, int id)
	{
		File f = new File(chemin);

		if(!f.exists())
			f.mkdirs();


		for(Part media : medias)
		{
			try 
			{
				media.write(chemin + media.getName().substring(media.getName().indexOf("_") + 1));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	//------------------------------------------------------PROJET------------------------------------------------------------


	public void ajouterProjet(String titre, String description){
		try{
			statement = ds.getConnection().prepareStatement("insert into Projet (titre, description) values(?, ?)");
			statement.setString(1, titre);
			statement.setString(2, description);
			statement.executeUpdate();
			System.out.println("ajout du media : " + titre);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}


	public void supprimerProjet(int id){
		try{
			statement = ds.getConnection().prepareStatement("delete from Projet where id_projet = ?");
			statement.setInt(1, id);
			statement.executeUpdate();
			System.out.println("suppression du projet : " + id);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				statement.close();
				ds.getConnection().close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}



}
