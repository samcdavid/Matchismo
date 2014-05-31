//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Sam McDavid on 5/31/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetCardDeck ()

@property (strong, nonatomic, readwrite) NSArray *validSymbols;
@property (strong, nonatomic, readwrite) NSArray *validShades;
@property (strong, nonatomic, readwrite) NSArray *validColors;


@end

@implementation SetCardDeck

- (instancetype)init {
    return nil;
}

- (instancetype)initWithSymbolNumber:(NSUInteger)number
                             symbols:(NSArray *)symbols
                              shades:(NSArray *)shades
                              colors:(NSArray *)colors {
    self = [super init];
    
    if (self) {
        if ([symbols count] == number &&
            [shades count] == number &&
            [colors count] == number) {
            for (NSString *symbol in symbols) {
                for (NSString *shade in shades) {
                    for (NSString *color in colors) {
                        for (NSInteger i = 1; i <= number; i++) {
                            SetCard *newCard = [[SetCard alloc] init];
                            newCard.number = i;
                            newCard.symbol = symbol;
                            newCard.shading = shade;
                            newCard.color = color;
                            
                            [self addCard:newCard];
                        }
                    }
                }
            }
        }
    }
    
    self.validSymbols = symbols;
    self.validShades = shades;
    self.validColors = colors;
    
    return self;
}

@end
