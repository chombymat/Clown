package tools;

import java.util.ArrayList;

public class Article {

	private int id;
	private String titre, contenu;
	private ArrayList<Media> medias;
	
	public Article(int id, String titre, String contenu){
		this.id = id;
		this.titre = titre;
		this.contenu = contenu;
		this.medias = new ArrayList<Media>();
	}
	
	public void setContenu(String contenu) {
		this.contenu = contenu;
	}

	public String getContenu() {
		return contenu;
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
}
