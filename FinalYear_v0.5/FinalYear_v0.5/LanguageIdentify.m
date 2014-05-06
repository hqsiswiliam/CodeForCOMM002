//
//  LanguageIdentify.m
//  FinalYear_v0.1
//
//  Created by H QS on 14-1-8.
//  Copyright (c) 2014年 H QS. All rights reserved.
//

#import "LanguageIdentify.h"

@implementation LanguageIdentify
-(NSString*) lookingForNonce:(NSString *)inputString{
    NSString *outputString = [self searchWithSentenceAndOption:inputString option:NSLinguisticTagNoun];
    return outputString;
}

-(NSString*) lookingForVerb:(NSString *)inputString{
    NSString *outputString = [self searchWithSentenceAndOption:inputString option:NSLinguisticTagVerb];
    return outputString;
}


-(NSString *)searchWithSentenceAndOption:(NSString *)sentence option:(NSString *const)option{
    __block NSMutableArray* outputArray = [[NSMutableArray alloc] initWithObjects:@"", nil];
    NSLinguisticTaggerOptions options = NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerJoinNames;
    NSLinguisticTagger *tagger = [[NSLinguisticTagger alloc] initWithTagSchemes: [NSLinguisticTagger availableTagSchemesForLanguage:@"en"] options:options];
    tagger.string = sentence;
    [tagger enumerateTagsInRange:NSMakeRange(0, [sentence length]) scheme:NSLinguisticTagSchemeNameTypeOrLexicalClass options:options usingBlock:^(NSString *tag, NSRange tokenRange, NSRange sentenceRange, BOOL *stop) {
        NSString *token = [sentence substringWithRange:tokenRange];
        if ([tag isEqualToString:option]) {
            [outputArray addObject:token];
        }
    }];
    
    NSMutableString *outputString = [[NSMutableString alloc]init];
    for (NSUInteger index = 0; index<[outputArray count]; index++) {
        [outputString appendString:outputArray[index]];
        if (index!=[outputArray count]-1&&index!=0) {
            [outputString appendString:@"/"];
        }
    }
    return outputString;
}


@end
