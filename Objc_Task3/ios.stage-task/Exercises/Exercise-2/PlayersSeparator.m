#import "PlayersSeparator.h"

@implementation PlayersSeparator

- (NSInteger)dividePlayersIntoTeams:(NSArray<NSNumber *>*)ratingArray {
    uint n = ratingArray.count;
    NSInteger result = 0;
    
    for (uint i = 0; i < n; i += 1) {
        for (uint j = i + 1 ; j < n; j += 1) {
            for (uint k = j + 1; k < n; k += 1) {
                int intI = ratingArray[i].intValue;
                int intJ = ratingArray[j].intValue;
                int intK = ratingArray[k].intValue;
                
                if (intI < intJ && intJ < intK) {
                    result += 1;
                } else if (intI > intJ && intJ > intK) {
                    if (0 <= i && i < j && j < k && k < n) {
                        result += 1;
                    }
                }
            }
        }
    }

    return result;
}

@end
