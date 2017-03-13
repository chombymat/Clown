package tools;

public class Utilisateur {
	
	private int id;
	private String nom, prenom, mail, login, role;
	
	public String getRole() {
		return role;
	}

	public Utilisateur(int id, String nom, String prenom, String mail, String login, String role){
		this.id = id;
		this.nom = nom;
		this.prenom = prenom;
		this.mail = mail;
		this.login = login;
		this.role = role;
	}
	
	public Utilisateur(int id, String mail, String login, String role){
		this.id = id;
		this.nom = null;
		this.prenom = null;
		this.mail = mail;
		this.login = login;
		this.role = role;
	}

	public int getId() {
		return id;
	}
	
	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}
	
	
	
}
