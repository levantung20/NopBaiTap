package vti.com.railway12;
import java.util.Date;

public class TypeQuestion {
	byte		id;
	TypeName 	name;
	
	@Override
	public String toString() {
		return name.toString();
	}
}
