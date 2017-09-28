package lab4.FileIO;

import java.io.*;

public class TestCSV {
	public static final String csv_file_url = "https://orb.essex.ac.uk/ce/ce152/data/staff.csv";
	public static void main(String[] args) {
		testFindPhoneNumber(csv_file_url);
	}
	
	public static void testFindPhoneNumber ( String url ) {
		System.out.println("### Testing findPhoneNumber");
		for(String name: new String[] {"Kruschwitz", "Voelker", "Vickers"}) {
			try{
				System.out.println(name+ ": "+CSV.findPhoneNumber(name, url));
			} catch (IOException e){
				System.err.println("## Unable to fetch phone number");
				e.printStackTrace();
			}
		}	
	}
}
