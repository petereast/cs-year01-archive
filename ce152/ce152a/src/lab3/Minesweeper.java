package lab3;

public class Minesweeper {

	boolean[][] board;
	int h, w;
	
	void generateBoard(int h, int w, double p){
		this.board = new boolean[w+2][h+2];
		int x, y;
		
		for(x = 1; x != w; x++){
			for(y = 1; y != h; y++){
				this.board[x][y] = (boolean)(Math.random() < p);
			}
		}
		
	}
	
	void displayRevealedBoard(){
		String line = "";
		
		
	}
	
}
