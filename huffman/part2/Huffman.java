import java.io.IOException;
import java.io.*;

public class Huffman {

    public static void main(String[] args) throws IOException {

        //FrequencyTable ft = new FrequencyTable("short.txt");
        //HuffmanCode hc = new HuffmanCode(ft);
        /*for (char ch = 0; ch < 256; ch++) {
        if (ft.freqOf(ch) > 0) {
        System.out.println( ch + ": " + ft.freqOf(ch) );
        System.out.println( ch + ": " + hc.encode(ch) );
        }
        }*/
        compress("short.txt", "short.comp.txt");
        decompress("short.comp.txt", "short.exp.txt");

    }

    public static void compress(String inFile, String outFile) {
        try {
            FileReader fr = new FileReader(inFile);
            PrintWriter out = new PrintWriter(outFile);
            FrequencyTable ft = new FrequencyTable(inFile);
            HuffmanCode hc = new HuffmanCode(ft);
            int c;

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

    public static void decompress(String inFile, String outFile)throws IOException {
        FileReader fr = new FileReader(inFile);
        PrintWriter out = new PrintWriter(outFile);
        HuffmanCode hc = new HuffmanCode(fr);
        int c;

        // read next 32 characters and convert to int
        String s = "";
        for (int i = 0 ; i < 32 ; i++) {
            int f = fr.read();
            char ch = (char) f;
            s += ch;
        }
        int h = Integer.parseInt(s, 2);

        // make for-loop that goes n times
        // call decodeNext on each iteration of for-loop 
        // i.e. for (i<n) {ch=decodeNext(fr)}
        for (int i = 0 ; i < h ; i++ ) {
            out.print(hc.decodeNext(fr));
        }
        out.close();
    }
}   