Feature: Post API Demo

  Background:
    * url 'https://reqres.in/api'
    # this will prefer to get response as json
    # in case if we write xml, server gonna provide xml
    # if it can do so
    * header Accept = 'application/json'
    * def expectedOutput = read("classpath:jsons/response1.json")

  Scenario: Post Example 1, using Background
    Given path '/users'
    And request {"name":"Zhanarbek","job":"Leader"}
    When method POST
    Then status 201
    And print response
    And print response.createdAt

  Scenario: Post Example 2, with response assertion
    Given path '/users'
    And request {"name":"Zhanarbek","job":"Leader"}
    When method POST
    Then status 201
    # #ignore and #string means there could be any value
    And match response == { "name": "Zhanarbek", "job": "Leader", "id": "#ignore", "createdAt": "#ignore"}
    And print response

  Scenario: Post Example 3, with read response from file
    Given path '/users'
    And request {"name":"Zhanarbek","job":"Leader"}
    When method POST
    Then status 201
    And match $ == expectedOutput

  Scenario: Post Example 4, read request body data from file
    Given path '/users'
    And def requestBody = read("classpath:jsons/request1.json")
    And request requestBody
    When method POST
    Then status 201
    And match response == expectedOutput
    And match $ == expectedOutput
    And print response

  Scenario: Post Example 5, read body data from file and change request values
    Given path '/users'
    And def requestBody = read("classpath:jsons/request1.json")
    And set requestBody.job = 'Engineer'
    And request requestBody
    When method POST
    Then status 201
    And match response == expectedOutput
    And match $ == expectedOutput
    And print response