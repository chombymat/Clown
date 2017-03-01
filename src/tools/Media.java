package tools;

public class Media {
	
	private int id;
	private String chemin, type;
	
	public Media(int id, String chemin, String type){
		this.id = id;
		this.chemin = chemin;
		this.type = type;
	}
	
	public int getId() {
		return id;
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
