package tools;

public class Media {

	private int id;
	private String chemin, type, nom;
	private int idArticle;

	public Media(int id, String chemin, String nom, String type){
		this.id = id;
		this.chemin = chemin;
		this.type = type;
		this.nom = nom;
	}

	public Media(int id, int idArticle, String chemin, String type){
		this.id = id;
		this.idArticle = idArticle;
		this.chemin = chemin;
		this.type = type;
	}
	
	public Media(String chemin, String nom){
		this.chemin = chemin;
		this.nom = nom;
	}
	
	public Media(String chemin, String nom, String type){
		this.chemin = chemin;
		this.nom = nom;
		this.type = type;
	}

	public int getId() {
		return id;
	}

	public int getIdArticle() {
		return idArticle;
	}

	public String getChemin() {
		return chemin;
	}

	public void setChemin(String chemin) {
		this.chemin = chemin;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}
}
