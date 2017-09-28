//Java
package Assignment;

import java.util.Scanner;

public class Exercise1{
	public static void main(String[] args) {
		System.out.println("[ce152-assignment] Exercise One");
		pizzaServiceA();
		pizzaServiceB();
	}
	
	public static void pizzaServiceA(){
		System.out.println("Pizza Service A");
		Scanner stdin = new Scanner(System.in);
		System.out.println("Please enter a pizza order:");
		String input = stdin.nextLine();
		
		while(!input.equals("quit")){
			getValueOfPizza(input, 0);
			System.out.println("Please enter a pizza order:");
			input = stdin.nextLine();
		}
		System.out.println("exit");
	}
	public static void pizzaServiceB(){
		System.out.println("Pizza Service B");
		Scanner stdin = new Scanner(System.in);
		System.out.println("Please enter a pizza order:");
		String input = stdin.nextLine();
		
		while(!input.equals("quit")){
			getValueOfPizza(input, 3);
			System.out.println("Please enter a pizza order:");
			input = stdin.nextLine();
		}
		System.out.println("exit");
	}	
	
	
	public static double getValueOfPizza(String input, int limit) {
		if(!(input.toCharArray()[0] == 'l' || input.toCharArray()[0] == 'm')){
			System.err.println("Invalid size, expected either 'l' or 'm'");
			return -1;
		}
			
		
		boolean large = (input.toCharArray()[0] == 'l');
		
		// Calculate base price
		int totalPrice = large ? 500: 400;
		
		int numberOfToppings = 0;
		
		int[] toppingTrack = new int[]{0,0,0,0,0};
		
		String output = "";
		
		for(char attr: input.substring(1).toCharArray()) {
			if ( attr == 'h' ) {
				// Ham - £1.40 medium and £2.10 large
				totalPrice += large ? 210: 140;
				toppingTrack[0]++;
				output += "ham, ";
			} else if ( attr == 'm' ) {
				// Mozzarella - £1.00 medium and £1.50 large
				totalPrice += large ? 150: 100;
				toppingTrack[1]++;
				output += "mozzarella, ";
			} else if ( attr == 'o' ) {
				// Olives - £0.80 medium and £1.20 large
				totalPrice += large ? 120: 80;
				toppingTrack[2]++;
				output += "olives, ";
			} else if ( attr == 'p' ) {
				// Pineapple - £1.00 medium and £1.50 large
				totalPrice += large ? 150: 100;
				toppingTrack[3]++;
				output += "pineapple, ";
			} else if ( attr == 's' ) {
				// Spinach - £0.80 medium and £1.20 large
				totalPrice += large ? 120: 80;
				toppingTrack[4]++;
				output += "spinach, ";
			} else {
				//Unrecognised topping added
				System.err.println("Unrecognised topping added, expected any of: 'h', 'm', 'o', 'p' or 's'.");
				return -1;
				
			}
			numberOfToppings++;
			
		}
		
		if(limit != 0){
			boolean valid = true;
			for(int count: toppingTrack){
				if(count >= limit){
					valid = false;
				}
			}
			if(!valid){
				System.err.println("Too many of the same topping!\n");
				return -1;
			}
		}
		
		if(!output.equals(""))
			output = "with " + output;
		else
			output = "with no toppings ";
		
		if(numberOfToppings>4){
			System.err.println("Too many toppings");
			return -1;
		}
		
		
		String size = large ? "Large" : "Medium";

		System.out.printf("%s pizza %s£%.2f\n", size, output,(double)totalPrice/100);
		
		return (double)totalPrice/100;
	}


}
