#!ruby
require 'toml-rb'

def load_cards()
  if ARGV.length == 0
    puts "usage: flash_card file ..."
    exit false
  end
  
  cards = []
  ARGV.each do |path|
    begin
      data = TomlRB.load_file(path)
      cards.concat(data['cards'])
    rescue TomlRB::ParseError => e
      puts "#{path}: 不正なTOMLファイルです。" 
      exit false
    rescue Errno::ENOENT => e
      puts "#{path}: ファイルが見つかりませんでした。"
      exit false
    rescue Errno::EACCES => e
      puts "#{path}: ファイルにアクセスできませんでした。"
      exit false
    end
  end
  cards
end

def scan_cards(cards)
  cards.shuffle.each_with_index do |card, i|
    # ディスプレイ全体の消去
    puts "\e[H\e[2J"

    puts "(#{i + 1}/#{cards.length})"
    puts

    puts card['front']
    STDIN.gets
    puts card['back']
    STDIN.gets
  end
end

cards = load_cards()
scan_cards(cards)

