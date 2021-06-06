package vti.com.railway12;

public class Position {
	byte			id;
	PositionName	name;
	
	@Override
	public String toString() {
		return name.toString();
	}
}