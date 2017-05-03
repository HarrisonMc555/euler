#!/usr/bin/env ruby

N = gets.to_i
enc_msg = gets.split(' ').map(&:to_i)
# enc_msg = gets.each_char.map(&:ord)

$common_symbols = ";:,.'?-!()\"".each_char.map(&:ord)
def valid_charn?(cn)
    return true if cn == 32 # space
    return true if 97 <= cn and cn <= 122 # 'a'..'z'
    return true if 65 <= cn and cn <= 90  # 'A'..'Z'
    return true if 48 <= cn and cn <= 57  # '0'..'9'
    return true if cn == 10 # newline
    return true if cn == 40 or cn == 41 # brackets
    return true if $common_symbols.include? cn # ;:,.'?-!
    puts "invalid character: #{cn.chr} (#{cn})"
    return false
end

def decrypt(enc_msg,key)
    enc_msg.each_slice(key.length).map { |cs|
        cs.zip(key).map { |cn,kn| cn ^ kn }
    }.flatten
end

# s = "Cats have 9 lives, everybody knows that.".each_char.map(&:ord)
# puts s.length
# puts decrypt(s, "abc".each_char.map(&:ord)).map(&:to_s).join(' ')
# exit

def score_freq(cs)
    " eta".each_char.map { |c| cs.index(c) || 9999 }.reduce(&:+)
end

tmp = {}
key_score_h = {}
letter_ords = ('a'..'z').map(&:ord)
for c1 in letter_ords
    for c2 in letter_ords
        for c3 in letter_ords
            key = [c3,c2,c1]
            dec_msg = decrypt(enc_msg,key)
            next unless dec_msg
            key_str = key.map(&:chr).join('')
            puts "key: #{key_str}"
            next unless dec_msg.all? { |cn| valid_charn? cn }
            dec_msg_str = dec_msg.map(&:chr).map(&:downcase).join('')
            puts "valid key: #{key_str}"
            #puts "\tmsg: #{dec_msg_str}"
            #groups_of_three = dec_msg_str.each_char.each_cons(3).map { |cs| cs.join('') }
            #puts "\tgroups of three: #{groups_of_three.to_a}"
            #next unless groups_of_three.find { |cs| cs == 'the' }
            #puts "\tContains 'the'"
            freqs = dec_msg_str.each_char.inject(Hash.new(0)) { |h,c| h[c]+=1; h }.sort_by { |k,v| v }.reverse
            cs = freqs.map { |c,v| c }
            key_score_h[key_str] = score_freq(cs) - dec_msg_str.split(' ').count
            tmp[key_str] = freqs
            next
            #puts "\tfreqs: #{freqs}"
            top10 = freqs[0...10]
            top10chars = top10.map { |c,freq| c }
            next unless top10chars.include? ' '
            next unless top10chars.include? 'e'
            #next unless top10chars.include? 't'
            #puts "\tMost common character is space"
            puts key_str
            exit
        end
    end
end

best = key_score_h.min_by { |c,v| v }
if best
    puts key_score_h
    p tmp
    p tmp[best[0]]
    puts decrypt(enc_msg,best[0].each_char.map(&:ord)).map(&:chr).join('')
    puts decrypt(enc_msg,"abc".each_char.map(&:ord)).map(&:chr).join('')
    puts best[0]
else
    #puts asdf # trying to raise exception
    puts "No good key found"
end
