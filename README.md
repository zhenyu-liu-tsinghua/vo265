# vo265

## Introduction

I developed HEVC software encoder, i.e., VO265. As compared with x265 (-preset placebo), the coding performance improvement in terms of BDBR=-40.39% was achieved. The Linux executable codes and the associated verification environment are provided.

## Usage

sh run_all.sh sequence_classical_crf_file.txt

| class | Sequence        | BDBR(%) |
|-------|-----------------|---------|
| A     | PeopleOnStreet  | -30.50  |
| A     | Traffic         | -41.20  |
| B     | BasketballDrive | -31.99  |
| B     | BQTerrace       | -50.28  |
| B     | Cactus          | -40.01  |
