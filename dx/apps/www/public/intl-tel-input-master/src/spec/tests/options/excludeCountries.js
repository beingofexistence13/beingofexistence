"use strict";

describe("excludeCountries option:", function() {

  beforeEach(function() {
    intlSetup();
    input = $("<input>").wrap("div");
  });

  afterEach(function() {
    intlTeardown();
  });

  it("init the plugin with excludeCountries=[] has all countries", function() {
    iti = window.intlTelInput(input[0], {
      excludeCountries: [],
    });
    expect(getListLength()).toEqual(totalCountries + defaultPreferredCountries);
  });

  describe("init the plugin with excludeCountries=[us, ca]", function() {

    var excludeCountries = ["us", "ca"];

    beforeEach(function() {
      iti = window.intlTelInput(input[0], {
        excludeCountries: excludeCountries,
        preferredCountries: [],
      });
    });

    it("excludes the US and Canada", function() {
      var listItems = getListElement().find("li.country");
      expect(listItems.filter("[data-country-code=us]")).not.toExist();
      expect(listItems.filter("[data-country-code=ca]")).not.toExist();
      expect(getListLength()).toEqual(totalCountries - excludeCountries.length);
    });

    it("defaults to the next in the list", function() {
      expect(getSelectedFlagElement()).toHaveClass("iti__af");
    });

    it("typing +1 sets the flag to Dominican Republic", function() {
      input.val("+");
      triggerKeyOnInput("1");
      expect(getSelectedFlagElement()).toHaveClass("iti__do");
    });

  });

});
