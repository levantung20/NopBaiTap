
public class Answer {
	byte		id;
	String 		content;
	Question[]	question;
	boolean		isCorrect;
	
	@Override
	public String toString() {
		return content;
	}
}
