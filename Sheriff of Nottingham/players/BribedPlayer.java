package players;

import assets.Assets;


import java.util.ArrayList;


public class BribedPlayer extends BasicPlayer {

    @Override
    public final void merchantStrategy() {
        final boolean legal = false;
        final int maxOfCardsInBag = 5;
        final int smallBribe = 5, bigBribe = 10;
        final int extendsBribe = 2; //valoarea de la care creste mita
        //extrag elementele ilegale
        ArrayList<Assets> sublist = super.extractSublist(legal);

        int size = sublist.size();
        //daca nu am sau nu imi ajung banii merg pe cazul de baza
        if (size == 0 || this.getScore() < smallBribe) {
            super.merchantStrategy();
        } else {
            int k = 0; //cate bunuri adauga in sac
            while (k < maxOfCardsInBag && sublist.size() > 0) {
                if (k > extendsBribe && this.getScore() < bigBribe) {
                    this.basicLegalStrategy(this.getHandCards());
                    break;
                }
                int maxProfit = 0;
                int idxMaxProfit = -1;
                for (int i = 0; i < sublist.size(); i++) {
                    if (maxProfit < sublist.get(i).getProfit()) {
                        maxProfit = sublist.get(i).getProfit();
                        idxMaxProfit = i;

                    }
                }
                this.addCardsToBag(sublist.get(idxMaxProfit));
                for (int i = 0; i < this.getNoOfCards(); i++) {
                    if (this.getHandCards().get(i).getId() == sublist.get(idxMaxProfit).getId()) {
                        this.removeCardsFromHand(i);
                        i--;
                    }
                }
                sublist.remove(idxMaxProfit);
                k++;
            }

            if (k > extendsBribe) {
                //peste 2 bunuri ilegale in sac cresc mita
                this.setBribe(bigBribe);
            } else {
                this.setBribe(smallBribe);
            }
            int appleId = 0;
            //declar mere
            Assets falseStatement = new Assets(appleId);
            this.setStatement(falseStatement);
        }
    }
    @Override
    public final ArrayList<Assets> sheriffCheckBag(final BasicPlayer b, final ArrayList<Assets> c) {
        //sheriffBasic == sheriffBribed
        return super.sheriffCheckBag(b, c);
    }
}

