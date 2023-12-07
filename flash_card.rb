#!ruby
require 'toml-rb'

def load_cards()
  if ARGV.length != 1
    puts "usage: flash_card file"
    exit false
  end
  begin
    data = TomlRB.load_file(ARGV[0])
  rescue TomlRB::ParseError => e
    puts '不正なTOMLファイルです。' 
    exit false
  rescue Errno::ENOENT => e
    puts 'ファイルが見つかりませんでした。'
    exit false
  rescue Errno::EACCES => e
    puts 'ファイルにアクセスできませんでした。'
    exit false
  end
  data['cards']
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

