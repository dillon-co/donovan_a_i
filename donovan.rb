# module Donovan
  class Words
    attr_accessor :lexicon

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
        return 'coordinating conjunction'
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
        if type == 'coordinating conjunction'
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

    end  

    def get_sentence_type(sentence)
      sentence_arr = sentence.split(' ')
      coordinating_conjunctions = figure_out_coordinating_cconjunctions(sentence)
      simple_sentence = true
      sentence_type = "simple"
      if !simple_sentence
        parts_of_sentece_without_conjunctions = split_sentence_by_coordinating_conjunctions(sentence, coordinating_conjunctions)[0]
        parts_of_sentece_with_conjunctions = split_sentence_by_coordinating_conjunctions(sentence, coordinating_conjunctions)[1]
        if parts_of_sentence.length == 2 
          parts_of_sentence.each_with_index do |phrase, phrase_index|
            if phrase.split(" ").length > 1
              sentence_type = "simple"
            else
              sentence_type = "compound"
            
            end  
          end  
        end  
      end
      return sentence_type    
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
      count = 0
      words = []
      sentence.split(' ').each do |word|
        type, emotion = Words.get_type_and_emotion
        words << [word, type, emotion]
      end  
    end    

  end  
# end







demo = "I like cheese and crackers but not cheesecake"

arr = Sentence.new.split_sentence_by_coordinating_conjunctions(demo)

arr.each do |phrases|
  p phrases
end  










