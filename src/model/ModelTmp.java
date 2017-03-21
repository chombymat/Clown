package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.commons.lang3.StringEscapeUtils;

import tools.Article;
import tools.Media;

public class ModelTmp 
{
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
			String query = "select chemin, id_article, nom from media where media.id_article in (";

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
				articles.get(result.getInt("id_article")).getMedias().add(new Media(result.getString("chemin"), result.getString("nom")));
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
}
