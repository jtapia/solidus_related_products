var RelatedToAutocomplete;

RelatedToAutocomplete = (function() {
  function RelatedToAutocomplete(relationTypeSelector1, relatedToSelector1) {
    this.relationTypeSelector = relationTypeSelector1;
    this.relatedToSelector = relatedToSelector1;
    this.initializeSelect(this.relationTypeSelector);
    this.setupListeners();
  }

  RelatedToAutocomplete.prototype.setupListeners = function() {
    return $(document).on('change', this.relationTypeSelector, (function(_this) {
      return function(event) {
        return _this.initializeSelect(event.target);
      };
    })(this));
  };

  RelatedToAutocomplete.prototype.initializeSelect = function(target) {
    this.selectedType = $(target).find(":selected").data("relationType");
    if (this.selectedType === 'Spree::Variant') {
      this.initializeVariantSelect();
    } else if (this.selectedType === 'Spree::Product') {
      this.initializeProductSelect();
    }
    return $(this.relatedToSelector).css('display', 'block');
  };

  RelatedToAutocomplete.prototype.initializeProductSelect = function() {
    return $(this.relatedToSelector).productAutocomplete({
      multiple: false
    });
  };

  RelatedToAutocomplete.prototype.initializeVariantSelect = function() {
    return $(this.relatedToSelector).variantAutocomplete();
  };

  return RelatedToAutocomplete;

})();

Spree.ready(function($) {
  var relatedToSelector, relationTypeSelector;
  relationTypeSelector = '.relation_type';
  relatedToSelector = '.related_to_autocomplete';
  if ($(relationTypeSelector).is('*')) {
    return new RelatedToAutocomplete(relationTypeSelector, relatedToSelector);
  }
});
