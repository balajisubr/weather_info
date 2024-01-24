Feature: Query Weather page
  Scenario: Enter blank address
    Given user is on query weather page
    When they click submit
    Then it gives an error "Address is blank. Please enter valid address"

  Scenario: Enter valid zipcode
    Given user is on query weather page
    When they enter valid address
    And they click submit
    And API returns valid response
    And cache is clear
    Then I see weather info

  Scenario: Enter valid zipcode
    Given user is on query weather page
    When they enter invalid address
    And they click submit
    And API returns invalid response
    And cache is clear
    Then it gives an error "No matching location found."
