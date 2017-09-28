package Assignment;


import static org.junit.Assert.*;

import java.lang.*;

import org.junit.Test;
import org.junit.Assert.*;

public class Exercise3 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		try {
			for(int i = 0; i<34; i++)
				System.out.println(i+" "+catalan(i));
		} catch (IllegalArgumentException e) {
			System.err.println(e.getMessage());
		}
	}
	
	public static long catalan(long n) throws IllegalArgumentException{
		if(n < 0 || n > 30)
			throw new IllegalArgumentException("The variable 'n' is outside of the acceptable range.");
		if(n == 0)
			return 1;	
		else
			return 2 * (2*n-1) * catalan(n-1)/(n+1);
	}
	
	@Test
	public void catalanTest(){
		assertTrue(catalan(0)==1.0);
		assertTrue(catalan(2)==2.0);
		assertTrue(catalan(4)==14.0);
		assertTrue(catalan(8)==1430.0);
		assertTrue(catalan(16)==35357670.0);
		assertTrue(catalan(12)==208012.0);
		assertTrue(catalan(9)==4862.0);
		
	}

}
