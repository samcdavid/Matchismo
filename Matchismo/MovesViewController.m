//
//  MovesViewController.m
//  Matchismo
//
//  Created by Sam McDavid on 5/25/14.
//  Copyright (c) 2014 Sam McDavid. All rights reserved.
//

#import "MovesViewController.h"

@interface MovesViewController ()

@property (weak, nonatomic) IBOutlet UITextView *moveHistoryTextView;

@end

@implementation MovesViewController

// Property Methods
@synthesize turnDescriptions = _turnDescriptions;

- (void)setTurnDescriptions:(NSArray *)turnDescriptions {
    _turnDescriptions = [turnDescriptions copy];
}

- (NSArray *)turnDescriptions {
    if (!_turnDescriptions) _turnDescriptions = [[NSArray alloc] init];
    return _turnDescriptions;
}

// View Controller Lifecycle
- (void)viewWillLayoutSubviews {
    [self updateUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.turnDescriptions = nil;
}

// Private Methods
- (void)updateUI {
    NSRange range;
    NSMutableAttributedString *moveHistory = [[NSMutableAttributedString alloc] init];
    NSAttributedString *newLine = [[NSAttributedString alloc] initWithString:@"\n"
                                                                  attributes:[[self.turnDescriptions firstObject] attributesAtIndex:0
                                                                                                                     effectiveRange:&range]];
    
    for (NSMutableAttributedString *turnDescription in self.turnDescriptions) {
        [moveHistory appendAttributedString:turnDescription];
        [moveHistory appendAttributedString:newLine];
    }
    
    self.moveHistoryTextView.attributedText = moveHistory;
}

@end
