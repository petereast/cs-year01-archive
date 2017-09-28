package lab3;

import static lab3.Arrays.*;
import lab3.Minesweeper;
import java.util.Arrays;

public class main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		System.out.println("Hello lab3!");
		int[] testArray = new int[] {1,2,3,4,5};
		System.out.println(Arrays.toString(reverse(testArray)));
		
		reverse2(testArray);
		
		System.out.println(Arrays.toString(testArray));
		
		Minesweeper test = new Minesweeper();
		
		test.generateBoard(10, 10, 0.2);
		test.displayRevealedBoard();

	}

}
