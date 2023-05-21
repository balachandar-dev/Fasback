//
//  fasBackTechnicianUITests.m
//  fasBackTechnicianUITests
//
//  Created by User on 21/07/17.
//  Copyright © 2017 User. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface fasBackTechnicianUITests : XCTestCase

@end

@implementation fasBackTechnicianUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

-(void) testLoginogic
{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Already Registered? SIGN IN"] tap];
    
    XCUIElementQuery *elementsQuery = app.scrollViews.otherElements;
    XCUIElement *emailTextField = elementsQuery.textFields[@"Email"];
    [emailTextField tap];
    [emailTextField typeText:@"utf@hcg.bi"];
    
    XCUIElement *passwordSecureTextField = elementsQuery.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"khbh"];
    [elementsQuery.buttons[@"Sign In"] tap];
    [app.alerts.buttons[@"OK"] tap];
    
   
    
}
@end
