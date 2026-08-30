@tool
class_name SevenSegmentLibrary
extends Resource

@export var characters: Array[SevenSegCharacter]

func find_letter(letter: String) -> SevenSegCharacter:
	for char in characters:
		if char.character == letter:
			return char
	return null

func find_best_fit_character(segments: Array, allow_wilds := false) -> String:
	var best_fit := ""
	for character in characters:
		if character.get_bits() == SevenSegCharacter.get_segment_bits(segments):
			if (!allow_wilds and character.character not in Letters.NUMBERS):
				# γ should also count as a wild, but only when the update comes out :-)
				return character.character
			elif !(character.character in Letters.NUMBERS) or (allow_wilds):
				best_fit = character.character
	
	return best_fit
