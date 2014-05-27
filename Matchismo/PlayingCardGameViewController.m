//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Sam McDavid on 5/24/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "HistoryViewController.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (NSUInteger)numberOfCardsToMatch {
    return 2;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (NSMutableAttributedString *)attributedContentsOfCard:(Card *)card {
    return [[NSMutableAttributedString alloc] initWithString:card.contents attributes:self.attributesDictionary];
}

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
    if ([segue.identifier isEqualToString:@"PlayingCardMoveHistorySegue"] &&
        [segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
        HistoryViewController *historyController = (HistoryViewController *)segue.destinationViewController;
        historyController.turnHistoryDescriptions = self.turnDescriptions;
    }
}


@end
