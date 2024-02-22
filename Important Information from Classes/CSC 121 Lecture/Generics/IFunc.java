
/**
 * Represents function objects that have been abstracted for 
 * a generic operation
 */
interface IFunc<T,R> {
       public R apply(T data);
   }
