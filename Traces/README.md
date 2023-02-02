## Trace description

* This folder contains the trace pairs (wifi and cellular link data at the same time and space) collected in Stony Brook University (SBU), in New York. 
* The trace file name format is pathID_trial_network.csv
* Each trace file has a CSV format timeInSeconds,ByesPerSecond where timeInSeconds is the range of [1:100]
* Explanation for pathIDs
  * path 7: SBU walk SAC side door to the bus stop (WiFi should get weaker)
  * path 8: SBU library walk from Central Reading Room to outside by the side door towards Stellar center (WiFi should get weaker)
  * path 11: SBU East side Dining Hall indoor walk from Pizza V. to Tool Rd Deli (WiFi can vary or not)
  * path 12: SBU outdoor bench across Psych A bldg to indoors library right outside central reading room (WiFi should get stronger)
  * path 13: walk starting at SBU music building outdoor right across the art building to inside the first floor of music building, make right to go down stairs to the basement of music building (cellular should get weaker)

![SBUPathsAnnotated](https://user-images.githubusercontent.com/2316553/211053414-047d7cc5-26df-4487-837f-bc40b30e6904.png)

## Trace visualization and statistics

![image](https://user-images.githubusercontent.com/2316553/211050968-094fadfd-cad8-472e-b58e-cb1fae98cda1.png)

A Python notebook with summary statistics of each trace pair is available at the following link: https://colab.research.google.com/drive/14-OClGxWto5T_hfrjxkzlxvn1PXcTFNL
