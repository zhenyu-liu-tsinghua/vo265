# vo265

## Introduction

I developed HEVC software encoder, i.e., VO265. As compared with x265 (-preset placebo), the coding performance improvement in terms of BDBR=-40.39% was achieved. The Linux executable codes and the associated verification environment are provided.

## Usage

sh run_all.sh sequence_classical_crf_file.txt

## Performance

| class | Sequence        | BDBR(%) |
|-------|-----------------|---------|
| A     | PeopleOnStreet  | -30.50  |
| A     | Traffic         | -41.20  |
| B     | BasketballDrive | -31.99  |
| B     | BQTerrace       | -50.28  |
| B     | Cactus          | -40.01  |
| B     | Kimono          | -21.64  |
| B     | ParkScene       | -35.7   |
| C     | BasketballDrill | -62.56  |
| C     | BQMall          | -41.79  |
| C     | FlowervaseC     | -24.1   |
| C     | PartyScene      | -52.02  |
| C     | RacehorsesC     | -17.41  |
| D     | BasketballPass  | -34.59  |
| D     | BlowingBubbles  | -42.77  |
