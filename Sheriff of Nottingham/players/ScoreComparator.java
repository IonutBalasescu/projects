
package players;

import java.util.Comparator;

public class ScoreComparator implements Comparator<BasicPlayer> {

    @Override
    public final int compare(final BasicPlayer p1, final BasicPlayer p2) {
        return p2.getScore() - p1.getScore();
    }
}
