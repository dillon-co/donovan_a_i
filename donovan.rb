require 'mw_dictionary_api'
client = MWDictionaryAPI::Client.new(ENV['MW_API_KEY'])
# module Donovan
  class Words
    attr_accessor :lexicon, :client

    def initialize
      @lexicon = {verbs: {positive: [], neutral: [], negative: []},
                  nouns: {positive: [], neutral: [], negative: []},
                  adgetives: {positive: [], neutral: [], negative: []},
                  adverbs: {positive: [], neutral: [], negative: []},  
                }
    end
    
    def add_to_lexicon(*words)
      words.each do |word|
        type, emotion = get_type(word), get_emotion(word)
        lexicon[type][emotion] << word  
      end  
    end

    # For the following method, the idea is to use google's API
    # to search the word given with a define in front of it.
    # After the search is done, the method will parse the definition of the words
    # to first get the type and then the emotion  

    def get_type(word)
    end
    
    def get_emotion(word)
    end
    
    def get_grammar_tpye(word)
      if word == 'and' || word == 'but'
        'coordinating conjunction'
      elsif word == 'after' || word == 'before'
        'adverb'
      end  
    end  
  end

  class Sentence
    attr_accessor :words
    def initialize
      @words = Words.new
    end

    def figure_out_coordinating_cconjunctions(sentence)
      coordinating_conjunction_arr = []
      sentence.split(' ').each do |word|
        type = words.get_grammar_tpye(word)
        if type == 'coordinating conjunction' || type == 'adverb'
          coordinating_conjunction_arr << word
        end  
      end 
      coordinating_conjunction_arr 
    end  

    def split_sentence_by_coordinating_conjunctions(sentence)
      conjunctions = figure_out_coordinating_cconjunctions(sentence)
      phrases_with_conjunctions = []
      joined_junctions = conjunctions.join(" | ")
      phrases_without_conjunctions = sentence.split(/ #{joined_junctions} /)
      phrases_with_conjunctions << phrases_without_conjunctions[0]
      conjunctions.each_with_index do |conjunction, index|
        phrases_with_conjunctions << "#{conjunction} #{phrases_without_conjunctions[index+1]}"
      end  
      [phrases_without_conjunctions, phrases_with_conjunctions]   
    end 

    def get_phrase_type(phrase)
      phrase_array = phrase.split(' ')
      type = words.get_grammar_type(phrase_array[0])
      if type == 'coordinating conjunction'
        'independent'
      elsif type == 'adverb'
        'subordinate'
      end      
    end  

    def get_sentence_type(sentence)
      parts_of_sentence_without_conjunctions = split_sentence_by_coordinating_conjunctions(sentence)[0]
      parts_of_sentence_with_conjunctions = split_sentence_by_coordinating_conjunctions(sentence)[1]
      clasues = Hash.new  
      parts_of_sentence_with_conjunctions[1..-1].each do |phrase|
      if parts_of_sentence_without_conjunctions.length < 2
        @sentence_type = "simple"
        break
      else  
          if get_phrase_type(phrase) == 'independent' 
            @sentence_type = "coompound"
          elsif get_phrase_type(phrase) == 'subordinate'
            @sentence_type = "complex"
          end
        end    
      end  
      @sentence_type    
    end  

    def structure(sentence)
    end  

    def response
    end

    def question
    end

    def answer
    end

    def statement
    end 
  end 

  class Listen
    attr_reader :sentence_is_a_quesion
    def initialize
      @sentence_is_a_quesion = false
      @type_of_sentence = "statement"
    end
    
    def determine_sentenses(sentence)
      punctuation = sentence.split('').last
      if punctuation == '?'
        @type_of_sentece = "question"
      else  
        @type_of_sentece = "statement"
      end  
    end  
  end  

  class Undersatnd
    attr_accessor :sentence
    def initialize(sentence)
      @sentence = sentence
    end
  
    def get_meaning_of_sentence
      words = []
      sentence.split(' ').each do |word|
        type, emotion = Words.get_type_and_emotion
        words << [word, type, emotion]
      end  
    end    

  end  
# end

# results = client.search('one')
# puts results




demo = "I like cheese and crackers but not cheesecake"
long_demo = "I like cheesecake after gerry eats pie"
hi = "hello"
s = Sentence.new


arr = s.split_sentence_by_coordinating_conjunctions(long_demo)

puts s.get_sentence_type(long_demo)

arr.each do |phrases|
  p phrases
end  










