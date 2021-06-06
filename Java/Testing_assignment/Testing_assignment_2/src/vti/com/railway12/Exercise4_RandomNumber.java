package vti.com.railway12;

import java.util.Random;

public class Exercise4_RandomNumber {
	public static void main (String[] args) {
	Random generator = new Random();
	// Question 1: In ngẫu nhiên ra 1 số nguyên
	System.out.println(generator.nextInt());
	// Question 2: In ngẫu nhiên ra 1 số thực
	System.out.println(generator.nextDouble());
	// Question 3: Khai báo 1 array bao gồm các tên của các bạn trong lớp, 
	// sau đó in ngẫu nhiên ra tên của 1 bạn
	String[] listName = {"Thanh","Hoang","Cuong","Viet","Co"};
	int x = generator.nextInt(listName.length-1);
	System.out.println(listName[x]);
	}
}
