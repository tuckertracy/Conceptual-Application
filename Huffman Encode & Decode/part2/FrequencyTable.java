import java.io.*;
import java.util.*;

/*
 * Tabulates the frequencies of ASCII characters in
 * a document.
 */
public class FrequencyTable {
  int[] table;
  int size;

  /**
   * Builds a frequency table from the file of given path.
   * (This will work once you finish defining the other
   *  constructor and addOne method below.)
   */
  public FrequencyTable(String path) {
    this();  // invoke the default constructor to initialize fields
    
    try {
      FileReader fr = new FileReader(path);
      int c;
      while ( (c = fr.read()) != -1 ) {
        addOne((char)c);
      }
      fr.close();
    } catch (IOException e) {
      System.err.println("Error reading file: " + path);
      e.printStackTrace();
    }
  }
  
  /**
   * Default constructor:
   * Builds an empty frequency table
   */
  public FrequencyTable() {
    table = new int[256];
    size = 0;
  } 

  /**
   * Add 1 to the frequency count of the given character
   */
  public void addOne(char c) {
    if ( c < 0 || c > 256 ) {
        throw new IllegalStateException();
    }
    table[c] = (table[c] + 1) % c;
    size++;
  }

  /** 
   * Produce the frequency count of the given character
   */
  public int freqOf(char c) {
    if ( c < 0 || c > 256 ) {
        throw new IllegalStateException();
    }
    return table[c];
  }

  /**
   * Produce the total number of characters in the table
   */
  public int getTotalChars() {
    return size;
  }
  
    public static void main(String[] args) {
    FrequencyTable ft = new FrequencyTable("FrequencyTable.java");

    for (char ch = 0; ch < 256; ch++) {
      if (ft.freqOf(ch) > 0) {
        System.out.println( ch + ": " + ft.freqOf(ch) );
      }
    }

  }
}