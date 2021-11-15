---
title: "GoEmotionsのデモを動かす"
date: 2021-11-15T23:48:20+09:00
tags: ['Docker', '感情分類']
series: ['GoEmotions']
categories: ['やってみた']
toc: true
draft: false
---
## やったこと

[GoEmotions: A Dataset of Fine-Grained Emotions](https://arxiv.org/abs/2005.00547)の[リポジトリ](https://github.com/google-research/google-research/tree/master/goemotions)を見に行ったら遊べそうだったのでコードが動くまでのセットアップをする

## できたもの

バージョン合わせるのが大変なのでForkしてDockerfileとdocker-compose.yamlを用意した
https://github.com/sh05/google-research/tree/master/goemotions

### 動かし方

まずClone
{{< cmd >}}
git clone git@github.com:sh05/google-research.git
{{< /cmd >}}

データダウンロード
{{< cmd >}}
cd goemotions
wget -P data/full_dataset/ https://storage.googleapis.com/gresearch/goemotions/data/full_dataset/goemotions_1.csv
wget -P data/full_dataset/ https://storage.googleapis.com/gresearch/goemotions/data/full_dataset/goemotions_2.csv
wget -P data/full_dataset/ https://storage.googleapis.com/gresearch/goemotions/data/full_dataset/goemotions_3.csv
{{< /cmd >}}

ビルドして実行
{{< cmd >}}
cd ..
docker-compose build
docker-compose --rm run go_emotions python -m analyze_data # とか
{{< /cmd >}}

## 内容

### python3.9では動かない😭

1. bertはtf2.0ではうごきません
2. tf1.xはpython3.9にははいりません


選択肢はpyenvかDockerが思い浮かんだのでDockerでやる

### Docker用のrun.shを作る

run.shからvirtualenv関係の行を消す

```
[sh05@sh05MBP][/Users/sh05/Study/Forked/google-research][21-11-16 0:04][master]
->diff goemotions/run.sh goemotions/docker-run.sh
33,34d32
< virtualenv -p python3 .
< source ./bin/activate
```

### Dockerfileを作る

[pip install tensorflow==1.x がエラーになるとき](https://qiita.com/shoheihagiwara/items/5a3a4dac29b26836f185)によると，tf1にはpython3.7がいいらしいので

```Dockerfile
FROM python:3.7

WORKDIR /goemotions
ADD ./docker-run.sh /goemotions
ADD ./requirements.txt /goemotions

WORKDIR /
RUN goemotions/docker-run.sh
```

### docker-compose.yamlを作る

ファイルごとDocker Imageに固めるより実行環境としてコンテナを扱ってスクリプトなどをマウントするほうが好き

```yaml
version: "3.3"
services:
  go_emotions:
    build: goemotions
    volumes:
      - ./goemotions/:/goemotions
    working_dir: /goemotions
```
あとは[これ](/2021/11/15/goemotionsのデモを動かす/#動かし方)の通りに動かす

## ぶっちゃけ

[Colabのノート](https://github.com/tensorflow/models/blob/master/research/seq_flow_lite/demo/colab/emotion_colab.ipynb)が用意されているのでこれでいい
