package lab4.FileIO;

import java.awt.*;
import javax.swing.*;

public class Chessboard extends JComponent {

	public static final int height = 600;
	public static final int width = 600;
	public static void main(String[] args) {
		JFrame f = new JFrame("Chessboard");
		f.setSize(height, width);
		f.add(new Chessboard());
		f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		f.setVisible(true);
	}

	public void paintComponent(Graphics graphics) {
		Graphics2D g = (Graphics2D) graphics;
		// draw chessboard
		int squareHeight = height/8;
		int squareWidth = width/8;
		String pos;
		int x, y;
		boolean black = true;
		for(x = 0; x != 8; x++) {
			// y != 9 - slightly larger to invoke offset of tiles.
			for(y = 0; y != 9; y ++){
				if(black){
					g.setColor(Color.black);
				} else {
					g.setColor(Color.white);
				}
				black = !black;
				g.fillRect(x*squareHeight, y*squareWidth, squareHeight, squareWidth);
				g.setColor(Color.gray);
				if(x == 0){
					//TODO: Add a positional thing here :)
					pos = Integer.toString(y);
					// x = 0 you retard
					g.drawString(pos, 0, y*squareHeight);
				}
				if(y == 0){
					pos = (new String[]{"a", "b", "c", "d", "e", "f", "g", "h"})[x];
					g.drawString(pos, x*squareWidth, 10);
				}
			}
		}
		
	}
}
