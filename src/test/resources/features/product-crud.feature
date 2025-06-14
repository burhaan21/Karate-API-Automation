Feature: CRUD operations on Product API

Background:
  * url 'https://api.escuelajs.co/api/v1/products'
  * def productPayload =
    """
    {
      "title": "Test 1",
      "price": 65,
      "description": "This is a test product created using Karate",
      "categoryId": 1,
      "images": ["https://placeimg.com/640/480/any"]
    }
    """

Scenario: Create a new product (POST)
  Given request productPayload
  When method POST
  * print response
  * print responseStatus
  Then status 201
  And match response.title == productPayload.title
  * def productId = response.id

Scenario: Get the created product (GET)
  Given path '/133'
  When method GET
  * print response
  * print responseStatus
  Then status 200
  And match response.title == "Test 1"

Scenario: Update the product (PUT)
  * def updatedPayload =
    """
    {
      "title": "Test 1",
      "price": 56,
      "description": "Updated description using Karate",
      "categoryId": 1,
      "images": ["https://placeimg.com/640/480/tech"]
    }
    """
  Given path '/133'
  And request updatedPayload
  When method PUT
  * print response
  * print responseStatus
  Then status 200
  And match response.title == "Test 1"

Scenario: Delete the product (DELETE)
  Given path '/133'
  When method DELETE
  * print response
  * print responseStatus
  Then status 200

Scenario: Verify product has been deleted (GET)
  Given path '/133'
  When method GET
  * print response
  * print responseStatus
  Then status 400
