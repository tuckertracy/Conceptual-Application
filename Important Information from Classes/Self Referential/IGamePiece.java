
/**
 * Interface that is implemented by BaseTile and MergeTile
 */
public interface IGamePiece
{
    public int getValue();

    public BaseTile biggestBase();

    public boolean canMerge(IGamePiece that);

    public boolean isValid();

    public String toString();

    public int countMergedBases();

    public int countBases();
}
