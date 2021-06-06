package vti.com.railway12;

import java.util.Date;
import java.util.Locale;

public class Exercise2_SystemOutPrintf {
	public static void main (String[] args) {
	// Exercise 2:
			// PRINTF
//					 Question 1:
						int x1 = 5;
						System.out.printf("this is number five: %d",x1);
//					 Question 2:
						int x2 = 100000000;
						System.out.printf(Locale.US,"%,d",x2);
//					 Question 3:
						float x3 = 5.567098F;
						System.out.printf("%1.4f",x3);
//					 Question 4:
						String fullname = "Nguyễn Văn A";
						System.out.printf("Tên tôi là \"%s\" và tôi đang độc thân",fullname);
//					 Question 5:
						Date date = new Date();
						System.out.printf("%td/%tm/%ty",date,date,date);
						System.out.printf(" %tIh:%tMp:%tSs",date,date,date);
					// Question 6:
//					Account[] accounts = {account1, account2, account3, account4, account5, account6, account7, account8, account9, account10};
//					System.out.printf("|%-25s | %-15s | %15s |%n", "Email", "Full Name", "Department");
//					for (Account account : accounts ) {
//						System.out.printf("|%-25s | %-15s | %15s |%n", account.email, account.fullname, account.department.name);
//									};
	}
}
