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

public class Connexion 
{
	public Utilisateur connexion(String login, String pass) throws Exception
	{
		//Utilisateur user = new Utilisateur(id, mail, login, role)
		Connection con = null;

		try 
		{
			DataSource ds = (DataSource)((Context)new InitialContext().lookup("java:comp/env")).lookup("mabase");

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
}
