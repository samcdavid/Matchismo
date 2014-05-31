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
    return [[NSMutableAttributedString alloc] initWithString:card.contents attributes:self.attributesDictionary];
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
