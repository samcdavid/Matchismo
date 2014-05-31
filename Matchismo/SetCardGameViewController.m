//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Sam McDavid on 5/31/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "HistoryViewController.h"

@interface SetCardGameViewController ()

@property (weak, nonatomic, readonly) NSArray *symbolStrings;
@property (weak, nonatomic, readonly) NSArray *shadeStrings;
@property (weak, nonatomic, readonly) NSArray *colorStrings;

@end

@implementation SetCardGameViewController

// Property Methods

- (NSArray *)symbolStrings {
    return @[@"▲", @"◼︎", @"●"];
}

- (NSArray *)shadeStrings {
    return @[@"open", @"striped", @"solid"];
}

- (NSArray *)colorStrings {
    return @[@"red", @"green", @"purple"];
}

// Private Methods

- (NSDictionary *)attributesDictionaryForCard:(SetCard *)card {
    NSMutableDictionary *cardDictionary = [[NSMutableDictionary alloc] init];
    
    if ([self.shadeStrings containsObject:card.shading] && [self.colorStrings containsObject:card.color]) {
        UIColor *cardColor = [self getUIColorFromString:card.color];
        if ([self.shadeStrings[0] isEqualToString:card.shading]) {
            [cardDictionary addEntriesFromDictionary:@{NSStrokeWidthAttributeName: @5,
                                                       NSStrokeColorAttributeName: cardColor}];
        } else if ([self.shadeStrings[1] isEqualToString:card.shading]) {
            [cardDictionary addEntriesFromDictionary:@{NSStrokeWidthAttributeName: @-5,
                                                       NSStrokeColorAttributeName: cardColor,
                                                       NSForegroundColorAttributeName: [cardColor colorWithAlphaComponent:0.3]}];
        } else {
            [cardDictionary addEntriesFromDictionary:@{NSStrokeWidthAttributeName: @-5,
                                                       NSStrokeColorAttributeName: cardColor,
                                                       NSForegroundColorAttributeName: cardColor}];
        }
    }
    [cardDictionary addEntriesFromDictionary:self.attributesDictionary];
    
    return cardDictionary;
}

- (UIColor *)getUIColorFromString:(NSString *)colorString {
    UIColor *color = nil;
    
    if ([self.colorStrings containsObject:colorString]) {
        if ([colorString isEqualToString:self.colorStrings[0]]) {
            color = [UIColor redColor];
        } else if ([colorString isEqualToString:self.colorStrings[1]]) {
            color = [UIColor greenColor];
        } else {
            color = [UIColor purpleColor];
        }
    }
    
    return color;
}

// Instance Methods

- (NSUInteger)numberOfCardsToMatch {
    return 3;
}

- (Deck *)createDeck {
    return [[SetCardDeck alloc] initWithSymbolNumber:[self numberOfCardsToMatch]
                                             symbols:self.symbolStrings
                                              shades:self.shadeStrings
                                              colors:self.colorStrings];
}

- (NSMutableAttributedString *)attributedContentsOfCard:(Card *)card {
    NSString *cardContents = nil;
    NSDictionary *cardAttributes = nil;
    
    if ([card isMemberOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        cardContents = setCard.symbol;
        for (NSUInteger i = 1; i < setCard.number; i++) {
            cardContents = [cardContents stringByAppendingFormat:@"%@", setCard.symbol];
        }
        cardAttributes = [self attributesDictionaryForCard:setCard];
    }
    
    return (cardContents) ? [[NSMutableAttributedString alloc] initWithString:cardContents attributes:cardAttributes] : nil;
}

- (NSAttributedString *)titleForCard:(Card *)card {
    return [self attributedContentsOfCard:card];
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"setcardback"];
}

// View Lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SetCardMoveHistorySegue"] &&
        [segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
        HistoryViewController *historyController = (HistoryViewController *)segue.destinationViewController;
        historyController.turnHistoryDescriptions = self.turnDescriptions;
    }
}

@end
