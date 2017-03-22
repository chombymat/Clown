package tools;

public class Media {

	private int id;
	private String chemin, type, nom;
	private int idArticle;
	private boolean doitInscrit;

	public Media(int id, String chemin, String nom, String type){
		this.id = id;
		this.chemin = chemin;
		this.type = type;
		this.nom = nom;
		this.doitInscrit = false;	
	}

	public Media(int id, int idArticle, String chemin, String type){
		this.id = id;
		this.idArticle = idArticle;
		this.chemin = chemin;
		this.type = type;
		this.doitInscrit = false;
	}
	
	public Media(int id, int idArticle, String chemin, String type, boolean doitInscrit){
		this.id = id;
		this.idArticle = idArticle;
		this.chemin = chemin;
		this.type = type;
		this.doitInscrit = doitInscrit;
	}
	
	public Media(String chemin, String nom, int id_media){
		this.chemin = chemin;
		this.nom = nom;
		this.id = id_media;
		this.doitInscrit = false;
	}
	
	public Media(String chemin, String nom){
		this.chemin = chemin;
		this.nom = nom;
		this.doitInscrit = false;
	}
	
	public Media(String chemin, String nom, String type, boolean doitInscrit){
		this.chemin = chemin;
		this.nom = nom;
		this.type = type;
		this.doitInscrit = doitInscrit;
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
	public boolean isDoitInscrit() {
		return doitInscrit;
	}
	
	public void setDoitInscrit(boolean doitInscrit) {
		this.doitInscrit = doitInscrit;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public void setIdArticle(int idArticle) {
		this.idArticle = idArticle;
	}
}
