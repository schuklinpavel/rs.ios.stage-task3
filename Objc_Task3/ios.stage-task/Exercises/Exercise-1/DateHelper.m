#import "DateHelper.h"

@implementation DateHelper

#pragma mark - First

-(NSString *)monthNameBy:(NSUInteger)monthNumber {
//    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
//    dateComponents.month = 4;
//
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDate * date = [calendar dateFromComponents:dateComponents];
//
//    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:date];
//
//    NSLog(@"%d", month);
    
    if (monthNumber > 0 && monthNumber < 13) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        NSString *month = [[df monthSymbols] objectAtIndex:monthNumber - 1];
        if (month) {
            return month;
        }
    }

    return nil;
}

#pragma mark - Second

- (long)dayFromDate:(NSString *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *dateFromDf = [df dateFromString:date];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * dateComponents = [calendar components: NSCalendarUnitDay fromDate: dateFromDf];
    
    return dateComponents.day;
}

#pragma mark - Third

- (NSString *)getDayName:(NSDate*) date {
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * dateComponents = [calendar components: NSCalendarUnitWeekday fromDate: date];
    
//    NSLocale *locale = [NSDateFormatter dateFormatFromTemplate:@"EEEE" options:0 locale:[NSLocale localeWithLocaleIdentifier:@"ru"]];
    
    if (dateComponents) {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];

        df.locale = [NSLocale localeWithLocaleIdentifier:@"ru"];
        NSString *weekday = [[df shortWeekdaySymbols] objectAtIndex:dateComponents.weekday - 1];

        return weekday;
    }
    
    return 0;
}

#pragma mark - Fourth

- (BOOL)isDateInThisWeek:(NSDate *)date {
    /*
     Задание: Проверить является ли введенная дата датой на текущей неделе.
     Пример: Текущая неделя с 17 по 23 мая 2021 года, если ввести дату 23.05.2021, то на выходе мы получим “YES”, так как данная дата относится к текущей неделе. Если мы введем дату 24.05.2021, то мы получим “NO”, так как эта дата относится к следующей неделе.
     */
    
//    NSCalendar *nowCalendar = [NSCalendar currentCalendar ];
//    [nowCalendar setFirstWeekday:2];
//    NSDate *now = [NSDate date];
//    NSDateComponents *nowDateComponents = [nowCalendar components:(NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:[NSDate now]];
//
//    NSLog(@"____%lu", nowDateComponents.weekday);
//
//    NSCalendar * calendar = [NSCalendar currentCalendar];
//    NSDateComponents * dateComponents = [calendar components: NSCalendarUnitWeekday fromDate: date];
  
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setFirstWeekday:2];
    NSDate *now = [NSDate date];
    NSDate *startOfTheWeek;
    NSDate *endOfWeek;
    NSTimeInterval interval;
    [cal rangeOfUnit:NSCalendarUnitWeekOfMonth
           startDate:&startOfTheWeek
            interval:&interval // <-- interval will hold the length of the time unit,
             forDate:now];     //    here week, taking DST et al into account
    //startOfWeek holds now the first day of the week, according to locale (monday vs. sunday)

    endOfWeek = [startOfTheWeek dateByAddingTimeInterval:interval-1];
    // holds 23:59:59 of last day in week.

    if ([startOfTheWeek compare:date] == NSOrderedAscending &&
        [endOfWeek compare:date] == NSOrderedDescending) {
        return YES;
    }
    
    return NO;
}

@end
