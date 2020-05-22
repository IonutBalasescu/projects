package players;

import assets.Assets;

import java.util.ArrayList;

public class GreedyPlayer extends BasicPlayer {

    private int round;

    public GreedyPlayer() {
        super();
        this.round = 0;
    }

    @Override
    public final void merchantStrategy() {
        (this.round)++;

        ArrayList<Assets> sublist = extractSublist(true);
        int size = sublist.size();
        final int maxSize = 6;
        if (size == 0) {
            super.basicIllegalStrategy();
        } else if (this.round % 2 == 1) {
            super.merchantStrategy();
        } else {
            super.merchantStrategy();
            //in rundele pare adaug si un bun ilegal(daca exista)
            if (this.getNoOfCardsInBag() < maxSize - 1 && size != maxSize) {
                this.basicIllegalStrategy();
            }
        }
    }
    @Override
    public final ArrayList<Assets> sheriffCheckBag(final BasicPlayer b, final ArrayList<Assets> c) {
        //daca nu primeste mita atunci cauta in sac
        if (b.getBribe() == 0) {
            return super.sheriffCheckBag(b, c);
        } else {
            //ia mita de la player si il lasa sa treaca necontrolat
            this.setScore(this.getScore() + b.getBribe());
            b.setScore(b.getScore() - b.getBribe());
            b.setBribe(0);
            return c;
        }
    }
}
