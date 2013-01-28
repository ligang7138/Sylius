Feature: Product variants
    As a store owner
    I want to be able to manage product variants
    In order to add different product variations to my offer

    Background:
        Given I am logged in as administrator
          And there are following options:
            | name          | presentation | values           |
            | T-Shirt color | Color        | Red, Blue, Green |
            | T-Shirt size  | Size         | S, M, L          |
          And there are following properties:
            | name               | presentation |
            | T-Shirt fabric     | T-Shirt      |
          And the following products exist:
            | name           | price | options                     | properties             |
            | Super T-Shirt  | 19.99 | T-Shirt size, T-Shirt color | T-Shirt fabric: Wool   |
            | Black T-Shirt  | 19.99 | T-Shirt size                | T-Shirt fabric: Cotton |
            | Sylius T-Shirt | 12.99 | T-Shirt size, T-Shirt color | T-Shirt fabric: Cotton |
            | Mug            | 5.99  |                             |                        |
            | Sticker        | 10.00 |                             |                        |
          And product "Super T-Shirt" is available in all variations

    Scenario: Viewing a product without options
        Given I am on the page of product "Mug"
         Then I should see "There are no options for this product"

    Scenario: Viewing a product with options but without variants
        Given I am on the page of product "Black T-Shirt"
         Then I should not see "There are no options for this product"
          But I should see "There are no variants to display"

    Scenario: Accessing the variant creation form
        Given I am on the page of product "Black T-Shirt"
         When I follow "Create variant"
         Then I should be creating variant of "Black T-Shirt"

    Scenario: Submitting form without the price
        Given I am creating variant of "Black T-Shirt"
         When I press "Create"
         Then I should see "Please enter the price."

    Scenario: Trying to create variant with existing options combination
        Given I am creating variant of "Super T-Shirt"
         When I press "Create"
         Then I should see "Variant with this option set already exists."

    Scenario: Trying to create product variant with invalid price
        Given I am creating variant of "Black T-Shirt"
         When I fill in "Price" with "0.00"
          And I press "Create"
         Then I should see "Price must be greater than 0.01"

    Scenario: Creating a product variant by selecting option
        Given I am creating variant of "Black T-Shirt"
         When I fill in "Price" with "19.99"
          And I select "L" from "T-Shirt size"
          And I press "Create"
         Then I should be on the page of product "Black T-Shirt"
          And I should see "Variant has been successfully created."

    Scenario: Creating a product variant by selecting multiple options
        Given I am creating variant of "Sylius T-Shirt"
         When I fill in "Price" with "19.99"
          And I select "L" from "T-Shirt size"
          And I select "Red" from "T-Shirt color"
          And I press "Create"
         Then I should be on the page of product "Sylius T-Shirt"
          And I should see "Variant has been successfully created."

    Scenario: Updating the variant price
        Given product "Black T-Shirt" is available in all variations
          And I am on the page of product "Black T-Shirt"
         When I click "edit" near "T-Shirt size: L"
          And I fill in "Price" with "33.99"
          And I press "Save changes"
         Then I should be on the page of product "Black T-Shirt"
          And I should see "Variant has been successfully updated."

    Scenario: Deleting product variant
        Given product "Black T-Shirt" is available in all variations
          And I am on the page of product "Black T-Shirt"
         When I click "delete" near "T-Shirt size: L"
         Then I should be on the page of product "Black T-Shirt"
          And I should see "Variant has been successfully deleted."
