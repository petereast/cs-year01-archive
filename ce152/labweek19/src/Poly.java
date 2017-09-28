package lab4.FileIO;

import java.awt.*;
import javax.swing.*;
import java.util.Arrays;

public class Poly extends JComponent {
	public static final int window_height = 600;
	public static final int window_width = 600;
	
	public static final int[] window_centre = new int[]{window_height/2,window_width/2};

	public static void main(String[] args) {
		JFrame f = new JFrame("Polygon");
		
		f.setSize(window_width, window_height);
		
		f.add(new Poly());
		
		f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		f.setVisible(true);
	}
	
	public void paintComponent(Graphics graphics) {
		Graphics2D g = (Graphics2D) graphics;


		plotPoints(generateEdgePoints(3, 250), g);
		
	}

	public void plotPoints(int[][] points, Graphics2D g) {
		int[] currentPoint = points[0];	
	
		for(int[] point: points) {
			// Plot the line between the current point and the previous point.
			g.drawLine(currentPoint[0], currentPoint[1], point[0], point[1]);
			currentPoint = point;
		}
	}
	
	public double generateAngle(int edgeLength) {
		// Generate angle size based on edge length.
		
		return 0.0;
	}
	
	public int[][] generateEdgePoints(int N, int radius) {
		//Generate edge points, using N as number of verticies and radius as
		// radius of the surrounding circul
		
		int[][] output = new int[N][2];
		
		int[] first_point = new int[]{window_centre[0], window_centre[1]+radius};
		output[0] = first_point;
		int[] next_point;
		
		for(int i = 1; i!=N; i++) {
			next_point = new int[]{first_point[0]-50, first_point[1]-40*i};
			output[i] = next_point;
			first_point = next_point;
		}
		
		// The next point will be from [x, y] -> [x+offsetx, y+offsety]
		// where offset[x,y] comes from trigonometric calculations based on
		// length of side & angle

		// All points are equally spaced in a circle.
		return output;		
		//return new int[][]{first_point, {200, 100}, {80, 500}, first_point};	
	}
}
