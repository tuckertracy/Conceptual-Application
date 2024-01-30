import java.io.*;

// builds a huffman tree from a frequency table to
// allow encoding/decoding characters
public class HuffmanCode {

    private Node tree;
    private String[] code; 
    /* code[ch] is the binary code for ASCII character ch, for example, 
    code['a'] might be "0011" to represent a particular encoding */

    /**
     * Uses the given frequency table to build a Huffman encoding tree,
     * and then traverses it to collect a table of encodings for the characters
     * in the tree
     */
    public HuffmanCode(FrequencyTable ft) {
        tree = buildTree(ft);
        code = new String[256];
        buildCode(tree, "");
    }

    /**
     * Looks up and returns the variable-length binary encoding
     * for the given character, c
     */
    public String encode(char c) {
        return code[c];
    }

    /* HELPER METHODS ----------------------------------------- */
    /** Traverses the tree rooted at 'cur' and adds all leaf nodes
    that are found to the 'code[]' array with their binary encoding.
    The 'path' is an accumulator that keeps track of the explored
    path of left/right branches via "0" and "1"s.
     */
    private void buildCode(Node cur, String path) {
        if (cur.isLeaf()) {
            code[cur.ch] = path;
        } else {
            buildCode( cur.left, path + "0" );
            buildCode( cur.right, path + "1" );
        }        
    }

    // builds a huffman tree from the given character frequency data
    private Node buildTree(FrequencyTable ft) {
        // TODO ************************************************************

        /* ALGORITHM:
        Create a MinPQ.
        Add single node trees to the pq for all characters that occur
        at least once in the frequency table
        (the weight of each Node is the frequency)
        While the pq has more than 1 tree in it:
        Remove the next two trees from the pq
        Create a new Node with those two as left/right and a 
        combined frequency weight
        Insert the new node back into the pq

        Return the 1 remaining tree
         */
        MinPQ<Node> pq = new MinPQ<Node>();
        for (char c = 0 ; c < 256 ; c++) {
            if (ft.freqOf(c) >= 1) {
                pq.insert(new Node(c,ft.freqOf(c), null, null));
            }
        }

        while (pq.size() > 1) {
            Node firstTree = pq.delMin();
            Node secondTree = pq.delMin();
            Node newNode = new Node('?', firstTree.freq + secondTree.freq, 
                    firstTree, secondTree);
            pq.insert(newNode);
        }

        return pq.delMin();
    }
    
    public void export(PrintWriter out) {
        export(this.tree,out);
    }
    
    private static void export(Node cur, PrintWriter out) {
        if(cur.isLeaf()){
                out.print(1);
                out.print(pad(Integer.toBinaryString(cur.ch), 8));
            } else {
                out.print(0);
                export(cur.left, out);
                export(cur.right, out);
            }
    }
    
    public static String pad(String s, int c) {
        int length = s.length();
        String result = "";
        for (int i = 0 ; i < c - length ; i++) {
            result += "0";
        }
        return result + s;
    }
}