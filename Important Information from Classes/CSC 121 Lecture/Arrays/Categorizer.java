
import java.util.Scanner;
import java.io.File;
import java.io.FileNotFoundException;

/**
 * Write a description of class Categorizer here.
 *
 * @author (your name)
 * @version (a version number or a date)
 */
public class Categorizer
{

    public static void main(String[] args) 
    throws FileNotFoundException{

        System.out.println("Enter integer values to categorize ('q' to quit):");
        Scanner sc = new Scanner(System.in);
        
        Scanner fsc = new Scanner(new File("windscale.txt"));
        
        int size = fsc.nextInt();
        int[] values = new int[size];
        String[] categories = new String[size];

        for (int i = 0 ; i < values.length ; i++) {
                values[i] = fsc.nextInt();
                categories[i] = fsc.nextLine().trim();
            }
        fsc.close();
        
        while(sc.hasNextInt()) {
            int w = sc.nextInt();

            for (int i = 0; i < values.length ; i++) {
                if ( w < values[i] ) {
                    System.out.println(categories[i-1]);
                    break;
                } else if (w >= values[size-1]) {
                    System.out.println(categories[size-1]);
                    break;
                }
            }
        }
        sc.close();
    }
}