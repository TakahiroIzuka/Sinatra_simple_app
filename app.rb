# frozen_string_literal: true

require 'sinatra'
require 'json'

get '/' do
  if File.exist?('memos.json')
    File.open('memos.json', 'r') do |file|
      @json = JSON.parse(file.read)
    end
  else
    File.open('memos.json', 'w') do |file|
      JSON.dump([], file)
    end
  end

  @memos = @json || []
  erb :index
end

get '/create' do
  erb :create_memo
end

get '/edit/*' do |index|
  File.open('memos.json', 'r') do |file|
    @memos = JSON.parse(file.read)
  end
  @memo = @memos[index.to_i]
  @index = index.to_i
  erb :edit_memo
end

get '/show/*' do |index|
  File.open('memos.json', 'r') do |file|
    @memos = JSON.parse(file.read)
  end
  @memo = @memos[index.to_i]
  @index = index.to_i
  erb :memo_detail
end

post '/memos' do
  @memos = []
  File.open('memos.json', 'r') do |file|
    memo = JSON.parse(file.read)
    @memos << memo unless memo.nil?
  end
  params[:title] = 'サンプルタイトル' if params[:title].empty?
  params[:body] = 'サンプルの内容' if params[:body].empty?
  @memos.unshift({ title: params[:title], body: params[:body] })
  @memos = @memos.flatten
  File.open('memos.json', 'w') do |file|
    JSON.dump(@memos, file)
  end
  redirect to('/')
end

patch '/memo/*' do |index|
  File.open('memos.json', 'r') do |file|
    @memos = JSON.parse(file.read)
  end
  @memos[index.to_i] = { title: params[:title], body: params[:body] }
  File.open('memos.json', 'w') do |file|
    JSON.dump(@memos, file)
  end
  redirect to('/')
end

delete '/memo/*' do |index|
  File.open('memos.json', 'r') do |file|
    @memos = JSON.parse(file.read)
  end
  @memos.delete_at(index.to_i)
  File.open('memos.json', 'w') do |file|
    JSON.dump(@memos, file)
  end
  redirect to('/')
end
