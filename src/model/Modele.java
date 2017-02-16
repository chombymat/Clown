package model;

import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import tools.Article;
import tools.Media;
import tools.Utilisateur;

public class Modele 
{
	protected ResultSet result;
	protected DataSource ds = null;
	protected PreparedStatement statement = null;
	
	public Modele(){
		try 
		{
			ds = (DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase");
			
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	public Utilisateur connexion(String login, String pass) throws Exception
	{
		Utilisateur user = null;
		Connection con = null;

		try 
		{
			ds = (DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase");

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
	
	private String cryptPass(String pass)
	{
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
	
	
	
	//------------------------------------------------------UTILISATEUR------------------------------------------------------------
	
	
	
	public void ajoutUtilisateur(String nom, String prenom, String login, String mail, String pass){
		try{
			statement = ds.getConnection().prepareStatement("insert into utilisateur (nom, prenom, adresse_mail, login, prima_pass) values(?, ?, ?, ?, ?)");
			statement.setString(1, nom);
			statement.setString(2, prenom);
<<<<<<< HEAD
			statement.setString(3, login);
			statement.setString(4, mail);
			statement.setString(5, cryptPass(pass));
=======
			statement.setString(3, mail);
			statement.setString(4, login);
			statement.setString(5,  pass);
>>>>>>> e1ee8012bd93f8c17402ea0c9cec2c7e2e0bb8a7
			statement.executeUpdate();
			System.out.println("ajout de l'utiliateur : " + login);

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
	
	
	
	//------------------------------------------------------ARTICLE------------------------------------------------------------
	
	
	
	public void ajouterArticle(String titre, String description, int idProjet){
		try{
			statement = ds.getConnection().prepareStatement("insert into Article (titre, description, id_projet) values(?, ?, ?)");
			statement.setString(1, titre);
			statement.setString(2, description);
			statement.setInt(3, idProjet);
			statement.executeUpdate();
			System.out.println("ajout de l'article : " + titre);

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
	
	
	
	public ArrayList<Article> getArticles(int idProjet){
		ArrayList<Article> articles = new ArrayList<Article>();
		try{
			statement = ds.getConnection().prepareStatement("select id_article, titre, description from article where id_projet = ?");
			statement.setInt(1, idProjet);
			result = statement.executeQuery();
			while(result.next()){
				articles.add(new Article(result.getInt(1), result.getString(2), result.getString(3)));
			}
			return articles;
			
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
			statement = ds.getConnection().prepareStatement("select id_media, id_article, chemin, type from media where id_article = ?");
			statement.setInt(1, idArticle);
			result = statement.executeQuery();
			while(result.next()){
				medias.add(new Media(result.getInt(1), result.getInt(2), result.getString(3), result.getString(4)));
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
}
