
public class Program {
	public static void main (String[] args) {
		// create departments
		Department department1 = new Department();
		department1.id = 1;
		department1.name = "Sale";
		
		Department department2 = new Department();
		department2.id = 2;
		department2.name = "Accouting";
		
		Department department3 = new Department();
		department3.id = 3;
		department3.name = "Marketing";
		
		Department department4 = new Department();
		department4.id = 4;
		department4.name = "Human Resource";
		
		//create positions
		Position position1 = new Position();
		position1.id = 1;
		position1.name = PositionName.DEV;
		
		Position position2 = new Position();
		position2.id = 2;
		position2.name = PositionName.PM;
		
		Position position3 = new Position();
		position3.id = 3;
		position3.name = PositionName.SCRUMMASTER;
				
		Position position4 = new Position();
		position4.id = 4;
		position4.name = PositionName.TEST;
		
		//create accounts
		
		Account account1 = new Account();
		account1.id = 1;
		account1.email = "nguyenvana@gmail.com";
		account1.username = "nguyenvana";
		account1.fullname = "Nguyen Van A";
		account1.department = department1;
		account1.position = position1;
		
		Account account2 = new Account();
		account2.id = 2;
		account2.email = "nguyenvanb@gmail.com";
		account2.username = "nguyenvanb";
		account2.fullname = "Nguyen Van B";
		account2.department = department1;
		account2.position = position1;
		
		Account account3 = new Account();
		account3.id = 3;
		account3.email = "nguyenvanc@gmail.com";
		account3.username = "nguyenvanc";
		account3.fullname = "Nguyen Van C";
		account3.department = department1;
		account3.position = position2;
		
		Account account4 = new Account();
		account4.id = 4;
		account4.email = "nguyenvand@gmail.com";
		account4.username = "nguyenvand";
		account4.fullname = "Nguyen Van D";
		account4.department = department2;
		account4.position = position1;
		
		Account account5 = new Account();
		account5.id = 5;
		account5.email = "nguyenvane@gmail.com";
		account5.username = "nguyenvane";
		account5.fullname = "Nguyen Van E";
		account5.department = department2;
		account5.position = position3;
		
		Account account6 = new Account();
		account6.id = 6;
		account6.email = "nguyenvanf@gmail.com";
		account6.username = "nguyenvanf";
		account6.fullname = "Nguyen Van F";
		account6.department = department2;
		account6.position= position2;
		
		Account account7 = new Account();
		account7.id = 7;
		account7.email = "nguyenvang@gmail.com";
		account7.username= "nguyenvang";
		account7.fullname= "Nguyen Van G";
		account7.department= department2;
		account7.position= position1;
		
		Account account8 = new Account();
		account8.id = 8;
		account8.email = "nguyenvanh@gmail.com";
		account8.username= "nguyenvanh";
		account8.fullname= "Nguyen Van H";
		account8.department= department3;
		account8.position= position1;
		
		Account account9 = new Account();
		account9.id = 9;
		account9.email = "nguyenvani@gmail.com";
		account9.username= "nguyenvani";
		account9.fullname= "Nguyen Van I";
		account9.department= department3;
		account9.position= position1;
		
		Account account10 = new Account();
		account10.id = 10;
		account10.email = "nguyenvank@gmail.com";
		account10.username= "nguyenvank";
		account10.fullname= "Nguyen Van K";
		account10.department= department4;
		account10.position= position1;
		
		//create Groups
		Group group1 = new Group();
		group1.id = 1;
		group1.name = "Java fresher";
		group1.creator = account5;
		Account[] accountsOfGroup1 = {account1, account3, account5, account6, account7};
		group1.accounts = accountsOfGroup1;
		
		Group group2 = new Group();
		group2.id = 2;
		group2.name = "C# fresher";
		group2.creator = account7;
		Account[] accountsOfGroup2 = {account2, account4, account6, account8, account7};
		group2.accounts = accountsOfGroup2;
		

		//create typeQuestion
		TypeQuestion typeQuestion1 = new TypeQuestion();
		typeQuestion1.id = 1;
		typeQuestion1.name = typeQuestion1.name.ESSAY;
		
		TypeQuestion typeQuestion2 = new TypeQuestion();
		typeQuestion2.id = 2;
		typeQuestion2.name = typeQuestion2.name.MULTIPLECHOICE;
		
		//create CategoryQuestion
		CategoryQuestion categoryQuestion1 = new CategoryQuestion();
		categoryQuestion1.id = 1;
		categoryQuestion1.name = "Java";
		
		CategoryQuestion categoryQuestion2 = new CategoryQuestion();
		categoryQuestion2.id = 2;
		categoryQuestion2.name = "C#";
		
		CategoryQuestion categoryQuestion3 = new CategoryQuestion();
		categoryQuestion3.id = 3;
		categoryQuestion3.name = "Ruby";
		
		CategoryQuestion categoryQuestion4 = new CategoryQuestion();
		categoryQuestion4.id = 4;
		categoryQuestion4.name = "Python";
		
		CategoryQuestion categoryQuestion5 = new CategoryQuestion();
		categoryQuestion5.id = 5;
		categoryQuestion5.name = "PHP";
		
		// create Questions & Answers
		Question question1 = new Question();
		question1.id = 1;
		question1.content = "Why Java is not 100% Object-oriented?";
		question1.category = categoryQuestion1;
		question1.type = typeQuestion1;
		question1.creator = account1;
		
		Question question2 = new Question();
		question2.id = 2;
		question2.content = "Why Java is platform independent?";
		question2.category = categoryQuestion1;
		question2.type = typeQuestion1;
		question2.creator = account1;
		
		Answer answer1 = new Answer();
		answer1.id = 1;
		answer1.content = "because it makes use of eight primitive data types which are not objects";
		
		Answer[] answerQuestion1 = {answer1};
		question1.answers = answerQuestion1;
		
		Answer answer2 = new Answer();
		answer2.id = 2;
		answer2.content = "because of its byte codes which can run on any system irrespective of its underlying operating system";
		
		Answer[] answerQuestion2 = {answer2};
		question2.answers = answerQuestion2;
		
		// create Exams
		Exam exam1 = new Exam();
		exam1.id = 1;
		exam1.code = "JAVA1";
		exam1.title = "Java Exam";
		exam1.creator = account1;
		exam1.duration = 60;
		exam1.category = categoryQuestion1;
		Question[] questionExam1 = {question1, question2};
		exam1.questions = questionExam1;
		
		// Print the results
		System.out.println("Danh sach cac phong ban: " 	+ "\n" + department1
														+ "\n" + department2
														+ "\n" + department3
														+ "\n" + department4 + "\n");
		
		System.out.println(account1);
		
		System.out.println(question1);
		System.out.println("Cau tra loi: " + answer1);
		
		System.out.println("\n" + exam1);
		
		System.out.println("Danh sach thanh vien cua Group " + group2.id + " :");
		for (int i = 0; i < group2.accounts.length; i++) {
			System.out.println(group2.accounts[i].fullname);
		}
	}
}
