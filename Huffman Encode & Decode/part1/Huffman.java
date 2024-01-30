import java.io.IOException;
import java.io.*;

public class Huffman {

    public static void main(String[] args) throws IOException {

        FrequencyTable ft = new FrequencyTable("short.txt");
        HuffmanCode hc = new HuffmanCode(ft);
        for (char ch = 0; ch < 256; ch++) {
            if (ft.freqOf(ch) > 0) {
                System.out.println( ch + ": " + ft.freqOf(ch) );
                System.out.println( ch + ": " + hc.encode(ch) );
            }
        }

    }
    
    public static void compress(String inFile, String outFile) {
        try {
            FileReader fr = new FileReader(inFile);
            PrintWriter out = new PrintWriter(outFile);
            FrequencyTable ft = new FrequencyTable(inFile);
            HuffmanCode hc = new HuffmanCode(ft);
            int c;

            // TO DO
            /* Encode the tree */
            hc.export(out);
            
            out.print(HuffmanCode.pad(Integer.toBinaryString(ft.getTotalChars()), 32));
            
            while ( (c = fr.read()) != -1 ) {
                out.print(hc.encode((char)c));
            }

            fr.close();
            out.close();
        } catch (IOException e) {
            System.err.println("Error reading file: " + inFile);
            e.printStackTrace();
        }
    }

    
}