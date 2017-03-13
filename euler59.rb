#!/usr/bin/env ruby

enc_msg = gets.split(',').map(&:to_i)
# enc_msg = gets.each_char.map(&:ord)
# puts "#{enc_msg} #{enc_msg.length}"
# puts "#{enc_msg.map(&:chr).join('')}"
# exit
# puts enc_msg[0...10]

LowerCase = ('a'.ord..'z'.ord)
UpperCase = ('A'.ord..'Z'.ord)
Numbers = ('0'.ord..'9'.ord)
Punctuation = '.,;: !?&()"\''.each_char.map(&:ord)
def valid_charn?(cn)
  # print "valid_charn? #{cn} (#{cn.chr}): "
  # tmp = (LowerCase.include?(cn) or UpperCase.include?(cn) or
  #        Numbers.include?(cn) or Punctuation.include?(cn))
  # # puts "#{tmp}"
  # tmp
  cn >= 32 or cn == 10 # newline
end

def lettercn?(c)
  LowerCase.include?(c) or UpperCase.include?(c)
end

# s = 'Hello, World! How are you today? I hope you\'re having a great time.'
# puts s
# puts s.each_char.map(&:ord).map { |cn|
#   if valid_charn?(cn); then '1' else '0' end }.join('')
# puts s.each_char.map(&:ord).map { |cn|
#   if lettercn?(cn); then '1' else '0' end }.join('')
# exit

def decrypt(enc_msg,key)
  # print "#{key.map(&:chr).join('')} => "
  # puts "#{enc_msg} #{key} #{key.length}"
  tmp = enc_msg.each_slice(key.length).map { |cs|
    # p cs, key
    dec = cs.zip(key).map { |cn,kn| cn ^ kn }
    # print "<<<#{cs} => #{cs.map(&:chr).join('')}>>>"
    # print "(((#{dec} => #{dec.map(&:chr).join('')})))"
    # if not dec.all? { |cn| valid_charn?(cn) }
    #   # puts "<<stop>>"
    #   return nil
    # end
    dec
  }.flatten
  # puts ""
  return tmp
end

# puts "decrypted text:"
# dec_msg = decrypt(enc_msg,'abc'.each_char.map(&:ord))
# if not dec_msg
#   puts "dec_msg is nil"
#   exit
# end
# dec_msg_str = dec_msg.map(&:chr).join('')
# print "#{dec_msg_str}"
# File.open('decrypted.txt','w') do |f|
#   f << dec_msg_str
# end
# exit

letter_ords = ('a'..'z').map(&:ord)
for c1 in letter_ords
  for c2 in letter_ords
    for c3 in letter_ords
      key = [c3,c2,c1]
      dec_msg = decrypt(enc_msg,key)
      # p "dec_msg: #{dec_msg.class}"
      next unless dec_msg
      groups_of_three = dec_msg.map(&:chr).map(&:downcase).each_cons(3).
                        map { |cs| cs.join('') }
      if (groups_of_three.find { |word| word == 'the' } and
          groups_of_three.find { |word| word == 'and' } and
          groups_of_three.find { |word| word == 'of ' })
        # puts "Found `the`, `and`, and `of`."
        puts dec_msg.reduce(&:+)
        # puts dec_msg
        puts dec_msg.map(&:chr).join('')
        exit
      end
    end
  end
end
