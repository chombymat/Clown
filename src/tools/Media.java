package tools;

public class Media {

	private int id;
	private String chemin, type;
	private int idArticle;

	public Media(int id, String chemin, String type){
		this.id = id;
		this.chemin = chemin;
		this.type = type;
	}

	public Media(int id, int idArticle, String chemin, String type){
		this.id = id;
		this.idArticle = idArticle;
		this.chemin = chemin;
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
}
