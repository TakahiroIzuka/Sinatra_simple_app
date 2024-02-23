# frozen_string_literal: true

require 'sinatra'
require 'json'
require './helpers/helpers'

helpers MemoHelper

get '/' do
  @memos = memos
  erb :index
end

get '/memos/new' do
  erb :create_memo
end

get '/memos/*/edit' do |id|
  @memo = memo(id)
  @id = id.to_i
  p @id
  erb :edit_memo
end

get '/memos/*' do |id|
  @memo = memo(id)
  @id = id.to_i
  erb :memo_detail
end

post '/memos' do
  @memos = read_memos_json
  params[:title] = 'サンプルタイトル' if params[:title].empty?
  params[:body] = 'サンプルの内容' if params[:body].empty?
  @memos.unshift({ title: params[:title], body: params[:body] })
  @memos = @memos.flatten
  write_memos_json(@memos)
  redirect to('/')
end

patch '/memos/*' do |id|
  @memos = read_memos_json
  @memos[id.to_i] = { title: params[:title], body: params[:body] }
  write_memos_json(@memos)
  redirect to('/')
end

delete '/memos/*' do |id|
  @memos = read_memos_json
  @memos.delete_at(id.to_i)
  write_memos_json(@memos)
  redirect to('/')
end
