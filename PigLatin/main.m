//
//  main.m
//  PigLatin
//
//  Created by Johnny on 2015-01-16.
//  Copyright (c) 2015 Empath Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+PigLatinString.h"

#if __has_feature(objc_arc)
	#define MDLog(format, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:format, ## __VA_ARGS__]);
#else
	#define MDLog(format, ...) CFShow([NSString stringWithFormat:format, ## __VA_ARGS__]);
#endif


int main(int argc, const char * argv[]) {
	@autoreleasepool {

		NSString* sentence = @"this awesome sentence is one to be pig-latinized";

		MDLog(@"Sentence: %@", sentence);
		MDLog(@"PigLatinized: %@", [sentence stringByPigLatinization]);
	}
    return 0;
}
