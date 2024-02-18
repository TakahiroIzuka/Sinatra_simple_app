# frozen_string_literal: true

module MemoHelper
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

  def memo(id)
    memos = []
    File.open('memos.json', 'r') do |file|
      memos = JSON.parse(file.read)
    end
    memos[id.to_i]
  end

  def memos
    init_memos_json unless File.exist?('memos.json')
    read_memos_json
  end
end
