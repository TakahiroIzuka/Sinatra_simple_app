# frozen_string_literal: true

require 'sinatra'
require 'json'

helpers do
  def read_memos_json
    File.open('memos.json', 'r') do |file|
      JSON.parse(file.read)
    end
  end

  def init_memos_json
    File.open('memos.json', 'w') do |file|
      JSON.dump([], file)
    end
  end

  def write_memos_json(memos)
    File.open('memos.json', 'w') do |file|
      JSON.dump(memos, file)
    end
  end

  def get_memo(id)
    memos = []
    File.open('memos.json', 'r') do |file|
      memos = JSON.parse(file.read)
    end
    memos[id.to_i]
  end

  def get_memos
    memos = []
    if File.exist?('memos.json')
      memos = read_memos_json
    else
      init_memos_json
    end

    memos
  end
end

get '/' do
  @memos = get_memos
  erb :index
end

get '/memos/new' do
  erb :create_memo
end

get '/memos/*/edit' do |id|
  @memo = get_memo(id)
  @id = id.to_i
  p @id
  erb :edit_memo
end

get '/memos/*' do |id|
  @memo = get_memo(id)
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
