*** Settings ***
Library     FakerLibrary
Library     JSONLibrary


*** Test Cases ***
Test FakerLibrary
    ${address}    FakerLibrary.Street Address
    Log    Address: ${address}

    ${city}    FakerLibrary.City
    Log    City: ${city}

    ${zipcode}    FakerLibrary.Postcode
    Log    Zipcode: ${zipcode}

Test JSONLibrary
    ${json_data}    Convert String To Json    {"test": "value"}
    Log    JSON: ${json_data}
