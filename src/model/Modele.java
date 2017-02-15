package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
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
		//Utilisateur user = new Utilisateur(id, mail, login, role)
		Connection con = null;

		try 
		{
			ds = (DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase");

			con = ds.getConnection();PreparedStatement ps_connection = con.prepareStatement(
					"select role, id_utilisateur from utilisateur, role where role.id_utilisateur = utilisateur.id_utilisateur and login = ? and 753_pass = ?");
			ps_connection.setString(1, login);
			ps_connection.setString(2, pass);
			ResultSet result = ps_connection.executeQuery();

			if(result.next())
			{
				/*infos[0] = result.getString("role");
				infos[1] = result.getString("id_utilisateur");*/
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

		return null;
	}
	
	public void ajoutUtilisateur(String nom, String prenom, String login, String mail, String pass){
		try{
			statement = ds.getConnection().prepareStatement("insert into utilisateur (nom, prenom, adresse_mail, login, prima_pass) values(?, ?, ?, ?, ?");
			statement.setString(1, nom);
			statement.setString(2, prenom);
			statement.setString(3, login);
			statement.setString(4, mail);
			statement.setString(5,  pass);
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
}
