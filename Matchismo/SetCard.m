//
//  SetCard.m
//  Matchismo
//
//  Created by Sam McDavid on 5/25/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()

@property (strong, nonatomic, readwrite) NSAttributedString *attributedContents;
@property (strong, nonatomic, readwrite) NSDictionary *propertyDictionary;

@end

@implementation SetCard

// Constants
static const int STROKE_INDEX = 0;
static const int SOLID_INDEX = 1;
static const int STRIPE_INDEX = 2;
static const int GREEN_INDEX = 0;
static const int RED_INDEX = 1;
static const int PURPLE_INDEX = 2;
static const int TRIANGLE_INDEX = 0;
static const int CIRCLE_INDEX = 1;
static const int SQUARE_INDEX = 2;
static const int NUMBER_OF_CARDS_TO_MATCH = 2;

// Property Methods
- (void)setRank:(NSUInteger)rank {
    if (rank <= [SetCard maxRank]) {
        _rank = rank;
    }
}

@synthesize symbol = _symbol;

- (void)setSymbol:(NSString *)symbol {
    _symbol = [[SetCard validSymbols] containsObject:symbol] ? symbol : nil;
}

- (NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

@synthesize shadeString = _shadeString;

- (void)setShadeString:(NSString *)shadeString {
    _shadeString = [[SetCard validShades] containsObject:shadeString] ? shadeString : nil;
}

- (NSString *)shadeString {
    return _shadeString ? _shadeString : @"?";
}

@synthesize colorString = _colorString;

- (void)setColorString:(NSString *)colorString {
    _colorString = [[SetCard validColors] containsObject:colorString] ? colorString : nil;
}

- (NSString *)colorString {
    return _colorString ? _colorString : nil;
}

- (NSString *)contents {
    return [self.colorString stringByAppendingFormat:@" %@",
            [self.shadeString stringByAppendingFormat:@" %@",
             [self.symbol stringByAppendingFormat:@" %ld", self.rank]]];
}

- (NSAttributedString *)attributedContents {
    if (!_attributedContents) {
        NSString *cardTextContents = [[NSString alloc] init];
        for (int i = 0; i < self.rank; i ++) {
            if (i == 0) cardTextContents = [cardTextContents stringByAppendingFormat:@"%@",self.symbol];
            else cardTextContents = [cardTextContents stringByAppendingFormat:@"\n%@",self.symbol];
        }
        _attributedContents = [[NSAttributedString alloc] initWithString:cardTextContents attributes:[self attributesDictionary]];
    }
    return _attributedContents;
}

- (NSDictionary *)propertyDictionary {
    if (!_propertyDictionary) {
        _propertyDictionary = @{[self validPropertyDictionaryProperties][0]: [NSString stringWithFormat:@"%ld",self.rank],
                                [self validPropertyDictionaryProperties][1]: self.symbol,
                                [self validPropertyDictionaryProperties][2]: self.shadeString,
                                [self validPropertyDictionaryProperties][3]: self.colorString};
    }
    return _propertyDictionary;
}

// Class Methods
+ (NSUInteger)maxRank {
    return 3;
}

+ (NSArray *)validSymbols {
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *)validShades {
    return @[@"stroke", @"solid", @"stripe"];
}

+ (NSArray *)validColors {
    return @[@"green", @"red", @"purple"];
}

+ (NSDictionary *)validShadeDictionary:(NSString *)color {
    if (![[SetCard validColors] containsObject:color]) {
        return nil;
    }
    return @{@"stroke": @{NSStrokeWidthAttributeName: @5},
             @"solid": @{NSStrokeWidthAttributeName: @-5},
             @"stripe": @{NSStrokeWidthAttributeName: @-5,
                           NSForegroundColorAttributeName:
                               [[SetCard validColorDictionary][color][NSForegroundColorAttributeName] colorWithAlphaComponent: 0.2]}};
}

+ (NSDictionary *)validColorDictionary {
    return @{@"green": @{NSForegroundColorAttributeName: [UIColor greenColor],
                         NSStrokeColorAttributeName: [UIColor greenColor]},
             @"red": @{NSForegroundColorAttributeName: [UIColor redColor],
                       NSStrokeColorAttributeName: [UIColor redColor]},
             @"purple": @{NSForegroundColorAttributeName: [UIColor purpleColor],
                          NSStrokeColorAttributeName: [UIColor purpleColor]}};
}

// Public Methods
- (int)match:(NSArray *)otherCards {
    int score = 0;
    BOOL match = YES;
    
    if ([otherCards count] == NUMBER_OF_CARDS_TO_MATCH) {
        for (id obj in otherCards) {
            if (![obj isMemberOfClass:[SetCard class]]) {
                break;
            }
        }
        for (NSString *propertyName in [self validPropertyDictionaryProperties]) {
            if (![self matchProperty:propertyName onSetCards:otherCards]) {
                match = NO;
            }
        }
    }
    
    if (match) {
        score += 10;
    }
    
    return score;
}

// Private Methods
- (NSDictionary *)attributesDictionary {
    NSMutableDictionary *attrs;
    
    [attrs setObject:[SetCard validColorDictionary][self.colorString][NSStrokeColorAttributeName]
              forKey:NSStrokeColorAttributeName];
    [attrs setObject:[SetCard validShadeDictionary:self.colorString][self.shadeString][NSStrokeWidthAttributeName]
              forKey:NSStrokeWidthAttributeName];
    [attrs setObject:([self.shadeString isEqualToString:[SetCard validShades][STRIPE_INDEX]]) ?
     [SetCard validShadeDictionary:self.colorString][self.shadeString][NSForegroundColorAttributeName] :
     [SetCard validColorDictionary][self.colorString][NSForegroundColorAttributeName]
              forKey:NSForegroundColorAttributeName];
    [attrs setObject:[UIFont preferredFontForTextStyle:UIFontTextStyleBody] forKey:NSFontAttributeName];
    
    return attrs;
}

- (NSArray *)validPropertyDictionaryProperties {
    return @[@"rank", @"symbol", @"shade", @"color"];
}

- (BOOL)matchProperty:(NSString *)propertyName onSetCards:(NSArray *)otherCards {
    BOOL match = NO;
    
    if ([[self validPropertyDictionaryProperties] containsObject:propertyName]) {
        SetCard *firstCardToMatch = [[otherCards firstObject] isMemberOfClass:[SetCard class]] ? [otherCards firstObject] : nil;
        SetCard *secondCardToMatch = [[otherCards lastObject] isMemberOfClass:[SetCard class]] ? [otherCards lastObject] : nil;
        
        NSString *firstCardsProperty = firstCardToMatch.propertyDictionary[propertyName];
        NSString *secondCardsProperty = secondCardToMatch.propertyDictionary[propertyName];
        NSString *thisCardsProperty = self.propertyDictionary[propertyName];
        
        if ([thisCardsProperty isEqualToString:firstCardsProperty] &&
            [thisCardsProperty isEqualToString:secondCardsProperty]) {
            match = YES;
        } else if (![thisCardsProperty isEqualToString:firstCardsProperty] &&
                   ![thisCardsProperty isEqualToString:secondCardsProperty] &&
                   ![firstCardsProperty isEqualToString:secondCardsProperty]) {
            match = YES;
        }
    }
    
    return match;
}

@end
