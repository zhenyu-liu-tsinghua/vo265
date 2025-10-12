# vo265

## Introduction

I developed HEVC software encoder, i.e., VO265. As compared with x265 (-preset placebo), the coding performance improvement in terms of BDBR=-40.39% was achieved. The Linux executable codes and the associated verification environment are provided.

## Usage

sh run_all.sh sequence_classical_crf_file.txt

## Performance

| class | Sequence            | BDBR(%) |
|-------|---------------------|---------|
| A     | PeopleOnStreet      | -30.50  |
| A     | Traffic             | -41.20  |
| B     | BasketballDrive     | -31.99  |
| B     | BQTerrace           | -50.28  |
| B     | Cactus              | -40.01  |
| B     | Kimono              | -21.64  |
| B     | ParkScene           | -35.7   |
| C     | BasketballDrill     | -62.56  |
| C     | BQMall              | -41.79  |
| C     | FlowervaseC         | -24.1   |
| C     | PartyScene          | -52.02  |
| C     | RacehorsesC         | -17.41  |
| D     | BasketballPass      | -34.59  |
| D     | BlowingBubbles      | -42.77  |
| D     | BQSquare            | -60.89  |
| D     | Flowervase          | -31.68  |
| D     | Racehorses          | -23.30  |
| E     | FourPeople          | -49.06  |
| E     | Johnny              | -47.05  |
| E     | KristenAndSara      | -41.92  |
| F     | SlideEditing        | -46.69  |
| F     | SlideShow           | -35.94  |
| F     | ChinaSpeed          | -26.12  |
| F     | BasketballDrillText | -63.81  |
