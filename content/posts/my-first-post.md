---
title: "個人サイト作った"
date: 2021-10-28T23:28:00+09:00
draft: false
tags: ['Hugo', 'GitHub Pages', 'シェルスクリプト']
series: ['リッチなブログを作る']
categories: ['つくった']
toc: true
draft: false
---

## Hugoで個人サイト作った

このサイト https://www.sh05.dev  
リポジトリ https://github.com/sh05/myblog

## カスタマイズしたこと

- 複数セクション
- 複数taxonomy
- テンプレート修正
- コマンドで作業ログを残せるようにした https://github.com/sh05/myblog/blob/main/commit_work_log.sh

## Todo

- GitHub Actionsでビルドする(`hugo`コマンドだけだけど)
- 作業ログをコマンドでできるようにしたのを記事にする
- 一覧のインクリメンタルサーチとページネーションが衝突したので考える（今はサーチを優先）
