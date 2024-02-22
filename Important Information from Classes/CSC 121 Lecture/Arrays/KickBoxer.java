 

import java.util.Scanner;

/******************************************************************************
 *  Reads in the weight w of a Thai kickboxer, and prints out their
 *  kickboxing category (fly weight - super heavyweight).
 *
 *  Reference: http://www.elitekickboxing.com/competitioninfo3.asp
 *  Credit: https://introcs.cs.princeton.edu/java/14array/
 ******************************************************************************/


public class KickBoxer {
    public static void main(String[] args) { 
      int[] weights = {
          112, 115, 118, 122, 126, 130, 135, 140, 147,
          154, 160, 167, 174, 183, 189, 198, 209, 9999
      };

      String[] categories = {
          "Fly Weight",
          "Super Fly Weight",
          "Bantam Weight",
          "Super Bantam Weight",
          "Feather Weight",
          "Super Feather Weight",
          "Light Weight",
          "Super Light Weight",
          "Welter Weight",
          "Super Welter Weight",
          "Middle Weight",
          "Super Middle Weight",
          "Light Heavy Weight",
          "Super Light Heavy Weight",
          "Cruiser Weight",
          "Super Cruiser Weight",
          "Heavy Weight",
          "Super Heavy Weight"
      };

      System.out.println("Enter integer values to categorize ('q' to quit):");
      Scanner sc = new Scanner(System.in);
      while (sc.hasNextInt()) {
        int w = sc.nextInt();

        for (int i = 0; i < weights.length; i++) {
          if (w < weights[i]) {
            System.out.println(categories[i]);
            break;
          }
        }
      }
    }
}