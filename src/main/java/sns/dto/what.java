package sns.dto;

public class what {
	
	String str = "하하";
	
	

	public String getStr() {
		return str;
	}

	public void setStr(String str) {
		this.str = str;
	}
	
	
	public static void main(String args[]){
		
		what w = new what();
		
		w.setStr(null);
	System.out.println(w.getStr());
		
	}
	
}
