#import "LexicographicallyMinimal.h"

@interface LexicographicallyMinimal()

@property (nonatomic, strong) NSMutableString *resultString;

@end

@implementation LexicographicallyMinimal

static void getSymbolsArray(NSString *string, NSMutableArray *stringArray) {
    [string enumerateSubstringsInRange:[string rangeOfString:string]
                                options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                             usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [stringArray addObject:substring] ;
    }];
}

-(NSString *)findLexicographicallyMinimalForString1:(NSString *)string1 andString2:(NSString *)string2 {    
    NSMutableArray *array1 = [NSMutableArray array];
    NSMutableArray *array2 = [NSMutableArray array];
    NSMutableString *resultString = [NSMutableString stringWithCapacity:([string1 length] + [string2 length])];
    getSymbolsArray(string1, array1);
    getSymbolsArray(string2, array2);
    
    uint length = array1.count + array2.count;
    for (uint i = 0; i < length; i += 1) {
        if (array1.lastObject && array2.lastObject) {
            if ([array1.lastObject compare: array2.lastObject] != NSOrderedDescending) {
                [resultString appendString:array1.lastObject];
                [array1 removeLastObject];
            } else {
                [resultString appendString:array2.lastObject];
                [array2 removeLastObject];
            }
        } else {
            if (array1.lastObject) {
                [resultString appendString:array1.lastObject];
                [array1 removeLastObject];
            } else if (array2.lastObject) {
                [resultString appendString:array2.lastObject];
                [array2 removeLastObject];
            }
        }
    }

//    NSLog(@"tempArray = %@" , resultString);
    
    return resultString;
}

@end
