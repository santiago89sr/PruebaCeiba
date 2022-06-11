//
//  PruebaCeibaUITests.swift
//  PruebaCeibaUITests
//
//  Created by Santiago Rodriguez on 10/06/22.
//

import XCTest

class PruebaCeibaUITests: XCTestCase {

    override func setUp() async throws {
        
    }

    override func tearDown() async throws {
        
    }

    func testSearchUser() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let searchTextfield = app.textFields["Search user"]
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: searchTextfield, handler: nil)
        waitForExpectations(timeout: 6, handler: nil)//despues de 6 segundos hace la validacion del expectation(linea de arriba)
        searchTextfield.tap()
        
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        
        let rKey = app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        rKey.tap()
        
        let vKey = app/*@START_MENU_TOKEN@*/.keys["v"]/*[[".keyboards.keys[\"v\"]",".keys[\"v\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        vKey.tap()
        
        let iKey = app/*@START_MENU_TOKEN@*/.keys["i"]/*[[".keyboards.keys[\"i\"]",".keys[\"i\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        iKey.tap()
        
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()
        
        let returnKey = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnKey.tap()
        
    }
    
    func testUserPosts() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables
        expectation(for: NSPredicate(format: "exists == 1"), evaluatedWith: tablesQuery, handler: nil)//Valida que el boton Exista
        waitForExpectations(timeout: 5, handler: nil)//despues de 5 segundos hace la validacion del expectation(linea de arriba)
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Clementine Bauch"]/*[[".cells.staticTexts[\"Clementine Bauch\"]",".staticTexts[\"Clementine Bauch\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Clementine Bauch").staticTexts["VER PUBLICACIONES"]/*[[".cells.containing(.staticText, identifier:\"Nathan@yesenia.net\")",".buttons[\"VER PUBLICACIONES\"].staticTexts[\"VER PUBLICACIONES\"]",".staticTexts[\"VER PUBLICACIONES\"]",".cells.containing(.staticText, identifier:\"1-463-123-4447\")",".cells.containing(.staticText, identifier:\"Clementine Bauch\")"],[[[-1,4,1],[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        
        let back = app/*@START_MENU_TOKEN@*/.staticTexts["Back"]/*[[".buttons[\"Back\"].staticTexts[\"Back\"]",".staticTexts[\"Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        back.tap()
        
    }

}
