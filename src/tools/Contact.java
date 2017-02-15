package tools;

public class Contact {

	private int numero_telephone, numero_rue, code_postal;
	private String mail, rue, ville;
	
	public Contact(int numero_telephone, String mail){
		this.numero_telephone = numero_telephone;
		this.mail = mail;
	}
	
	public Contact(int numero_telephone, String mail, int numero_rue, String rue, int code_postal, String ville){
		this.numero_telephone = numero_telephone;
		this.mail = mail;
		this.numero_rue = numero_rue;
		this.rue= rue;
		this.code_postal = code_postal;
		this.ville = ville;
	}

	public int getNumero_telephone() {
		return numero_telephone;
	}

	public void setNumero_telephone(int numero_telephone) {
		this.numero_telephone = numero_telephone;
	}

	public int getNumero_rue() {
		return numero_rue;
	}

	public void setNumero_rue(int numero_rue) {
		this.numero_rue = numero_rue;
	}

	public int getCode_postal() {
		return code_postal;
	}

	public void setCode_postal(int code_postal) {
		this.code_postal = code_postal;
	}

	public String getMail() {
		return mail;
	}

	public void setMail(String mail) {
		this.mail = mail;
	}

	public String getRue() {
		return rue;
	}

	public void setRue(String rue) {
		this.rue = rue;
	}

	public String getVille() {
		return ville;
	}

	public void setVille(String ville) {
		this.ville = ville;
	}
	
}
