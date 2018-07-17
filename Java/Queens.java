/*
Tsz Yan Wong
Programming Languages
Homework Assignemnt 4
Part 1 - Java N-Queens with Backtracking
*/

import java.util.Arrays;
import javax.swing.JOptionPane; //For the pop-up screen asking for input for the number of queens
import java.lang.Math;

public class Queens
{
	//Create an array to store the output as a list
	static int[] solution;

	int num_of_solution = 0; //counter

	/**
	@param x the x position on the board
	@param N the number of queens to be placed
	**/
	public void place(int x, int N)
	{
		for (int i = 0; i < N; i++)
		{
			//see whether the queen can be placed at i th column.
			if (checker(x, i))
			{
				//If it evaluates to True, place the queen here
				solution[x] = i;
				if (x == N - 1)
				{
					//Output the solution one with solution number indicating how many solutions there are
					System.out.println("Solution Set #" + (++num_of_solution) +
					" with " + N + " Queens: " + Arrays.toString(solution));
				}
				//place the queen
				place(x + 1, N);
			}
		}
	}

	/**
			The method checker checks if the queen can be placed at the position (x,y)
			This will check all the rows as well as columns to see if it is possible
			to place the queen
			@param px the x position
			@param py the y position
	**/

	public boolean checker(int px, int py)
	{
		for (int i = 0; i < px; i++)
		{
			if ((solution[i] == py) || Math.abs(solution[i] - py) == (Math.abs(i - px)))
				return false;
		}
		return true;
	}

	//Main
	public static void main(String[] args)
	{
		//Input: Ask for the number of queens to be placed
		String input = JOptionPane.showInputDialog("Enter the number of Queens (N): ");
		//Converts the string to int values
		int n = Integer.parseInt(input);

		solution = new int[n];
		//Create the Object
		Queens queen = new Queens();
		//Calling the place method to place the queen
		queen.place(0, n);

		//Ending message
		System.out.println("Ended");
	}
}
