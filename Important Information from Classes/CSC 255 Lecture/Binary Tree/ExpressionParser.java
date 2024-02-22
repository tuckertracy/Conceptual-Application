 

import java.util.*;

public class ExpressionParser
{
  // takes an input from keyboard and produces a resulting assembly language code
  public static void main(String[] args) throws Exception{
    Scanner sc = new Scanner(System.in);
    String[] tokens = sc.nextLine().trim().split(" +");

    BinaryTree<String> result = buildExpTree(tokens);
    System.out.println(result.inOrderString());
    System.out.println(result.preOrderString());
    System.out.println(result.postOrderString());
    System.out.println(result.depthFirstStackString());
    System.out.println(result.breadthFirstStackString());
  }
  
  // produce a parsed expression tree for the given 
  // sequence of tokens (operators, values)
  public static BinaryTree<String> buildExpTree(String[] tokens) {
    Stack<BinaryTree<String>> expStack = new Stack<BinaryTree<String>>();
    Stack<String> opStack = new Stack<String>();

    for (String token : tokens) {
      if (isOperator(token)) {
        while (!(opStack.isEmpty()) && (precedence(token) <= precedence(opStack.peek()))) {
          BinaryTree<String> a = expStack.pop();
          BinaryTree<String> b = expStack.pop();
          String c = opStack.pop();
          BinaryTree<String> comb = new BinaryTree(c, b, a);
          expStack.push(comb);
        }
        opStack.push(token);
      } else {
        expStack.push(new BinaryTree<String>(token));
      }
    }

    while (!(opStack.isEmpty())) {
      BinaryTree<String> a = expStack.pop();
      BinaryTree<String> b = expStack.pop();
      String c = opStack.pop();
      BinaryTree<String> comb = new BinaryTree(c, b, a);
      expStack.push(comb);
    }
    
    return expStack.pop();
  }

  // produces true if input string is equivalent to one of the 4 elementary math symbols
  public static boolean isOperator(String s) {
    return ((s.equals("+")) || 
        (s.equals("*")) ||
        (s.equals("-")) || 
        (s.equals("/")));
  }

  // produces the resulting number of the order of operation
  public static int precedence(String value) {
    if ((value.equals("*")) || (value.equals("/"))) {
      return 2;
    } else {
      return 1;
    }
  }

}

