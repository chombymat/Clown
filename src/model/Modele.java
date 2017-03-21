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
import org.apache.commons.lang3.StringEscapeUtils;
import tools.Article;
import tools.Clown;
import tools.Media;
import tools.Utilisateur;

public class Modele 
{
	private String mailEntreprise = "aurelia.catrice@etudiant.univ-lille1.fr";

	public Utilisateur connexion(String login, String pass) throws Exception {

		Utilisateur user = null;
		Connection con = null;

		try 
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
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

	private String cryptPass(String pass)
	{
		byte[] salt = new String("Clown").getBytes();

		try 
		{
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

	public void envoyerMailContact(String nom, String prenom, String mail, String  numero_telephone, String adresse, String ville, String departement, String profession, String etablissement, String message)
	{
		try{

			message += "\n_________________\n\nDe " + prenom + " " + nom;

			message += "\n\nInformations complémentaires:\n";
			if(numero_telephone.length() >0)
				message += "numéro de téléphone: " + numero_telephone + "\n";
			if(mail.length() >0)
				message += "email: " + mail + "\n";
			if(adresse.length() >0)
				message += "adresse: " + adresse + "\n";
			if(ville.length() >0)
				message += "ville: " + ville + "\n";
			if(departement.length() > 0)
				message += "département: " + departement + "\n";
			if(profession.length() > 0)
				message += "profession: " + profession + "\n";
			if(etablissement.length() > 0)
				message += "établissement: " + etablissement + "\n";

			Session session_mail = (Session)((Context)new InitialContext().lookup("java:comp/env")).lookup("mail/Session");
			Message msg = new MimeMessage(session_mail);
			msg.setFrom(new InternetAddress("tweetbookda2i@gmail.com"));
			msg.setRecipients(RecipientType.TO, InternetAddress.parse(mailEntreprise));
			msg.setSubject("prise de contact [La Prima Porta]");
			msg.setText(message);
			Transport.send(msg);

		} catch (Exception e){
			e.printStackTrace();
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
			msg.setSubject("demande d'inscription [La Prima Porta]");
			msg.setText(message);
			Transport.send(msg);

		} catch (Exception e){
			e.printStackTrace();
		}
	}

	public void envoyerMailInscriptionRetourUtilisateur(String pseudo, String mail){
		try{

			String message = "Votre demande d'inscription sous le login " + pseudo + " a bien été validée par l'administrateur.";
			Session session_mail = (Session)((Context)new InitialContext().lookup("java:comp/env")).lookup("mail/Session");
			Message msg = new MimeMessage(session_mail);
			msg.setFrom(new InternetAddress(mailEntreprise));
			msg.setRecipients(RecipientType.TO, InternetAddress.parse(mail));
			msg.setSubject("comfirmation d'inscription [La Prima Porta]");
			msg.setText(message);
			Transport.send(msg);

		} catch (Exception e){
			e.printStackTrace();
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
			msg.setSubject("modification de mot de passe [La Prima Porta]");
			msg.setText(message);
			Transport.send(msg);

		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public void envoyerMailConfirmPassword(String pseudo, String mail){
		try{

			String message = "Votre mot de passe relatif au login " + pseudo + " a bien été modifié";
			Session session_mail = (Session)((Context)new InitialContext().lookup("java:comp/env")).lookup("mail/Session");
			Message msg = new MimeMessage(session_mail);
			msg.setFrom(new InternetAddress(mailEntreprise));
			msg.setRecipients(RecipientType.TO, InternetAddress.parse(mail));
			msg.setSubject("mot de passe modifié [La Prima Porta]");
			msg.setText(message);
			Transport.send(msg);

		} catch (Exception e){
			e.printStackTrace();
		}
	}

	public void envoyerMailInscriptionRefusUtilisateur(String pseudo, String mail){
		try{

			String message = "Votre demande d'inscription sous le login " + pseudo + " a été refusée par l'administrateur.";
			Session session_mail = (Session)((Context)new InitialContext().lookup("java:comp/env")).lookup("mail/Session");
			Message msg = new MimeMessage(session_mail);
			msg.setFrom(new InternetAddress(mailEntreprise));
			msg.setRecipients(RecipientType.TO, InternetAddress.parse(mail));
			msg.setSubject("refus d'inscription [La Prima Porta]");
			msg.setText(message);
			Transport.send(msg);

		} catch (Exception e){
			e.printStackTrace();
		} 
	}



	//------------------------------------------------------UTILISATEUR------------------------------------------------------------	

	public String ajoutUtilisateur(String nom, String prenom, String login, String mail, String pass) throws Exception 
	{
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select from utilisateur where adresse_mail = ?");
			statement.setString(1, mail);
			ResultSet result = statement.executeQuery();

			if(result.next())
				return "mail existant";

			PreparedStatement statement2 = con.prepareStatement("select from utilisateur where login = ?");
			statement2.setString(1, login);
			result = statement2.executeQuery();

			if(result.next())
				return "login existant";
			PreparedStatement statement3 = con.prepareStatement("insert into utilisateur (nom, prenom, adresse_mail, login, prima_pass) values(?, ?, ?, ?, ?)");
			statement3.setString(1, nom);
			statement3.setString(2, prenom);
			statement3.setString(3, mail);
			statement3.setString(4, login);
			statement3.setString(5, cryptPass(pass));

			statement3.executeUpdate();
			return "inscription ok";
		} catch (Exception e) {
			e.printStackTrace();
			return "exception";
		} finally{
			try{
				con.close();
			} catch(SQLException e){
				e.printStackTrace();
			}
		}
	}

	public void ajoutRoleUtilisateur(String login) throws Exception {
		Connection con = null;
		try {	
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select id_utilisateur from utilisateur where login = ?");
			statement.setString(1,login);
			ResultSet result = statement.executeQuery();

			if(result.next()){
				int id = result.getInt(1);

				PreparedStatement statement2 = con.prepareStatement("insert into role (id_utilisateur, role) values(?, ?)");
				statement2.setInt(1, id);
				statement2.setString(2, "role2");

				statement2.executeUpdate();
				System.out.println("ajout confirmé de l'utiliateur : " + login);
			}

		}catch (SQLException e) {
			e.printStackTrace();

		} catch (Exception e){
			throw e;

		} finally{
			try{
				con.close();

			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void suprimerUtilisateur(String login) throws Exception {
		Connection con = null;
		try {	
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("delete from utilisateur where login = ?");
			statement.setString(1,login);

			statement.executeUpdate();
			System.out.println("suppression confirmée de l'utiliateur : " + login);

		}catch (SQLException e) {
			e.printStackTrace();

		} catch (Exception e){
			throw e;

		} finally{
			try{
				con.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}


	public String getMailUtilisateur(String login) throws Exception {
		String mail = null;
		Connection con = null;
		try {	
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select adresse_mail from utilisateur where login = ?");
			statement.setString(1,login);

			ResultSet result = statement.executeQuery();
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
				con.close();
			} catch(SQLException e) {
				e.printStackTrace();
				return mail;
			}
		}
	}
	
	public String  modifierPasswordUtilisateur(String login, String mail, String pass) throws Exception {
		Connection con = null;
		try {	
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("update utilisateur set prima_pass = ? where login = ? and adresse_mail = ?");
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
				con.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		return "ok";
	}
	//------------------------------------------------------ARTICLE------------------------------------------------------------



	public int ajouterArticle(String titre, String description, String contenu)
	{
		int id_article = -1;
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("insert into Article (titre, description, contenu) values(?, ?, ?) returning id_article");
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
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}

		return id_article;
	}



	public void modifierArticle(int id, String titre, String description){
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("update from Article set titre = ?, description= ? where id_article = ?");
			statement.setString(1, titre);
			statement.setString(2, description);
			statement.setInt(3, id);
			statement.executeUpdate();
			System.out.println("modif de l'article : " + titre);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}



	public void supprimerArticle(int id){
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("delete from Article where id_article = ?");
			statement.setInt(1, id);
			statement.executeUpdate();
			System.out.println("suppression de l'article : " + id);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	public Article getArticle(int id_article)
	{
		Article article = null;
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement =con.prepareStatement("select  contenu, titre from article where id_article = ?");
			statement.setInt(1, id_article);
			ResultSet result = statement.executeQuery();

			if(result.next())
			{
				article = new Article(id_article, result.getString("titre"), result.getString("contenu"));

				PreparedStatement statement2 = con.prepareStatement("select id_media, chemin, nom, type from media where id_article = ?");
				statement2.setInt(1, id_article);
				result = statement2.executeQuery();

				while(result.next())
				{
					article.getMedias().add(new Media(result.getInt("id_media"),result.getString("chemin"), result.getString("nom"), result.getString("type")));
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{ con.close(); }catch(Exception e){}
		}

		return article;
	}
	
	public HashMap<Integer, tools.Article> getAteliers() 
	{
		HashMap<Integer, Article> articles = new HashMap<Integer, Article>();
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement(
					"select article.id_article, article.titre as article_titre, contenu from projet, article where projet.id_projet = article.id_projet and projet.titre like 'atelier'");
			ResultSet result = statement.executeQuery();
			while(result.next())
			{
				String contenu =  StringEscapeUtils.escapeHtml4(result.getString("contenu")).replaceAll("\r", "<br>");
				switch(result.getInt("id_article"))
				{
				case 1 :
					articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("article_titre"), contenu));
					break;
				case 2 :
					articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("article_titre"), contenu));
					break;
				case 3 :
					articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("article_titre"), contenu));
					break;
				case 4 :
					articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("article_titre"), contenu));
					break;
				case 5 :
					articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("article_titre"), contenu));
					break;
				case 6 :
					articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("article_titre"), contenu));
					break;
				case 7 :
					articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("article_titre"), result.getString("contenu")));
					break;
				}
			}

			statement.close();
			String query = "select chemin, id_article, nom, type from media where media.id_article in (";

			boolean firstLine = true;					
			for(Map.Entry<Integer, Article> article : articles.entrySet())
			{
				if(firstLine)
				{
					query += article.getKey();
					firstLine = false;
				}
				else
					query += "," + article.getKey();
			}

			query += ")";
			PreparedStatement statement2 = con.prepareStatement(query);
			result = statement2.executeQuery();

			while(result.next())
			{
				articles.get(result.getInt("id_article")).getMedias().add(new Media(result.getString("chemin"), result.getString("nom"), result.getString("type")));
			}
		} catch (Exception e){
			e.printStackTrace();
			return null;
		} finally
		{
			try
			{
				con.close();
			} catch(Exception e)
			{
				e.printStackTrace();
			}
		}

		return articles;
	}
	
	public HashMap<Integer, tools.Article> getDemarche() 
	{
		HashMap<Integer, Article> articles = new HashMap<Integer, Article>();
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select article.id_article as id_article, article.titre, contenu from projet, article where projet.id_projet = article.id_projet and projet.id_projet = 2");
			ResultSet result = statement.executeQuery();
			
			while(result.next())
			{
				switch(result.getInt("id_article"))
				{
				case 8 :
					articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("titre"), result.getString("contenu")));
					break;
				case 9 :
					articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("titre"), result.getString("contenu")));
					break;
				case 10 :
					articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("titre"), result.getString("contenu")));
					break;
				case 11 :
					articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("titre"), result.getString("contenu")));
					break;
				}
			}

			statement.close();
			String query = "select id_media, chemin, id_article, nom, type from media where id_article in (";

			boolean firstLine = true;					
			for(Map.Entry<Integer, Article> article : articles.entrySet())
			{
				if(firstLine)
				{
					query += article.getKey();
					firstLine = false;
				}
				else
					query += "," + article.getKey();
			}

			query += ")";
			PreparedStatement statement2 = con.prepareStatement(query);
			result = statement2.executeQuery();

			while(result.next())
			{
				articles.get(result.getInt("id_article")).getMedias().add(new Media(result.getInt("id_media"), result.getString("chemin"), result.getString("nom"), result.getString("type")));
			}
		} catch (Exception e){
			e.printStackTrace();
			return null;
		} finally
		{
			try
			{
				con.close();
			} catch(Exception e)
			{
				e.printStackTrace();
			}
		}

		return articles;
	}

	public HashMap<String, Clown> getClowns() 
	{
		HashMap<String, Clown> clowns = new HashMap<>();
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select id_clown, nom from clown");
			ResultSet result = statement.executeQuery();
			String query = "select id_clown, id_media, chemin, nom, type from media_clown where id_clown in (";

			boolean firstLine = true;					
			while(result.next())
			{
				clowns.put(result.getString("id_clown"), new Clown(result.getString("nom"), result.getInt("id_clown")));
				if(firstLine)
				{
					firstLine = false;
					query += result.getString("id_clown");
				}
				else
					query += ", " + result.getString("id_clown");
			}

			statement.close();

			query += ")";
			
			PreparedStatement statement2 = con.prepareStatement(query);
			result = statement2.executeQuery();

			while(result.next())
			{
				clowns.get(result.getString("id_clown")).getList_media().add(new Media(result.getInt("id_media"), result.getString("chemin"), result.getString("nom"), result.getString("type")));
			}

		} catch (Exception e){
			e.printStackTrace();
			return null;
		} finally
		{
			try
			{
				con.close();
			} catch(Exception e)
			{
				e.printStackTrace();
			}
		}

		return clowns;
	}
	
	public Article getArticle(String titre)
	{
		Article article = null;
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement =con.prepareStatement("select id_article, contenu, id_projet from article where titre = ?");
			statement.setString(1, titre);
			ResultSet result = statement.executeQuery();

			if(result.next())
			{
				article = new Article(result.getInt("id_article"), titre, result.getString("contenu"), result.getInt("id_projet"));

				PreparedStatement statement2 = con.prepareStatement("select id_media, chemin, nom, type from media where id_article = ? and type like 'photo'");
				statement2.setInt(1, article.getId());
				result = statement2.executeQuery();

				while(result.next())
				{
					article.getMedias().add(new Media(result.getInt("id_media"),result.getString("chemin"), result.getString("nom"), result.getString("type")));
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{ con.close(); }catch(Exception e){}
		}

		return article;
	}

	public void updateArticle(String id_article, String contenu)
	{
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("update article set contenu = ? where id_article = ?");
			statement.setString(1, contenu);
			statement.setInt(2, Integer.valueOf(id_article));
			statement.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{ con.close(); }catch(Exception e){}
		}
	}

	//------------------------------------------------------MEDIA------------------------------------------------------------


	public int ajouterMedia(int id_article, String chemin, String nom, String type, String extension){
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("insert into media (chemin, type, id_article, nom) values(? || (select last_value from media_id_media_seq) || ?, ?, ?, ?) returning id_media");
			statement.setString(1, chemin);
			statement.setString(2, extension);
			statement.setString(3, type);
			statement.setInt(4, id_article);
			statement.setString(5, nom);
			ResultSet result = statement.executeQuery();
			
			result.next();
			
			int id_media = result.getInt("id_media");
			
			return id_media;
		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return -1;
	}

	public int ajouterMedia(String chemin, String type, String nom, String extension){
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			
			PreparedStatement statement = con.prepareStatement("insert into media (chemin, type, nom) values(? || (select last_value from media_id_media_seq) || ?, ?, ?) returning id_media");
			statement.setString(1, chemin);
			statement.setString(2, extension);
			statement.setString(3, type);
			statement.setString(4, nom);
			ResultSet result = statement.executeQuery();
			
			result.next();

			return result.getInt("id_media");
		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return -1;
	}


	public void supprimerMedia(String chemin, int id_media){
		Connection con = null;
		File img = new File(chemin);
		try{
			img.delete();
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("delete from media where id_media = ?");
			statement.setInt(1, id_media);
			statement.executeUpdate();
			System.out.println("suppression du media : " + chemin);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
	public ArrayList<Media> getMedias(int idArticle)
	{
		ArrayList<Media> medias = new ArrayList<Media>();
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select chemin, type, nom from media where id_article = ?");
			statement.setInt(1, idArticle);
			ResultSet result = statement.executeQuery();
			while(result.next()){
				medias.add(new Media(result.getString(1), result.getString(2), result.getString(3)));
			}
			return medias;

		} catch (Exception e){
			e.printStackTrace();
			return null;
		} finally{
			try{
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	public ArrayList<Media> getGalerie()
	{
		ArrayList<Media> medias = new ArrayList<Media>();
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select chemin, nom, id_media from media where type = 'galerie'");
			ResultSet result = statement.executeQuery();
			while(result.next()){
				medias.add(new Media(result.getString("chemin"), result.getString("nom"), result.getInt("id_media")));
			}
			return medias;

		} catch (Exception e){
			e.printStackTrace();
			return null;
		} finally{
			try{
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	public void saveMediasOnDisk(String chemin, Collection<Part> medias, int id)
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

	public void saveMediaOnDisk(String chemin, Part media, int id_media)
	{
		File file = new File(chemin);
		
		if(!file.exists())
			file.mkdirs();
		
		try 
		{
			media.write(chemin + id_media + media.getSubmittedFileName().substring(media.getSubmittedFileName().lastIndexOf(".")));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void renameMedia(int id_media, String new_name) 
	{
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("update media set nom = ? where id_media = ?");
			statement.setString(1, new_name);
			statement.setInt(2, id_media);
			statement.executeUpdate();
		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	//------------------------------------------------------PROJET------------------------------------------------------------


	public void ajouterProjet(String titre, String description)
	{
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("insert into Projet (titre, description) values(?, ?)");
			statement.setString(1, titre);
			statement.setString(2, description);
			statement.executeUpdate();
			System.out.println("ajout du media : " + titre);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	public void supprimerProjet(int id)
	{
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("delete from Projet where id_projet = ?");
			statement.setInt(1, id);
			statement.executeUpdate();
			System.out.println("suppression du projet : " + id);

		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				con.close();
			} catch(Exception e){
				e.printStackTrace();
			}
		}
	}

	public void savePdfOnDisk(String racine, int id_article, int id_media, Part part) 
	{
		File file = new File(racine + "images/pdf/" + id_article + "/");
		
		if(!file.exists())
			file.mkdirs();
		
		try
		{
			part.write(file.getAbsolutePath() + "/" + id_media + ".pdf");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	public int addPdf(int id_article, String name)
	{
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("insert into media (id_article, type, nom, chemin) values(?, ?, ?, ? || (select last_value from media_id_media_seq) || '.pdf') returning id_media");
			statement.setInt(1, id_article);
			statement.setString(2, "pdf");
			statement.setString(3, name);
			statement.setString(4, "images/pdf/" + id_article + "/");
			ResultSet result = statement.executeQuery();
			result.next();
			return result.getInt("id_media");
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{ con.close(); }catch(Exception e){}
		}
		return 0;
	}

}
