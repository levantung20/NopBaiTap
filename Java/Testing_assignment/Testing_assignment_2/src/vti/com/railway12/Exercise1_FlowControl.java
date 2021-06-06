package vti.com.railway12;

public class Exercise1_FlowControl {
	public static void main (String[] args) {
	 // EXERCISE 1: FLOW CONTROL 
				// IF Question 1:
//			if (account2.department == null) {
//				System.out.println("Nhân viên này chưa có phòng ban");
//			} else {
//				System.out.println("Phòng ban của nhân viên này là: "
//						+ account2.department.name);
//			}

				// IF Question 2:
//			if (account2.groups.length == 0) {
//				System.out.println("Nhân viên này chưa có group");
//			} else if (account2.groups.length == 1 || account2.groups.length ==2 ) {
//				System.out.println("Group của nhân viên này là: ");
//				for (Group group : groupsofAccount2) {
//					System.out.println(group.name);
//				}
//			} else if (account2.groups.length == 3) {
//				System.out.println("Nhân viên này là người quan trọng, tham gia nhiều group");
//			} else {
//				System.out.println("Nhân viên này là người hóng chuyện, tham gia tất cả các group");
//			}
//			
			
				// IF Question 3:
//			System.out.println(	account2.department == null 
//					? "Nhân viên này chưa có phòng ban" 
//					: "Phòng ban của nhân viên này là: "+ account2.department.name
//									);
			
				// IF Question 4:
//			System.out.println(	account1.position.name == PositionName.DEV 
//								? "Đây là Developer"
//								: "Người này không phải là Developer"
//									);
				

				// CASE Question 5:
//			int x = group1.accounts.length;
//			switch (x) {
//			case 1:
//				System.out.println("Nhóm có một thành viên");
//			case 2:
//				System.out.println("Nhóm có hai thành viên");
//			case 3:
//				System.out.println("Nhóm có ba thành viên");
//				break;
//			default:
//				System.out.println("Nhóm có nhiều thành viên");
//				}
					
				// CASE Question 6:
//			int y = account2.groups.length;
//			switch(y) {
//			case 0:
//				System.out.println("Nhân viên này chưa có group");
//			case 1:
//				System.out.println("Group của nhân viên này là: ");
//				for (int x = 0; x < y; x++ ) {
//				System.out.println(account2.groups[x].name);
//				}
//			case 2:
//				System.out.println("Group của nhân viên này là: ");
//				for (int x = 0; x < y; x++ ) {
//				System.out.println(account2.groups[x].name);
//				}
//			case 3:
//				System.out.println("Nhân viên này là người quan trọng, tham gia nhiều group");
//				break;
//			default: 
//				System.out.println("Nhân viên này là người hóng chuyện, tham gia tất cả các group");
//				}	
				
				//CASE Question 7:
					
//			String x = account1.position.name.toString();
//			switch(x) {
//			case "DEV":
//				System.out.println("Đây là Developer");
//				break;
//			default:
//				System.out.println("Người này không phải là Developer");
//				}

				// FOR EACH Question 8:
//			Account[] accounts = {account1, account2, account3, account4, account5, account6, account7, account8, account9, account10};
//			for (Account account : accounts ) {
//				System.out.println("thông tin account " + account.id);
//				System.out.println("Email: "+account.email +" Fullname: "+account.fullname+" Department: "+account.department.name);
//				}
				// FOR EACH Question 9:
//			Department[] departments = {department1, department2, department3, department4};
//			for (Department department : departments) {
//				System.out.println("thông tin phòng ban " + department.id);
//				System.out.println("ID: " + department.id + " Name: " + department.name);
//				}
			
				// FOR Question 10:
//			for (int x = 0; x < accounts.length; x++) {
//				System.out.println("Thông tin account thứ " + accounts[x].id + " là:");
//				System.out.println("Email: " + accounts[x].email);
//				System.out.println("Full name: " + accounts[x].fullname);
//				System.out.println("Phòng ban: " + accounts[x].department.name + "\n");
//				}
					
				// FOR Question 11:
//			for ( int x = 0; x < departments.length; x++) {
//				System.out.println("Thông tin department thứ "+departments[x].id +" là:");
//				System.out.println("	ID: " + departments[x].id);
//				System.out.println("	Name: " + departments[x].name);
//				}
					
				// FOR Question 12: 		
//			for ( int x = 0; x < 2; x++) {
//				System.out.println("Thông tin department thứ "+departments[x].id +" là:");
//				System.out.println("	ID: " + departments[x].id);
//				System.out.println("	Name: " + departments[x].name);
//				}
					
				// FOR Question 13: 
//			for ( int x = 0; x < accounts.length; x++) {
//				if (x == 1) {
//					continue;
//				}
//				System.out.println("Thông tin account thứ " + accounts[x].id + " là:");
//				System.out.println("Email: " + accounts[x].email);
//				System.out.println("Full name: " + accounts[x].fullname);
//				System.out.println("Phòng ban: " + accounts[x].department.name + "\n");	
//				}
					
				// FOR Question 14: 		
//			for ( int x = 0; x < accounts.length; x++) {
//				if (x == 3) {
//				break;
//				}
//				System.out.println("Thông tin account thứ " + accounts[x].id + " là:");
//				System.out.println("Email: " + accounts[x].email);
//				System.out.println("Full name: " + accounts[x].fullname);
//				System.out.println("Phòng ban: " + accounts[x].department.name + "\n");	
//				}
					
				// FOR Question 15: 
//			for ( int x = 1; x <= 20; x++) {
//				if (x%2 == 0) {
//				System.out.println(x);
//					}
//				}
			
				// Question 16:
				// WHILE Question 10: 
//			int x = 0;			
//			while (x < accounts.length) {
//				System.out.println("Thông tin account thứ " + accounts[x].id + " là:");
//				System.out.println("Email: " + accounts[x].email);
//				System.out.println("Full name: " + accounts[x].fullname);
//				System.out.println("Phòng ban: " + accounts[x].department.name + "\n");
//				x++;
//				}
					
				// WHILE Question 11: 
//			int x = 0;			
//			while (x < departments.length) {
//				System.out.println("Thông tin department thứ "+departments[x].id +" là:");
//				System.out.println("	ID: " + departments[x].id);
//				System.out.println("	Name: " + departments[x].name);
//				x++;
//				}
					
				// WHILE Question 12: 
//			int x = 0;		 
//			while (x < 2) {
//				System.out.println("Thông tin department thứ "+departments[x].id +" là:");
//				System.out.println("	ID: " + departments[x].id);
//				System.out.println("	Name: " + departments[x].name);
//				x++;
//				}
					
				// WHILE Question 13: 		
//			int x = 0;	
//			while (x < accounts.length) {
//				if (x == 1) {
//				x++;
//				continue;
//				}
//				System.out.println("Thông tin account thứ " + accounts[x].id + " là:");
//				System.out.println("Email: " + accounts[x].email);
//				System.out.println("Full name: " + accounts[x].fullname);
//				System.out.println("Phòng ban: " + accounts[x].department.name + "\n");
//				x++;		
//				}
					
				// WHILE Question 14: In ra thông tin tất cả các account có id < 4
//			int x = 0;
//			while (x < accounts.length) {
//				if (x == 3) {
//				break;
//				}
//				System.out.println("Thông tin account thứ " + accounts[x].id + " là:");
//				System.out.println("Email: " + accounts[x].email);
//				System.out.println("Full name: " + accounts[x].fullname);
//				System.out.println("Phòng ban: " + accounts[x].department.name + "\n");
//				x++;
//				}
					
				// WHILE Question 15: 
//			int x = 0;		
//			while (x <= 20) {
//				if (x%2 != 0) {
//				x++;
//				continue;
//				}
//				System.out.println(x);
//				x++;
//				}
				
				// Question 17:
				// DO-WHILE Question 13: 
//			int x = 0;
//			do {
//				if (x == 1) {
//					x++;
//					continue;
//				}
//				System.out.println("Thông tin account thứ " + accounts[x].id + " là:");
//				System.out.println("Email: " + accounts[x].email);
//				System.out.println("Full name: " + accounts[x].fullname);
//				System.out.println("Phòng ban: " + accounts[x].department.name + "\n");
//				x++;		
//			} while (x < accounts.length);
			
				// DO-WHILE Question 14: 
//			int x = 0;
//			do {
//				if (x == 3) {
//					break;
//				}
//				System.out.println("Thông tin account thứ " + accounts[x].id + " là:");
//				System.out.println("Email: " + accounts[x].email);
//				System.out.println("Full name: " + accounts[x].fullname);
//				System.out.println("Phòng ban: " + accounts[x].department.name + "\n");
//				x++;
//			} while (x < accounts.length);
		
				// DO-WHILE Question 15: 
//			int x = 0;
//			do {
//				if(x%2 != 0 && x <= 20) {
//					x++;
//					continue;
//				}
//				System.out.println(x);
//				x++;
//				
//			} while (x <= 20);

	}
}
