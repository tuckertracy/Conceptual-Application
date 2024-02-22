
import java.util.*;
public class BinaryTree<T> {
    // an internal class for binary tree nodes
    private class Node { 
        T data;
        Node left, right;

        public Node(T data, Node left, Node right) {
            this.data = data;
            this.left = left;
            this.right = right;
        }
    }  

    private Node root;

    public BinaryTree() {
        root = null;
    }

    public BinaryTree(T data) {
        root = new Node(data, null, null);
    }

    public BinaryTree(T data, BinaryTree<T> left, BinaryTree<T> right) {
        root = new Node(data, left.root, right.root);
    }

    public String inOrderString() {
        return inOrderString(root);
    }

    public String preOrderString() {
        return preOrderString(root);
    }

    public String postOrderString() {
        return postOrderString(root);
    }

    public String depthFirstStackString() {
        Stack<Node> st = new Stack<Node>();
        String result = "";
        st.push(root);

        while ( !st.isEmpty() ) {
            Node cur = st.pop();
            result += cur.data.toString() + " ";
            if ( cur.right != null ){st.push(cur.right);}
            if ( cur.left != null ) {st.push(cur.left);}
        }
        return result.strip();
    }

    public String breadthFirstStackString() {
        Queue<Node> qu = new ArrayDeque<Node>();
        String result = "";
        qu.add(root);
        while ( !qu.isEmpty() ) {
            Node cur = qu.remove();
            result += cur.data.toString() + " ";
            if ( cur.left != null ){qu.add(cur.left);}
            if ( cur.right != null ) {qu.add(cur.right);}
        }
        return result.strip();
    }

    public int maxDepth() {
        /*int depth = 0;
        Node cur = root;
        if ( cur == null || isLeaf(cur) ) {
        return 0;
        } 

        if ( maxDepth( cur.left ) > maxDepth( cur.right ) ) 
        {return maxDepth( cur.left ) + 1; } 
        else { return maxDepth( cur.right ) + 1; }*/
        if ( root == null || isLeaf(root) ) {
            return 0;
        }
        int ldepth = maxDepth(root.left);
        int rdepth = maxDepth(root.right);

        if ( ldepth > rdepth ) 
        {return ldepth + 1; } 
        else { return rdepth + 1; }
    }

    private int maxDepth(Node cur) {
        if ( cur == null || isLeaf(cur) ) {
            return 0;
        }
        int ldepth = maxDepth(cur.left);
        int rdepth = maxDepth(cur.right);

        if ( ldepth > rdepth ) 
        {return ldepth + 1; } 
        else { return rdepth + 1; }
    }

    // helper methods

    // is the given node a leaf? (i.e. no children) 
    private boolean isLeaf(Node cur) {
        return cur.left == null && cur.right == null;
    }

    private String inOrderString(Node cur) {
        String result = "";
        if (cur == null) { return result; }

        if (!isLeaf(cur)) { result += "("; }
        result += inOrderString(cur.left).trim();
        result += " " + cur.data.toString() + " ";
        result += inOrderString(cur.right).trim();
        if (!isLeaf(cur)) {  result += ")"; }
        return result;
    }

    private String preOrderString(Node cur) {
        String result = "";
        if (cur == null) { return result; }

        if (!isLeaf(cur)) { result += "("; }
        result += cur.data.toString() + " ";
        result += preOrderString(cur.left).trim() + " ";
        result += preOrderString(cur.right).trim();
        if (!isLeaf(cur)) {  result += ")"; }
        return result;
    }

    private String postOrderString(Node cur) {
        String result = "";
        if (cur == null) { return result; }

        result += postOrderString(cur.left).trim() + " ";
        result += postOrderString(cur.right).trim() + " ";
        result += cur.data.toString();

        return result;
    }

}