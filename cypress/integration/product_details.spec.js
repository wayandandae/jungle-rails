describe("Product details", () => {
  it("should visit the home page", () => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("should navigate to product details page", () => {
    cy.get("article").first().click();
    cy.url().should("include", "/products");
    cy.get(".product-detail").should("be.visible");
  });
});
