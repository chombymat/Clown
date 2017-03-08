package tools;

import java.util.ArrayList;

public class Article {

	private int id;
	private String titre, description;
	private ArrayList<Media> medias;
	
	public Article(int id, String titre, String description){
		this.id = id;
		this.titre = titre;
		this.description = description;
		this.medias = new ArrayList<Media>();
	}
	
	public Article(int id, String titre){
		this.id = id;
		this.titre = titre;
		this.description = "";
		this.medias = new ArrayList<Media>();
	}
	
	public ArrayList<Media> getMedias(){
		return this.medias;
	}
	
	public void setMedias(ArrayList<Media> medias){
		this.medias = medias;
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
