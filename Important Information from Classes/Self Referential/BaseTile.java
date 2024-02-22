
/**
 * A representation of a BaseTile. A BaseTile is represented by a value.
 */
public class BaseTile implements IGamePiece
{
    int value;
    
    BaseTile() {
        new BaseTile(this.value = 2);
    }
    
    BaseTile(int value) {
        this.value = value;
    }
    
    /**
     * returns the value of a game piece
     */
    public int getValue() {
        return this.value;
    }
    
    /**
     * returns the largest base tile that can be found in the game piece
     */
    public BaseTile biggestBase() {
        return this;
    }
    
    /**
     * detrmines whether the value of 'this' is greater than 'that'
     */
    public BaseTile largerOf(BaseTile that) {
        if ( this.getValue() > that.getValue() ) {
            return this;
        } else {
            return that;
        } 
    }
    
    /**
     * determines whether 'this' game piece can be merged with
     * the given game piece to form a merged piece
     */
    public boolean canMerge(IGamePiece that) {
        return this.getValue() == that.getValue();
    }
    
    /**
     * checks whether this game piece was constructed according to 
     * the rules of 2048
     */
    public boolean isValid() {
        return true;
    }
    
    /**
     * returns the value of the BaseTile as a string in parantheses
     */
    public String toString() {
        return "(" + this.value + ")";
    }
    
    /**
     * produces a count of the total number of base tiles that have been 
     * combined into merged tiles
     */
    public int countMergedBases() {
        return 0;
    }
    
    /**
     * returns the total count of the base tiles
     */
    public int countBases() {
        return 1;
    }
}
