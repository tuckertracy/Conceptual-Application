
/**
 * Represents function objects that have been abstracted for 
 * a generic operation
 */
public interface IPred<A> {
  public boolean satisfiedBy(A obj);
}
