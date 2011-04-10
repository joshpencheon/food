var myJSON;
var editingNewProduct = false;

var productAnim = function() {
	if (!editingNewProduct) {
		$('#product-cassette').animate({fontSize:'-=50%'}, 'fast');
		$('#product_name, #product_ean').animate({width: '33em'}, 'fast');
	
		$('#product_ean').attr('tabindex', '');
	};
	editingNewProduct = true;
};
var productAnim2 = function() {
	if (editingNewProduct) {
		$('#product-cassette').animate({fontSize:'+=50%'}, 'fast');
		$('#product_name, #product_ean').animate({width: '16em'}, 'fast');

		$('#product_ean').attr('tabindex', -1);
	};
	editingNewProduct = false;
};



$(document).ready(function (){
		
	$.fn.remote = function(callback) {	
		return this.each(function() {
			var form = $(this);
			
			form.find('input').keydown(function(e) {
				if (e.which == 13) { form.submit(); }
			});
			
			form.submit(function(e) {
				$.ajax({
					// url: form.attr('action'),
					type: 'post',
					url: '/baskets/4/purchases',
					data: form.serialize(),
					dataType: 'js',
					success: function(data) { 
						form.find('input[type=text]').val('').blur(); 
						productAnim2();
						callback(data);
					}
				});
				return false;
			});
		});
	};
		
	$('#new_purchase').remote(function(data) { $('#basket').html(data) })
		
	var createNewProduct = function(input) { productAnim() };
	
	$('#product_name').autocomplete({
		ajax: "/products.json",
		timeout: 200,
		matcher: function(typed) {
			return new RegExp(typed, 'i');
		},
		filterList: function(list, val) {
			var self = this, grepCallback = function(product, i) {
				var nameMatch = self.match(product.name, self.matcher(val)),
					eanMatch = product.ean ? self.match(product.ean.replace(/\s/g, ''), self.matcher(val)) : false;
				return nameMatch || eanMatch;
			};
			
			myJSON = $(list).get().map(function(item) { return item.product });
			
			var filteredList = $.grep(myJSON, grepCallback);
			
			if (filteredList.length) { productAnim2(); return filteredList }
				else { createNewProduct(val); return [] };
		},
		buildList: function(list) {
	        var self = this, listItems = $(list).map(function() {
				var node = $(self.template(this))[0];
				$.data(node, "originalObject", this.name);
				return node;
	        });

	        var container = $(self.wrapper).append(listItems);

	        var wrapTag = $(self.wrapper)[0].tagName;
	        while (container[0].tagName !== wrapTag) {
	          container = container.children(':first');
	        }
	        return container;
	    },
		template: function(match) { 
			return "<li>" + "<span class='grey'>" + this.insertText(match.ean) + "</span>" + 
			  this.insertText(match.name) + "</li>"; 
		},
		insertText: function(item) { return item || ''; },
		displayList: function(input, container) {
	        var input = input.closest('td'), offset = input.offset();
	        container
	          .css({
	            top: offset.top + input.outerHeight(),
	            left: offset.left,
	            width: input.outerWidth() - 2
	          })
	          .appendTo("body");
			container.find("li:first").addClass('active');
	        return container;
      	},
	});

	$.ajaxSetup({ beforeSend: function(xhr) {xhr.setRequestHeader('Accept', 'text/javascript')} });

});