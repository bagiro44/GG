//
//  EditController.m
//  GG
//
//  Created by Dmitriy Remezov on 24.08.13.
//  Copyright (c) 2013 Dmitriy Remezov. All rights reserved.
//

#import "EditController.h"

@interface EditController ()

@end

@implementation EditController
@synthesize film;

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
    (film.titile)?self.editTitle.text = film.titile:nil;
    (film.year)?self.editYear.text = film.year:nil;
    (film.descriptionfilm)?self.editDescription.text = film.descriptionfilm:nil;
    (film.genre)?self.editGenre.text = film.genre:nil;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    if ([self.editTitle isFirstResponder] && [touch view] != self.editTitle)
    {[self.editTitle resignFirstResponder];}
    else if ([self.editYear isFirstResponder] && [touch view] != self.editYear)
     {[self.editYear resignFirstResponder];}
    else if ([self.editGenre isFirstResponder] && [touch view] != self.editGenre)
    {[self.editGenre resignFirstResponder];}
    else if ([self.editDescription isFirstResponder] && [touch view] != self.editDescription)
    {[self.editDescription resignFirstResponder];}
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelEditView:(id)sender
{
    NSLog(@"hello");
    
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setFilmDetail:film];
}

- (IBAction)saveEditing:(id)sender
{
    
}
@end
