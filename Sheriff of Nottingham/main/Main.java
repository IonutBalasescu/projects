
package main;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.List;;
import java.util.ArrayList;
import assets.Assets;
import players.BasicPlayer;
import players.GreedyPlayer;
import players.BribedPlayer;
import java.util.Collections;
import players.ScoreComparator;


public final class Main {

    private static final class GameInputLoader {
        private final String mInputPath;

        private GameInputLoader(final String path) {
            mInputPath = path;
        }

        public GameInput load() {
            List<Integer> assetsIds = new ArrayList<>();
            List<String> playerOrder = new ArrayList<>();

            try {
                BufferedReader inStream = new BufferedReader(new FileReader(mInputPath));
                String assetIdsLine = inStream.readLine().replaceAll("[\\[\\] ']", "");
                String playerOrderLine = inStream.readLine().replaceAll("[\\[\\] ']", "");

                for (String strAssetId : assetIdsLine.split(",")) {
                    assetsIds.add(Integer.parseInt(strAssetId));
                }

                for (String strPlayer : playerOrderLine.split(",")) {
                    playerOrder.add(strPlayer);
                }
                inStream.close();


            } catch (IOException e) {
                e.printStackTrace();
            }
            return new GameInput(assetsIds, playerOrder);
        }
    }

    public static void main(final String[] args) {
        GameInputLoader gameInputLoader = new GameInputLoader(args[0]);
        GameInput gameInput = gameInputLoader.load();

        List<Integer> list = gameInput.getAssetIds();
        final int noOfCards = 216;
        ArrayList<Assets> cards = new ArrayList<>();
        //creez o lista cu obiecte de tip bunuri/assets dupa id-ul de la input
        for (int i = 0; i < noOfCards; i++) {
            Assets asset = new Assets(list.get(i));
            cards.add(asset);
        }
        List<String> playerNames = gameInput.getPlayerNames();
        ArrayList<BasicPlayer> players = new ArrayList<>();
        //pun intr-o lista obiecte de tip Player(Basic,Greedy sau Bribed)
        for (String name : playerNames) {
            switch (name) {
                case "bribed":
                    BribedPlayer brPlayer = new BribedPlayer();
                    brPlayer.setType("BRIBED");
                    players.add(brPlayer);

                    break;
                case "basic":
                    BasicPlayer bPlayer = new BasicPlayer();
                    bPlayer.setType("BASIC");
                    players.add(bPlayer);

                    break;
                case "greedy":
                    GreedyPlayer gPlayer =  new GreedyPlayer();
                    gPlayer.setType("GREEDY");
                    players.add(gPlayer);
                default:
                    break;
            }
        }

        int noOfPlayers = players.size();
        //numarul de runde este egal cu 2*nrOfPlayers
        for (int i = 0; i < noOfPlayers * 2; i++) {
            //decid cine este serif cu round%nrOfPlayers
            // si setez campul SheriffStatus la true
            BasicPlayer uPlayer = players.get(i % noOfPlayers);
            uPlayer.setSheriffStatus(true);
            for (BasicPlayer player : players) {
                    //"impart cartile"
                    cards = player.fillHandCards(cards);
                    if (!player.getSheriffStatus()) {
                        //aplic strategia in functie de tipul jucatorului
                        player.merchantStrategy();
                        //seriful verifica punga
                        //va returna noul pachetul de carti(daca prinde pe cineva)
                        cards = uPlayer.sheriffCheckBag(player, cards);
                        //pun bunurile pe taraba
                        player.fillMerchantTable();
                    }
            }
            //seriful si-a terminat runda
            uPlayer.setSheriffStatus(false);
        }
        //id-uri specifice de bunuri
        final int noOfBonuses = 4;
        final int appleId = 0, cheeseId = 1, breadId = 2, chickenId = 3;
        final int[] ids = {appleId, cheeseId, breadId, chickenId};
        int[][] frequency = new int[noOfPlayers][noOfBonuses];
        //creez cu o metoda din BasicPlayer vectori de frecventa pentru bunuri
        //pentru fiecare jucator si le bag intr-o matrice frequency(vector de vectori)
        for (int i = 0; i < noOfPlayers; i++) {
            BasicPlayer player = players.get(i);
            frequency[i] = player.getLegalFrequency(ids);
        }
        //dau banii pe obiectele de pe taraba
        for (BasicPlayer player : players) {
            player.sellAssets();
        }
        int kingBonus = 1;
        int queenBonus = 0;
        //caut frecventa maxima a unui bun si dau bonus king/queen
        //playerului respectiv, dupa cazurile mentionate in enunt
          for (int i = 0; i < noOfBonuses; i++) {
              int king = 0;
              int queen = -1;
              //caut king
              for (int j = 0; j < noOfPlayers; j++) {
                  if (frequency[j][i] > king) {
                      king = frequency[j][i];
                  }
              }
              //caut queen
              for (int j = 0; j < noOfPlayers; j++) {
                  if (frequency[j][i] != king && frequency[j][i] > queen) {
                      queen = frequency[j][i];
                  }
              }
              //dau bonusuri dupa caz
              for (int j = 0; j < noOfPlayers; j++) {
                  if (frequency[j][i] == king) {
                      players.get(j).setBonus(kingBonus, i);
                  } else if (frequency[j][i] == queen) {
                      players.get(j).setBonus(queenBonus, i);
                  }
              }
          }
          //sortez lista de jucatori descrescator dupa scor
         //vezi clasa ScoreComparator
        ScoreComparator comparator = new ScoreComparator();
        Collections.sort(players, comparator);
        //afisez
        for (BasicPlayer p : players) {
            System.out.println(p.getType() + ": " + p.getScore());
        }

    }
}
