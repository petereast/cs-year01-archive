package lab4.FileIO;

import java.io.IOException;
import java.net.URL;
import java.util.Arrays;
import java.util.Scanner;

public class CSV {
	public static final String csv_file_url = "https://orb.essex.ac.uk/ce/ce152/data/staff.csv";
	public static final String deliminator = ",";
	
	public static void main(String[] args){
	try{	
		fetchDemo();
	} catch (IOException e) {
		System.err.println("Failed to fetchDemo()");
		e.printStackTrace();
	}
	}
	
	public static void fetchDemo() throws IOException{
		URL url = new URL(csv_file_url);
		Scanner input = new Scanner(url.openConnection().getInputStream());
		readBasicCSVFile(input);
		
		//testing find phone number here
		input.close();
	}
	
	public static String findPhoneNumber(String name, String resourceUrl) throws IOException{
		URL url = new URL(resourceUrl);
				
		Scanner input = new Scanner(url.openConnection().getInputStream());
		
		while(input.hasNextLine()){
			String[] fields = input.nextLine().split(deliminator);
			
			for(String f: fields){
				if(f.toLowerCase().contains(name.toLowerCase())){
					return fields[1];
				}
			}
		}
		
		return "No Phone number";
		
	}
	
	public static void readBasicCSVFile(Scanner input){
		while(input.hasNextLine()){
			processRecord(input.nextLine());
		}
	}
	
	public static void processRecord(String line){
		String[] fields = line.split(deliminator);
		
		System.out.println(Arrays.toString(fields));
	}
}
