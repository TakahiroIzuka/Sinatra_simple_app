# frozen_string_literal: true

require 'pg'

module MemoHelper
  def all_memos
    connection.exec('SELECT * FROM my_memos')
  end

  def find_memo(id)
    memos = connection.exec('SELECT * FROM my_memos where id = $1 limit 1', [id])
    memos.first
  end

  def create_memo(params)
    title = params[:title] || 'サンプルタイトル'
    body =  params[:body] || 'サンプルの内容'
    connection.exec_params('INSERT INTO my_memos (title, body) VALUES ($1, $2)', [title, body])
  end

  def update_memo(params, id)
    connection.exec_params('UPDATE my_memos SET title = ($1), body = ($2) WHERE id=($3)', [params[:title], params[:body], id])
  end

  def delete_memo(id)
    connection.exec_params('DELETE FROM my_memos WHERE id = $1', [id])
  end

  private

  def connection
    @connection ||= PG.connect(dbname: 'mydb')
  end
end
