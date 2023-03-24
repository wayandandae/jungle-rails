describe("Add to cart", () => {
  it("should visit the home page", () => {
    cy.visit("/");
  });

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("should display 'Add' button for each product", () => {
    cy.get(".products article button").contains("Add").should("be.visible");
  });

  it("should increase cart count when 'Add' button is clicked", () => {
    cy.get(".nav-link").contains("My Cart").should("contain", "(0)");
    cy.get(".products article button").contains("Add").click({ force: true });
    cy.get(".nav-link").contains("My Cart").should("contain", "(1)");
  });
});
