package lab4.FileIO;


import java.io.*;
import java.util.Scanner;

public class Lab01{
	public static void main(String[] args){
		final String filename = "data/words.txt";
		testNumberOfWords(filename);
		testWriteArray();
	}
	
	public static void testNumberOfWords(String fileName){
		System.out.println("File: " + fileName);
		try{
			System.out.println("Number of Words: " + numberOfWords(fileName));
		}catch(Exception e){
			e.printStackTrace();
		}
		System.out.println("Number of Words: " + wordCount(fileName));
	}
	
	public static int numberOfWords(String fileName) throws FileNotFoundException{
		Scanner fileInput = new Scanner(new File(fileName));
		String[] line;
		int count = 0;
		while(fileInput.hasNext()){
			line = fileInput.nextLine().split(" ");
			count = count + line.length;
		}

		return count;
	}
	public static int wordCount(String filename){
		Scanner fileInput;
		try{
			fileInput = new Scanner(new File(filename));
		}catch(Exception e){
			return -1;
		}
		String[] line;
		int count = 0;
		while(fileInput.hasNext()){
			line = fileInput.nextLine().split(" ");
			count += line.length;
		}
		return count;
	}
	public static void testWriteArray(){
		Scanner console = new Scanner(System.in);
		System.out.println("### Testing WriteArray");
		System.out.println("Please enter filename: ");
		String filename = console.next();
		PrintStream ps;
		try{
			ps = new PrintStream(filename);
			int[][] arr = { {3,1,4}, {1, 5}, {9}};
			writeArray(ps, arr);
			ps.close();
			System.out.println("done");
		} catch(FileNotFoundException e){
			System.out.println("Could not find file");
		} finally {
			console.close();
		}
		
	}
	public static void writeArray(PrintStream ps, int[][] arr){
		for(int[] ar: arr){
			for(int a: ar){
				ps.print(a +" ");
			}
			ps.print("\n");
		}
	}
}
