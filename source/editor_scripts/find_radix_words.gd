@tool
extends EditorScript
var game_dictionary: WordDictionary

func _run() -> void:
	game_dictionary = ResourceLoader.load("res://words/compiled.res", "", ResourceLoader.CACHE_MODE_IGNORE)
	
	#for i in range(1,27):
		#print("radix: %d - allowed words: %d"%[i,len(find_radix_words(i))])
	print(find_radix_words(10))
func find_radix_words(radix: int) -> Array[String]:
	var words := game_dictionary.words.words
	
	var allowed_letters = Letters.ALPHABET.slice(0,radix)
	
	var found_words: Array[String] = []

	for word in words:
		var valid := true
		for let in word:
			if let not in allowed_letters:
				valid = false
				break
		if valid:
			found_words.append(word)
	
	found_words.sort_custom(func(a,b): return len(a) > len(b))
	
	return found_words
			
