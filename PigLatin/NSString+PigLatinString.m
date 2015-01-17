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
	
	if (self.length <= 0) return self;
	
	NSString* word = self;
	
	// Find vowels.
	NSCharacterSet* vowels = [NSCharacterSet characterSetWithCharactersInString:@"AEIOUaeiou"];
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

-(NSCharacterSet*) toggleCharSet:(NSCharacterSet*) currCharSet {
	return currCharSet == [NSCharacterSet letterCharacterSet] ?
	[NSCharacterSet punctuationCharacterSet] : [NSCharacterSet letterCharacterSet];
}

-(NSString*) stringByPigLatinization {
	
	if (self.length <= 0) return self;
	
	// Scan alternating sequences of words and punctuation.
	// Accumulate Pig-Latinized words, while retaining punctuation and whitespace.
	
	NSMutableArray* pigLatinWords = [[NSMutableArray alloc] init];
	NSScanner* scanner = [NSScanner scannerWithString:self];
	scanner.charactersToBeSkipped = nil; // Manage whitespace ourselves.
	NSCharacterSet* fromCharSet = [NSCharacterSet letterCharacterSet];
	
	while (![scanner isAtEnd]) {

		// Scan any whitespace and store it
		NSString* word;
		if ([scanner scanCharactersFromSet:[NSCharacterSet whitespaceCharacterSet] intoString:&word]) {
			[pigLatinWords addObject:word];
		}
		
		// Scan for letters (or punctuation).
		// If cannot find, then toggle to punctuation (or letters).
		if(![scanner scanCharactersFromSet:fromCharSet intoString:&word]) {
			fromCharSet = [self toggleCharSet:fromCharSet];
			continue;
		}

		// If the word is letters, Pig-Latinize it.
		if (fromCharSet == [NSCharacterSet letterCharacterSet]) {
			word = [word pigLatinizeWord];
		}
		
		// Store word regardless.
		[pigLatinWords addObject:word];
	}
	
	// Join words back into sentence.
	return [pigLatinWords componentsJoinedByString:@""];
}

@end
