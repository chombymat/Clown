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
import java.util.concurrent.ThreadLocalRandom;

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
import tools.Clown;
import tools.Media;
import tools.Utilisateur;

public class Model 
{
	private static String mailEntreprise = null;

	public Model()
	{
		if(mailEntreprise == null)
		{
			Session sessionMail;
			try {
				sessionMail = (Session) ((Context)new InitialContext().lookup("java:comp/env")).lookup("mail/Session");
				mailEntreprise = sessionMail.getProperty("mail.smtp.user");
			} catch (NamingException e) {
				e.printStackTrace();
			}
		}
	}

	public Utilisateur connexion(String login, String pass) throws Exception {

		Utilisateur user = null;
		Connection con = null;

		try 
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement ps_connection = con.prepareStatement(
					"select role, utilisateur.id_utilisateur, nom, prenom, adresse_mail from utilisateur, role where role.id_utilisateur = utilisateur.id_utilisateur and login = ? and prima_pass = ?");
			ps_connection.setString(1, cryptPass(login));
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

	public  String generateToken(){
		String lettreMaj[] = new String[]{"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
		String lettreMin[] = new String[]{"a", "b", "c", "d", "e" ,"f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"};

		String code = "";

		for(int i = 0; i < 10; i++)
		{
			int randomNum = ThreadLocalRandom.current().nextInt(1, 4);
			int index = 0;
			switch(randomNum)
			{
			case 1 :
				index = ThreadLocalRandom.current().nextInt(0, 26);
				code += lettreMaj[index];
				break;
			case 2 :
				index = ThreadLocalRandom.current().nextInt(0, 26);
				code += lettreMin[index];
				break;
			case 3 :
				code += ThreadLocalRandom.current().nextInt(0, 10);
				break;
			}
		}
		return code;
	}

	public String cryptPass(String pass)
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

	public void envoyerMailContact(String nom, String prenom, String mail, String  numero_telephone, String adresse, String ville, String departement, String profession, String etablissement, String message) throws Exception
	{
		try{

			message += "\n_________________\n\nDe " + prenom + " " + nom;

			message += "\n\nInformations complémentaires:\n";
			if(numero_telephone.length() >0)
				message += "Numéro de téléphone: " + numero_telephone + "\n";
			if(mail.length() >0)
				message += "Email: " + mail + "\n";
			if(adresse.length() >0)
				message += "Adresse: " + adresse + "\n";
			if(ville.length() >0)
				message += "Ville: " + ville + "\n";
			if(departement.length() > 0)
				message += "Département: " + departement + "\n";
			if(profession.length() > 0)
				message += "Profession: " + profession + "\n";
			if(etablissement.length() > 0)
				message += "Etablissement: " + etablissement + "\n";

			Session session_mail = (Session)((Context)new InitialContext().lookup("java:comp/env")).lookup("mail/Session");
			Message msg = new MimeMessage(session_mail);
			msg.setFrom(new InternetAddress(mailEntreprise));
			msg.setRecipients(RecipientType.TO, InternetAddress.parse(mailEntreprise));
			msg.setSubject("prise de contact [La Prima Porta]");
			msg.setText(message);
			Transport.send(msg);
		} catch (Exception e){
			e.printStackTrace();
			throw e;
		}
	}

	//-------------------------------------------------------------INFORMATIONS PAR MAIL---------------------------------------------------------------------------

	public void envoyerMailInscription(String nom, String prenom, String mail, String  pseudo, String lienConfirmation, String lienRefus){
		try{

			String message = "Nouvelle demande d'inscription de " + nom + " " + prenom + "\nmail : " + mail;
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

	public void envoyerMailInscriptionRetourUtilisateur(String mail){
		try{

			String message = "Votre demande d'inscription a bien été validée par l'administrateur.";
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

			String message = "Votre demande de modification de mot de passe a bien été prise en compte. Veuillez cliquez sur le lien ci-dessous confirmer la modification :\n" +
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
			statement2.setString(1, cryptPass(login));
			result = statement2.executeQuery();

			if(result.next())
				return "login existant";



			PreparedStatement statement3 = con.prepareStatement("insert into utilisateur (nom, prenom, adresse_mail, login, prima_pass) values(?, ?, ?, ?, ?) returning id_utilisateur");
			statement3.setString(1, nom);
			statement3.setString(2, prenom);
			statement3.setString(3, mail);
			statement3.setString(4, cryptPass(login));
			statement3.setString(5, cryptPass(pass));

			result = statement3.executeQuery();
			result.next();
			int id = result.getInt(1);

			String token = generateToken();
			PreparedStatement statement4 = con.prepareStatement("insert into validation (id_utilisateur, token) values(?, ?)");
			statement4.setInt(1, id);
			statement4.setString(2, token);
			statement4.executeUpdate();
			return token;

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



	public void ajoutRoleUtilisateur(String token) throws Exception {
		Connection con = null;
		try {	
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();



			PreparedStatement statement = con.prepareStatement("select id_utilisateur from validation where token = ?");
			statement.setString(1, token);
			ResultSet result = statement.executeQuery();

			if(result.next()){
				int id = result.getInt(1);

				PreparedStatement statement2 = con.prepareStatement("insert into role (id_utilisateur, role) values(?, ?)");
				statement2.setInt(1, id);
				statement2.setString(2, "role2");
				statement2.executeUpdate();

				PreparedStatement statement3 = con.prepareStatement("delete from validation where token = ?");
				statement3.setString(1, token);
				statement3.executeUpdate();
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

	public void deleteValidation(String token)
	{
		Connection con = null;
		try 
		{	
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();

			PreparedStatement statement3 = con.prepareStatement("delete from validation where token = ?");
			statement3.setString(1, token);
			statement3.executeUpdate();
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		finally
		{
			try{
				con.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public void suprimerValidationAndUser(String token) throws Exception {
		Connection con = null;
		try {	
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();

			PreparedStatement statement = con.prepareStatement("delete from validation where token = ? returning id_utilisateur");
			statement.setString(1, token);
			ResultSet result = statement.executeQuery();

			if(result.next()){
				PreparedStatement statement2 = con.prepareStatement("delete from utilisateur where id_utilisateur = ?");
				statement2.setInt(1, result.getInt(1));
				statement2.executeUpdate();
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


	public String getMailUtilisateurWithLogin(String login) {

		String mail = null;
		Connection con = null;

		try {	
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();

			PreparedStatement statement2 = con.prepareStatement("select adresse_mail from utilisateur where login = ?");
			statement2.setString(1, cryptPass(login));
			ResultSet rs = statement2.executeQuery();

			if(rs.next()){
				mail = rs.getString(1);
			}
			return mail;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (NamingException e) {
			e.printStackTrace();
		} finally{
			try{
				con.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}

		return mail;
	}

	public String getMailUtilisateurWithToken(String token) throws Exception {

		String mail = null;
		Connection con = null;

		try {	
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();

			PreparedStatement statement = con.prepareStatement("select id_utilisateur from validation where token = ?"); // Aurelia ? T'es bourré ?
			statement.setString(1, token);
			ResultSet result = statement.executeQuery();

			if(result.next()){
				PreparedStatement statement2 = con.prepareStatement("select adresse_mail from utilisateur where id_utilisateur = ?");
				statement2.setInt(1, result.getInt(1));
				result = statement2.executeQuery();

				if(result.next()){
					mail = result.getString(1);
				}
			}
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
			statement.setString(2, cryptPass(login));
			statement.setString(3, mail);
			int result = statement.executeUpdate();

			System.out.println(result);
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

				PreparedStatement statement2 = con.prepareStatement("select id_media, chemin, nom, type, doitinscrit from media where id_article = ?");
				statement2.setInt(1, id_article);
				result = statement2.executeQuery();

				while(result.next())
				{
					article.getMedias().add(new Media(result.getInt("id_media"),result.getString("chemin"), result.getString("nom"), result.getString("type"), result.getBoolean("doitinscrit")));
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
				String contenu =  result.getString("contenu").replaceAll("\r", "<br />");
				articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("article_titre"), contenu));
			}

			statement.close();
			String query = "select id_media, chemin, id_article, nom, type, doitInscrit from media where media.id_article in (";

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
				articles.get(result.getInt("id_article")).getMedias().add(new Media(result.getInt("id_media"), result.getString("chemin"), result.getString("nom"), result.getString("type"), result.getBoolean("doitInscrit")));
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
				String contenu =  result.getString("contenu").replaceAll("\r", "<br />");
				articles.put(result.getInt("id_article"), new Article(result.getInt("id_article"),result.getString("titre"), contenu));
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


	public int ajouterMedia(int id_article, String chemin, String nom, String type, String extension, boolean doit_inscrit){
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("insert into media (chemin, type, id_article, nom, doitInscrit) values(? || (select last_value from media_id_media_seq) || ?, ?, ?, ?, ?) returning id_media");
			statement.setString(1, chemin);
			statement.setString(2, extension);
			statement.setString(3, type);
			statement.setInt(4, id_article);
			statement.setString(5, nom);
			statement.setBoolean(6, doit_inscrit);
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


	public void supprimerMedia(String chemin, int id_media)
	{
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

	public void deletePdf(String racine, int id_media, int id_article)
	{
		Connection con = null;
		File pdf = new File(racine + "WEB-INF/pdf/" + id_article + "/" + id_media + ".pdf");

		try{
			pdf.delete();
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("delete from media where id_media = ?");
			statement.setInt(1, id_media);
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

	public ArrayList<Media> getMedias(int idArticle)
	{
		ArrayList<Media> medias = new ArrayList<Media>();
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select chemin, type, nom, doitInscrit from media where id_article = ?");
			statement.setInt(1, idArticle);
			ResultSet result = statement.executeQuery();
			while(result.next()){
				medias.add(new Media(result.getString("chemin"), result.getString("nom"), result.getString("type"), result.getBoolean("doitInscrit")));
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
		File file = new File(racine + "WEB-INF/pdf/" + id_article + "/");

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

	public int addPdf(int id_article, String name, boolean doit_inscrit)
	{
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("insert into media (id_article, type, nom, chemin, doitInscrit) values(?, ?, ?, 'Pdf?id=' || (select last_value from media_id_media_seq)  || '&id_a=' || ?, ?) returning id_media");
			statement.setInt(1, id_article);
			statement.setString(2, "pdf");
			statement.setString(3, name);
			statement.setInt(4, id_article);
			statement.setBoolean(5, doit_inscrit);
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


	public int addVideo(String url_video, Integer id_article, boolean doit_inscrit)
	{
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("insert into media (id_article, type, chemin, doitInscrit) values(?, ?, ?, ?) returning id_media");
			statement.setInt(1, id_article);
			statement.setString(2, "video");
			statement.setString(3, url_video);
			statement.setBoolean(4, doit_inscrit);
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

	public void deleteVideo(int id_media) 
	{
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("delete from media where id_media = ?");
			statement.setInt(1, id_media);
			statement.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{ con.close(); }catch(Exception e){}
		}
	}

	public void updateDroitMedia(int id_media, boolean doit_inscrit) 
	{
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("update media set doitinscrit = ? where id_media = ?");
			statement.setBoolean(1, doit_inscrit);
			statement.setInt(2, id_media);
			statement.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{ con.close(); }catch(Exception e){}
		}
	}

	// ---------------------------------------- Gestion clown ----------------------------------------------------

	public void renameClown(int id_clown, String new_name)
	{
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("update clown set nom = ? where id_clown = ?");
			statement.setString(1, new_name);
			statement.setInt(2, id_clown);
			statement.executeUpdate();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{ con.close(); }catch(Exception e){}
		}
	}

	public void changePortraitClown(String racine, Integer id_clown, Part media) 
	{
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select chemin from media_clown where id_clown = ? and type like 'portrait'");
			statement.setInt(1, id_clown);
			ResultSet result = statement.executeQuery();
			result.next();
			String chemin = result.getString("chemin");
			media.write(racine + chemin);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{ con.close(); }catch(Exception e){}
		}
	}

	public Object[] addPhotoClown(Integer id_clown, String racine, String name_media, Part part) 
	{
		Object[] return_values = new Object[2];
		Connection con = null;
		return_values[1] = "images/clowns/" + id_clown + "/";
		String extension = part.getSubmittedFileName().substring(part.getSubmittedFileName().lastIndexOf("."));

		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("insert into media_clown (id_clown, type, nom, chemin) values(?, ?, ?, ? || (select last_value from media_clown_id_media_seq) || ?) returning id_media");
			statement.setInt(1, id_clown);
			statement.setString(2, "photo");
			statement.setString(3, name_media);
			statement.setString(4, return_values[1].toString());
			statement.setString(5, extension);
			ResultSet result = statement.executeQuery();
			result.next();
			return_values[0] =  result.getInt("id_media");
			return_values[1] = return_values[1].toString() + return_values[0].toString() + extension;
			part.write(racine + return_values[1]);
			return return_values;
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{ con.close(); }catch(Exception e){}
		}
		return return_values;
	}

	public void deleteMediaClown(String racine, String chemin, int id_media) 
	{
		Connection con = null;
		File img = new File(racine + chemin);
		try{
			img.delete();
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("delete from media_clown where id_media = ?");
			statement.setInt(1, id_media);
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

	public void renameMediaClown(int id_media, String new_name) 
	{
		Connection con = null;
		try{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("update media_clown set nom = ? where id_media = ?");
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

	public void deleteClown(String racine, int id_clown) 
	{
		Connection con = null;
		File file = new File(racine + "images/clowns/" + id_clown);

		try{
			if(file.exists())
			{
				for(File f : file.listFiles())
					f.delete();

				file.delete();
			}

			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("delete from clown where id_clown = ?");
			statement.setInt(1, id_clown);
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

	public void addClown(String racine, String name_clown, Part part) 
	{
		Connection con = null;
		String extension = part.getSubmittedFileName().substring(part.getSubmittedFileName().lastIndexOf("."));
		try{

			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("insert into clown(nom) values(?) returning id_clown");
			statement.setString(1, name_clown);
			ResultSet result = statement.executeQuery();
			result.next();
			int id_clown = result.getInt("id_clown");
			File file = new File(racine + "images/clowns/" + id_clown);

			if(!file.exists())
			{
				file.mkdirs();
			}

			PreparedStatement statement2 = con.prepareStatement("insert into media_clown(id_clown, chemin, type, nom) values(?, ?  || (select last_value from media_clown_id_media_seq) || ?, 'portrait', 'portrait') returning id_media");
			statement2.setInt(1, id_clown);
			statement2.setString(2, "images/clowns/" + id_clown + "/");
			statement2.setString(3, extension);
			result = statement2.executeQuery();
			result.next();
			int id_media = result.getInt("id_media");
			part.write(racine + "images/clowns/" + id_clown + "/" +  id_media + extension);
		} catch (Exception e){
			e.printStackTrace();
		} finally{
			try{
				con.close();
			} catch(Exception e){
			}
		}
	}

	public boolean getDoitInscrit(int id_media, int id_article) throws Exception
	{
		Connection con = null;
		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select doitinscrit from media where id_media = ? and id_article = ?");
			statement.setInt(1, id_media);
			statement.setInt(2, id_article);
			ResultSet result = statement.executeQuery();

			if(result.next())
			{
				return result.getBoolean("doitinscrit");
			}
			else
				throw new Exception("Fichier demander introuvable");
		}
		catch(Exception e)
		{
			if(e.getMessage().equals("Fichier demander introuvable"))
				throw e;
			else
				System.out.println(e.getMessage());
		}
		finally
		{
			try{
				con.close();
			} catch(Exception e){}
		}

		return true;
	}

	public tools.Media getMedia(int id_media)
	{
		tools.Media media = new Media();
		Connection con = null;

		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select * from media where id_media = ?");
			statement.setInt(1, id_media);
			ResultSet result = statement.executeQuery();

			if(result.next())
			{
				media.setId(result.getInt("id_media"));
				media.setIdArticle(result.getInt("id_article"));
				media.setChemin(result.getString("chemin"));
				media.setNom(result.getString("nom"));
				media.setType(result.getString("type"));
				media.setDoitInscrit(result.getBoolean("doitinscrit"));
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{
				con.close();
			} catch(Exception e){}
		}

		return media;
	}

	public ArrayList<Utilisateur> getUsers()
	{
		ArrayList<Utilisateur> listUser = new ArrayList<>();
		Connection con = null;

		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select id_utilisateur, nom, prenom, adresse_mail from utilisateur");
			ResultSet result = statement.executeQuery();

			PreparedStatement psRole = con.prepareStatement("select role from role where id_utilisateur = ?");
			while(result.next())
			{
				Utilisateur user = new Utilisateur();
				user.setId(result.getInt("id_utilisateur"));
				user.setNom(result.getString("nom"));
				user.setPrenom(result.getString("prenom"));
				user.setMail(result.getString("adresse_mail"));

				psRole.setInt(1, user.getId());
				ResultSet rs = psRole.executeQuery();

				if(rs.next())
					user.setRole(rs.getString("role").equals("role4") ? "Administrateur" : "Utilisateur");
				else
					user.setRole("Inscription non validé");

				listUser.add(user);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{
				con.close();
			} catch(Exception e){}
		}

		return listUser;	
	}

	public void addValidation(int id_utilisateur, String token)
	{
		Connection con = null;

		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("insert into validation(id_utilisateur, token) values(?, ?)");
			statement.setInt(1, id_utilisateur);
			statement.setString(2, token);
			statement.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{
				con.close();
			} catch(Exception e){}
		}
	}

	public void addValidation(int id_utilisateur, String token, String pass)
	{
		Connection con = null;

		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement psVerif = con.prepareStatement("select 1 from validation where id_utilisateur = ?");
			psVerif.setInt(1, id_utilisateur);
			ResultSet rs = psVerif.executeQuery();

			if(rs.next())
			{
				PreparedStatement statement = con.prepareStatement("update validation set token = ?, modifiedPassword = ? where id_utilisateur = ?");
				statement.setString(1, token);
				statement.setString(2, cryptPass(pass));
				statement.setInt(3, id_utilisateur);
				statement.executeUpdate();
			}
			else
			{
				PreparedStatement statement = con.prepareStatement("insert into validation values(?, ?, ?)");
				statement.setInt(1, id_utilisateur);
				statement.setString(2, token);
				statement.setString(3, cryptPass(pass));
				statement.executeUpdate();
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{
				con.close();
			} catch(Exception e){}
		}
	}

	public int getIdUserWithLogin(String login) 
	{
		Connection con = null;
		int idUser = -1;

		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("select id_utilisateur from utilisateur where login = ?");
			statement.setString(1, cryptPass(login));
			ResultSet result = statement.executeQuery();

			if(result.next())
				idUser = result.getInt("id_utilisateur");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{
				con.close();
			} catch(Exception e){}
		}

		return idUser;
	}

	public void confirmModificationPassword(String token) 
	{
		Connection con = null;

		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			PreparedStatement statement = con.prepareStatement("update utilisateur set prima_pass = (select modifiedPassword from validation where token = ?) where id_utilisateur = (select id_utilisateur from validation where token = ?)");
			statement.setString(1, token);
			statement.setString(2, token);
			statement.executeUpdate();
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{
				con.close();
			} catch(Exception e){}
		}
	}

	public boolean updateUtilisateur(int id, String nom, String prenom, String mail, String privilege)
	{
		boolean retour = true;
		Connection con = null;

		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();
			con.createStatement().executeUpdate("begin transaction");
			PreparedStatement statement = con.prepareStatement("update utilisateur set nom = ?, prenom = ?, adresse_mail = ? where id_utilisateur = ?;");
			statement.setString(1, nom);
			statement.setString(2, prenom);
			statement.setString(3, mail);
			statement.setInt(4, id);

			if(statement.executeUpdate() == 0)
			{
				con.createStatement().executeUpdate("rollback");
				retour = false;
			}
			else if(privilege != null && ("utilisateur".equalsIgnoreCase(privilege) || "administrateur".equalsIgnoreCase(privilege)))
			{
				statement = con.prepareStatement("update role set role = ? where id_utilisateur = ?");
				statement.setString(1, privilege.equalsIgnoreCase("administrateur") ? "role4" : "role2");
				statement.setInt(2, id);

				if(statement.executeUpdate() == 0)
				{
					con.createStatement().executeUpdate("rollback");
					retour = false;
				}
				else
					con.createStatement().executeUpdate("commit");
			}
			else
				con.createStatement().executeUpdate("commit");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{
				con.close();
			} catch(Exception e){}
		}

		return retour;
	}

	public boolean deleteUtilisateur(int id)
	{
		boolean retour = true;

		Connection con = null;

		try
		{
			con = ((DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase")).getConnection();

			PreparedStatement statement = con.prepareStatement("delete from utilisateur where id_utilisateur = ?");
			statement.setInt(1, id);

			if(statement.executeUpdate() == 0)
				retour = false;
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			try{
				con.close();
			} catch(Exception e){}
		}

		return retour;
	}
}
