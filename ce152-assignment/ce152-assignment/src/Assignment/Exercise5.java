package Assignment;

import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
// import java.util.nner;
import java.util.Set;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

public class Exercise5 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		exercise5a();
		exercise5b();
		exercise5c();
		exercise5d();
		exercise5e();

	}

	public static void exercise5a(){
		Hill x = new Hill(255, "Ben Nevis", "Highland", 1344.5, 56.796849, -5.003525);
		System.out.println(x);
	}

	public static void exercise5b(){

		List<Hill> hills = readHills();

		int count = 0;

		while(count < 20){
			System.out.println(hills.get(count));
			count++;
		}

	}

	public static void exercise5c(){

		// Get a list of hills

		List<Hill> hills = readHills();


		// Searchable list of hills

		String[] msg = {"Enter a hill name or the word \"quit\" to exit.", "Exited", "Total results: "};
		String inputBuffer = "";

		int resultsCount = 0;


		System.out.println(msg[0]);
		Scanner input = new Scanner(System.in);

		while(!(inputBuffer = input.nextLine().toLowerCase()).equals("quit")){
			for(Hill h: hills){
				// ignore case, only compare the first overlapping characters
				if(h.name.toLowerCase().substring(0, inputBuffer.length()).equals(inputBuffer)){
					System.out.println(h);
					resultsCount++;
				}
			}
			System.out.println(msg[2]+resultsCount);
			resultsCount=0;
			System.out.println(msg[0]);
		}
		System.out.println(msg[1]);
	}

	public static void exercise5d(){
		// Sort hills list alphabetically, output first 20 results

		List<Hill> hills = readHills();

		hills.sort(hillsName);
		System.out.println("*******************\nHills Sorted *alphabetically*");

		int i = 0;
		while(i < 20){
			System.out.println(hills.get(i++));
		}
		System.out.println("*******************\nHills Sorted by *Height*");
		hills.sort(hillsHeight);
		i = 0;
		while(i < 20){
			System.out.println(hills.get(i++));
		}


		// Sort hills by height, output first 20 results
	}

	public static void exercise5e(){
		Map<String, Set<Hill>> hbc = hillsByCounty(readHills());
		System.out.println("Hills by county:");
		for(int i = 0; i < 3; i++){
			System.out.println("**********************************************\nCounty: "+hbc.keySet().toArray()[i]);
			for(int h = 0; h < 3; h++){
				Hill current = (Hill) hbc.get(hbc.keySet().toArray()[i]).toArray()[h];
				System.out.println(current.name+": "+current.height+"m");
			}
		}
	}

	public static Map<String, Set<Hill>> hillsByCounty(List<Hill> hills){
		// Should return a map of Hills by county,
		// should be ordered by county name, and by hill name

		// TODO: Implement TreeMap rather than HashMap so it can be sorted.
		// TODO: Maybe use a SortedMap instead? Java makes things easy!

		// Implementation A - a much less efficient way of doing things, however it should be more reliable
		// I don't think I get any marks for efficiency. (The first way was O(n), this is O(n^2)

		Map<String, Set<Hill>> output = new TreeMap<String, Set<Hill>>();

		Set<String> counties = new HashSet<>();

		for(Hill h: hills){
			if(!counties.contains(h.countyName)){
				// If we haven't encountered this county before

				Set<Hill> countyHills = new TreeSet<Hill>();

				counties.add(h.countyName);
				for(Hill j: hills){
					// For all the other hills...
					if(j.countyName.equals(h.countyName)){
					countyHills.add(j);
					}
				}
				output.put(h.countyName, countyHills);
			}

		}
		return output;

		// What follows is a much more efficient way of performing this operation,
		// I didn't quite get it to work, but I will!, just not right now
//		Set<Hill> tmp = new HashSet<Hill>();
//
//		for(Hill h: hills){
//			tmp = new HashSet<Hill>();
//			if(output.get(h.countyName) == null){
//				tmp.add(h);
//				output.put(h.countyName, tmp);
//			} else {
//
//				tmp.addAll(output.get(h.countyName));
//
//				System.out.println(h.toString()+tmp);
//				output.replace(h.countyName, tmp);
//			}
//			System.out.println(output.get(h.countyName).toArray().length);
//		}
//
//
//		return output;
	}

	public static Comparator<Hill> hillsName = new Comparator<Hill>(){
		public int compare(Hill current, Hill other){
			return current.name.compareToIgnoreCase(other.name);
		}
	};

	public static Comparator<Hill> hillsHeight = new Comparator<Hill>() {
		public int compare(Hill current, Hill other){
			if(current.height == other.height)
				return 0;
			else
				return current.height > other.height ? -1 : 1;
		}
	};


	public static List<Hill> readHills(){

		final String fileUrl = "https://orb.essex.ac.uk/ce/ce152/data/assign/hills.csv";
		Scanner file = null;
		URL url;
		try {
			url = new URL(fileUrl);
			file = new Scanner(url.openConnection().getInputStream());
		} catch (IOException e){
			System.err.println(e.getMessage());
		}

		// Open the file (load from Internet maybe?)



		List<Hill> outputHills = new LinkedList<Hill>();
		String line;

		int failcount = 0;
		int hillsCount = 0;

		System.out.print("Fetching list of hills");
		// For each line:
		while(file.hasNext() && (line = file.nextLine())!= null){
			//System.out.println(line);
		//		split into parts,
			String[] items = line.split(",");
		//		write each of those parts to a new Hill
		//		add that new Hill to the list
			try{
				outputHills.add(new Hill(Integer.parseInt(items[0]),
						items[1],
						items[2],
						Double.parseDouble(items[3]),
						Double.parseDouble(items[4]),
						Double.parseDouble(items[5])));
				hillsCount++;
		//		if the line is not in this format, skip the line
			} catch (NumberFormatException e) {
				if(failcount < 1){
					// This row is invalid, and probably is the first row
					// this shouldn't happen again
					failcount++;
					continue;
				} else{
					//Something's wrong here...
					e.printStackTrace();
				}
			}
			if(hillsCount % 1000 == 0){
				System.out.print("*");
			} else if(hillsCount % 200 == 0){
				System.out.print(".");
			}
		}

		System.out.println("Done!");


		file.close();
		return outputHills;

	}

}

class Hill implements Comparable<Hill>{

	int number;
	String name;
	String countyName;
	double height;
	double latitude;
	double longitude;

	Hill( int number, String name, String countyName, double height, double longitude, double latitude){
		this.number = number;
		this.name = name;
		this.countyName = countyName;
		this.height = height;
		this.longitude = longitude;
		this.latitude = latitude;
	}
	public String toString(){
		return this.number+","+this.name+","+this.countyName+","+this.height+","+this.longitude+","+this.latitude;
	}

	public int compareTo(Hill o){
		return this.name.compareTo(o.name);
	}

	public boolean equals(Hill h){
		return this.number == h.number;
	}

}
