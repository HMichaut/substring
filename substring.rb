# Importing the unit test library
require "test/unit/assertions"
include Test::Unit::Assertions

# Creation of the unit test disctionary
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

# String [Array-of Strings] -> Hash
# Consumes a String str as the first argument and an array input_disctionary of valid substrings as the second argument. 
# Returns a hash listing each substring (case insensitive) that was found in the original string and how many times it was found.
def substrings (str, input_dictionary)
  # split the string in an array by keeping only words, selection with a regex
  input_array = str.split(/[^[[:word:]]]+/)
  # create a solution hash for each word in the input_array
  process_hash = input_array.map {|substring| substrings_aux(substring, input_dictionary)}
  # reduce the hashes in the process_hash with a merge method, the reduce block is evaluated only when there is a value in both total and element hashes
  result_hash = process_hash.reduce{|total, element| total.merge(element) {|key, old_value, new_value| old_value + new_value}}
  return result_hash
end


# Substring [Array-of Strings] -> Hash
# Consumes a substring as the first argument and an array input_disctionary of valid substrings as the second argument. 
# Returns a hash informing which substrings (case insensitive) were found in the original string and how many times it was found.
def substrings_aux (word, input_dictionary)
  res_hash = {}
  # downcase application to have case insensitive result
  word_downcase = word.downcase
  # iteration through the dictionary if the keyalready exist the result is added to the value, if not a key is created
  input_dictionary.each do |item|
    item_downcase = item.downcase
    if word_downcase.include?(item) && res_hash.key?(item)
      res_hash[item] += 1
    elsif word_downcase.include?(item)
      res_hash[item] = 1
    end
  end
  return res_hash 
end

# Unit tests
assert_equal substrings_aux("below", dictionary), { "below" => 1, "low" => 1 }
assert_equal substrings("below", dictionary), { "below" => 1, "low" => 1 }
assert_equal substrings("Howdy partner, sit down! How's it going?", dictionary), { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }