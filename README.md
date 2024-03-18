# Sinatra_simple_app

## Installation
```angular2html
$ git clone https://github.com/TakahiroIzuka/Sinatra_simple_app.git
```

## Install gems
```angular2html
$ bundle install
```

## Create database
postgresqlをローカルにダウンロードし、DB (name: mydb) とテーブル (name: my_memos) を作成する。

※ローカルでの環境構築は、windows上のwsl2で確認しました。macをお使いの方は適宜読み替えてください。


postgresqlのインストール
```angular2html
$ sudo apt update
$ sudo apt install postgresql postgresql-contrib
```

postgresqlを起動
```angular2html
$ sudo service postgresql start
```

postgresユーザーでログインし、DBを作成でき、かつロールを管理できるユーザーを作成
```angular2html
$ sudo passwd postgres
$ sudo -u postgres psql
postgres=# create role ＜ユーザー名＞ with login createdb;
```

DB（mydb）を作成し、psqlを終了
```angular2html
postgres=# create db mydb;
postgres=# \q
```

作成したDBを確認し、作成したDBへ接続
```angular2html
$ psql -l
$ psql -U  ＜作成したユーザー名＞ -d mydb;
```

テーブル（my_memos）を作成
```angular2html
mydb=> create table my_memos (id serial, title varchar(255), body text);
```

## Run application
```angular2html
$ bundle exec rerun ruby app.rb
```
