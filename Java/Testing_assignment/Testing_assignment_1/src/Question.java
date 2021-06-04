import java.util.Date;

public class Question {
	byte 				id;
	String 				content;
	CategoryQuestion	category;
	TypeQuestion		type;
	Account				creator;
	Date				creatDate;
	Answer[] 			answers;
	
	@Override
	public String toString() {
		return "Thong tin cau hoi so " 	+ id + "\n"
										+ "Dang cau hoi: " + type + "\n"
										+ "The loai: " + category + "\n"
										+ "Noi dung: " + content + "\n"
										+ "Nguoi tao: " + creator.fullname
										
										;
	}
}
