//
//  PigLatinString.m
//  PigLatin
//
//  Created by Johnny on 2015-01-16.
//  Copyright (c) 2015 Empath Solutions. All rights reserved.
//

#import "NSString+PigLatinString.h"

//
// Private Category
//

@interface NSString (PigLatinStringPrivate)

-(NSString*) pigLatinizeWord;

@end

	
@implementation NSString (PigLatinStringPrivate)

-(NSString*) pigLatinizeWord {

	NSString* word = self;
	
	// Find vowels.
	NSCharacterSet* vowels = [NSCharacterSet characterSetWithCharactersInString:@"AaEeIiOoUu"];
	NSRange range = [word rangeOfCharacterFromSet:vowels];
	
	// If no vowels (weird), append "ay".  We are done.
	if (range.location == NSNotFound) return [word stringByAppendingString:@"ay"];

	// If word begins with vowel, append "way".  We are done.
	if (range.location == 0) return [word stringByAppendingString:@"way"];

	// Word begins with consonant prefix.

	// Remember if word is capitalized.
	BOOL isCapitalized = isupper([word characterAtIndex:0]);
	
	// Separate consonant prefix.
	NSString* consonantPrefix = [word substringToIndex:range.location];
	word = [word substringFromIndex:range.location];
	
	// Move consonant prefix to end, and append "ay".
	word = [word stringByAppendingString:consonantPrefix];
	word = [word stringByAppendingString:@"ay"];
	
	// Re-capitalize if necessary.
	if (isCapitalized) {
		word = [word capitalizedString];
	}
	return word;
}

@end


//
// Public Category
//

@implementation NSString (PigLatinString)

-(NSString*) stringByPigLatinization {
	
	// Tokenize sentence into array of words.
	NSArray* words = [self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

	// Pig-latinize each word and accumulate in new array.
	NSMutableArray* pigWords = [[NSMutableArray alloc] initWithCapacity:words.count];
	for (NSString* word in words) {
		[pigWords addObject:[word pigLatinizeWord]];
	}
	
	// Join words back into sentence.
	return [pigWords componentsJoinedByString:@" "];
}


@end
