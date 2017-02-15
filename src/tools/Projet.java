package tools;

import java.util.ArrayList;

public class Projet {

	private int id;
	private String titre, description;
	private ArrayList<Article> articles;
	
	public Projet(int id, String titre, String description){
		this.id = id;
		this.titre = titre;
		this.description = description;
		this.articles = new ArrayList<Article>();
	}
	
	public Projet(int id, String titre){
		this.id = id;
		this.titre = titre;
		this.description = "";
		this.articles = new ArrayList<Article>();
	}
	
	public void ajouterArticle(Article article){
		this.articles.add(article);
	}
	
	public void retirerArticle(int id){
		for(Article article : articles){
			if(article.getId() == id)
				this.articles.remove(article);
		}
	}
	
	public ArrayList<Article> getArticles(){
		return this.articles;
	}
	
	public void setArticles(ArrayList<Article> articles){
		this.articles = articles;
	}

	public int getId() {
		return id;
	}

	public String getTitre() {
		return titre;
	}

	public void setTitre(String titre) {
		this.titre = titre;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
}
