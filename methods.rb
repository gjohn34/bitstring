def convert_to_bitstring(element, string = false)
  copy_of_element = element
  converted_array = []
  if string == true
    copy_of_element = copy_of_element.bytes
    copy_of_element = copy_of_element[0]
  end
  until copy_of_element < 2
    converted_array.push(copy_of_element % 2)
    copy_of_element /= 2
  end
  converted_array.push(copy_of_element)
  return converted_array.reverse.join
end

def get_final_bitstring(bitstring1, bitstring2)
  bitstring1_split = bitstring1.split('')
  bitstring2_split = bitstring2.split('')
  final_bitstring = []
  if bitstring1_split.length < bitstring2_split.length
    until bitstring1_split.length == bitstring2_split.length do
      bitstring1_split.insert(0, "0")
    end
  elsif bitstring1_split.length > bitstring2_split.length
    until bitstring1_split.length == bitstring2_split.length do
      bitstring2_split.insert(0, "0")
    end
  end
  index = 0
  for element in bitstring1_split
    ((bitstring1_split[index] == "1" || bitstring2_split[index] == "1") && (bitstring1_split[index] != bitstring2_split[index])) ? final_bitstring.push(1) : final_bitstring.push(0)
    index += 1
  end
  return final_bitstring.join
end

def convert_to_decimal(binary)
  index = 0
  final_bitstring = binary.reverse.split('').map! { |e| e.to_i }
  for element in final_bitstring
    final_bitstring[index] = element  * (2**index)
    index +=1
  end
  return sum = final_bitstring.reduce(:+)
end

def get_ascii_array(cyphertext, key)
  ascii_word = []
  index = 0
  for element in cyphertext
    ascii_word.push(get_final_bitstring(cyphertext[index], key[index]))
    index += 1
  end
  return ascii_word
end

def mass_con_dec(ascii_word)
  index = 0
  for element in ascii_word
    ascii_word[index] = convert_to_decimal(element)
    index += 1
  end
end

def bin_to_ascii(cyphertext, key)
  ascii = mass_con_dec(get_ascii_array(cyphertext, key))
  ascii.map! { |e| e.chr }
  return ascii.join
end

def get_cyphertext
  puts "Cyphertext, base10 only, separated by spaces:"
  cyphertext = gets.chomp.split(' ').map { |e| e.to_i }
  # cyphertext = "27 14 4 18 21 26 28 3 80".split(' ').map { |e| e.to_i }
  cyphertext.map! { |e| e = convert_to_bitstring(e) }
end

def get_key
  puts "Key:"
  key = gets.chomp.split('')
  # key = "password1".split('')
  key.map! { |e| e = convert_to_bitstring(e, true)  }
end

def converter
  cyphertext = get_cyphertext
  key = get_key
  return bin_to_ascii(cyphertext, key)
end
