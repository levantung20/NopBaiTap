package vti.com.railway12;
import java.util.Date;

public class Exam {
	byte 				id;
	String 				code;
	String 				title;
	CategoryQuestion	category;
	byte				duration;
	Account				creator;
	Date				creatDate;
	Question[]			questions;
	
	@Override
	public String toString() {
		return 	"Thong tin bai thi so " + id + "\n" +
				"Ma de thi: " + code + "\n" +
				"Tieu de: " + title + "\n" +
				"The loai: " + category + "\n" +
				"Thoi gian: " + duration + "\n" +
				"Nguoi tao: " + creator.fullname ;
				
	}
}
