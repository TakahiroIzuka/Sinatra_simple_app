# frozen_string_literal: true

require 'sinatra'
require './helpers/helpers'

helpers MemoHelper

get '/' do
  @memos = all_memos
  erb :index
end

get '/memos/new' do
  erb :create_memo
end

get '/memos/*/edit' do |id|
  @memo = find_memo(id)
  erb :edit_memo
end

get '/memos/*' do |id|
  @memo = find_memo(id)
  erb :memo_detail
end

post '/memos' do
  create_memo(params)
  redirect to('/')
end

patch '/memos/*' do |id|
  update_memo(params, id)
  redirect to('/')
end

delete '/memos/*' do |id|
  delete_memo(id)
  redirect to('/')
end
