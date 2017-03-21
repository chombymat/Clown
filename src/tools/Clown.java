package tools;

import java.util.ArrayList;

public class Clown 
{
	private String name;
	private int id_clown;
	private ArrayList<Media> list_media;
	
	public Clown(String name, int id_clown)
	{
		this.name = name;
		this.id_clown = id_clown;
		list_media = new ArrayList<>();
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getId_clown() {
		return id_clown;
	}

	public void setId_clown(int id_clown) {
		this.id_clown = id_clown;
	}

	public ArrayList<Media> getList_media() {
		return list_media;
	}

	public void setList_media(ArrayList<Media> list_media) {
		this.list_media = list_media;
	}
}
