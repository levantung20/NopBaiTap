import java.util.Date;

public class Account {
	short		id;
	String		email;
	String 		username;
	String		fullname;
	Department	department;
	Position	position;
	Date		createDate;
	
	//method toString
	@Override
	public String toString() {
		return "Thong tin account " + id + "\n" 
									+ "Email: " + email + "\n"
									+ "Username: " + username + "\n"
									+ "Fullname: " + fullname + "\n"
									+ "Department: " + department + "\n"
									+ "Position: " + position + "\n";
	}
}
