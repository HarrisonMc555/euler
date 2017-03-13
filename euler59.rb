#!/usr/bin/env ruby

enc_msg = gets.split(',').map(&:to_i)
# enc_msg = gets.each_char.map(&:ord)

def valid_charn?(cn)
  cn >= 32 or cn == 10 # newline
end

def decrypt(enc_msg,key)
  enc_msg.each_slice(key.length).map { |cs|
    cs.zip(key).map { |cn,kn| cn ^ kn }
  }.flatten
end

letter_ords = ('a'..'z').map(&:ord)
for c1 in letter_ords
  for c2 in letter_ords
    for c3 in letter_ords
      key = [c3,c2,c1]
      dec_msg = decrypt(enc_msg,key)
      next unless dec_msg
      groups_of_three = dec_msg.map(&:chr).map(&:downcase).each_cons(3).
                        map { |cs| cs.join('') }
      if (groups_of_three.find { |word| word == 'the' } and
          groups_of_three.find { |word| word == 'and' } and
          groups_of_three.find { |word| word == 'of ' })
        puts dec_msg.map(&:chr).join('')
        puts key.map(&:chr).join('')
        puts dec_msg.reduce(&:+)
        exit
      end
    end
  end
end
