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
@synthesize film, pickerController, filmImage;

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
    pickerController = [[UIImagePickerController alloc] init];
    pickerController.allowsImageEditing = NO;
    pickerController.delegate = self;
    pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    (film.titile)?self.editTitle.text = film.titile:nil;
    (film.year)?self.editYear.text = film.year:nil;
    (film.descriptionfilm)?self.editDescription.text = film.descriptionfilm:nil;
    (film.genre)?self.editGenre.text = film.genre:nil;
    [self.editFilmImage setHidden:NO];
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
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController setFilmDetail:film];
    if(![[DBClient sharedInstance] insertToDB:film])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Не удалось добавить фильм в избранное..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    
}

- (IBAction)saveEditing:(id)sender
{
    //[segue.destinationViewController setFilmDetail:film];
    film.titile = self.editTitle.text;
    film.year = self.editYear.text;
    film.genre = self.editGenre.text;
    film.descriptionfilm = self.editDescription.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateDetail" object:self];
    if(![[DBClient sharedInstance] insertToDB:film])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Не удалось добавить фильм в избранное..." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)editImage:(id)sender
{
    [self presentModalViewController:pickerController animated:YES];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModalViewControllerAnimated:YES];
    filmImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    self.editFilmImage.image = filmImage;
}

@end
