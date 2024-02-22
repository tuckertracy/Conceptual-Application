
/**
 * A representation of a MergedTile. A MergeTile is represented by two game
 * piece whoch could be either a base tile or a merged tile.
 */
public class MergeTile implements IGamePiece
{
    IGamePiece piece1;
    IGamePiece piece2;
    
    MergeTile(IGamePiece piece1, IGamePiece piece2) {
        this.piece1 = piece1;
        this.piece2 = piece2;
    }

    /**
     * returns the value of a game piece
     */
    public int getValue() {
        return this.piece1.getValue() + this.piece2.getValue();
    }
    
    /**
     * returns the largest base tile that can be found in the game piece
     */
    public BaseTile biggestBase() {
        return this.piece1.biggestBase().largerOf(this.piece2.biggestBase());
        /*
        BaseTile p1 = this.piece1.biggestBase();
        BaseTile p2 = this.piece2.biggestBase();
        if ( p1.getValue() > p2.getValue() ) {
        return p1;
        } else {
        return p2;
        }
         */
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
        return this.piece1.canMerge(this.piece2);
    }
    
    /**
     * returns the value of the BaseTiles within the MergedTile as a 
     * string and compartmentalizing the values in the format "[(x)|(x)]"
     */
    public String toString() {
        return "[" + this.piece1.toString() + "|" +
        this.piece2.toString() + "]";
    }
    
    /**
     * produces a count of the total number of base tiles that have been 
     * combined into merged tiles
     */
    public int countMergedBases() {
        return this.piece1.countBases() + this.piece2.countBases();
    }

    /**
     * returns the total count of the base tiles
     */
    public int countBases() {
        return this.piece1.countBases() + this.piece2.countBases();
    }
}
