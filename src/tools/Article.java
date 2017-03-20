package tools;

import java.util.ArrayList;

public class Article {

	private int id, id_projet;
	private String titre, contenu;
	private ArrayList<Media> medias;

	public int getId_projet() {
		return id_projet;
	}

	public void setId_projet(int id_projet) {
		this.id_projet = id_projet;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	public Article(int id, String titre, String contenu){
		this.id = id;
		this.titre = titre;
		this.contenu = contenu;
		this.medias = new ArrayList<Media>();
	}
	
	public Article(int id, String titre, String contenu, int id_projet){
		this.id = id;
		this.titre = titre;
		this.contenu = contenu;
		this.id_projet = id_projet;
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
