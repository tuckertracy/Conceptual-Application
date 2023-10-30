// a node in the Huffman tree
public class Node implements Comparable<Node> {
	char ch;
	int freq;
	Node left, right;
	
	public Node(char ch, int freq, Node left, Node right) {
		this.ch = ch;
		this.freq = freq;
		this.left = left;
		this.right = right;
	}
	
	public boolean isLeaf() {
		return this.left == null && this.right == null;
	}
	
	// produce <0 if 'this' tree's frequency is less than 'that's
	//         >0 if this is greater than that's
	//         0 if they are the same frequency
	public int compareTo(Node that) {
		return this.freq - that.freq;
	}
}