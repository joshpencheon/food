var myJSON;
var editingNewProduct = false;

var productAnim = function() {
	if (!editingNewProduct) {
		$('#product-cassette').animate({fontSize:'-=50%'}, 'fast');
		$('#product_name, #product_ean').animate({width: '33em'}, 'fast');
		
		$('#new_purchase').addClass('new-product', 'fast');
	
		$('#product_ean').attr('tabindex', '');
	};
	editingNewProduct = true;
};
var productAnim2 = function() {
	if (editingNewProduct) {
		$('#product-cassette').animate({fontSize:'+=50%'}, 'fast');
		$('#product_name, #product_ean').animate({width: '16em'}, 'fast');

		$('#new_purchase').removeClass('new-product', 'fast');

		$('#product_ean').attr('tabindex', -1);
	};
	editingNewProduct = false;
};



$(document).ready(function (){
	
	$.extend($.easing, {
		easeDotPrinter: function (x, t, b, c, d) {
			return b + (c-b)*Math.floor(7*t/d)/7;
		},
		
		flicker: function(x, t, b, c, d) {
			return Math.abs(0.5*(2*(t/d) + ((d-t)/d)*Math.sin(10*(t/d)*(d/t - 1)) ));
		}
	})
		
	$.fn.remote = function(callback) {	
		return this.each(function() {
			var form = $(this),
				spinner = form.find('.progress');
			
			form.find('input').keydown(function(e) {
				if (e.which == 13) { form.submit(); }
			});
			
			form.submit(function(e) {				
				$.ajax({
					type: 'post',
					url: form.attr('action'),
					data: form.serialize(),
					dataType: 'html',
					success: function(data) { 
						form.find('input[type=text]').removeAttr('disabled')
							.val('').first().focus(); 
						productAnim2();
						callback(data);
					}
				});

				form.find('input[type=text]').attr('disabled', 'disabled');
				return false;
			});
			
			$(document).ajaxStart(function(){ 
			  if (!spinner.is(':visible')) { spinner.fadeIn('slow'); }
			}).ajaxStop(function(){ 
			  if (spinner.is(':visible')) { spinner.fadeOut('slow'); }
			});
		});
	};
		
	$('#new_purchase').remote(function(data) { 
		var basket = $('#basket');
		
		basket.html(data);
		
		if (basket.find('.purchase.created').length) {
			basket.html(data).css({
				position:'relative', 
				top: -basket.find('.purchase.created').first().height() + 'px'
			}).animate({top: 0}, 700, 'easeDotPrinter');			
		};
		
		basket.find('.purchase.updated').addClass('hover').removeClass('hover', 500,'flicker');
	});
	
	$('.purchase').hover(function(event) { 
		$(this).toggleClass('hover').find('.purchase-controls').toggle();
	});
	
	var createNewProduct = function(input) { productAnim() };
	
	$('#product_name').bind('cancelled.autocomplete', function() {
		productAnim(); // Hit ESC to make new product...
	}).autocomplete({
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
	    }), container = $(self.wrapper).append(listItems),
        wrapTag = $(self.wrapper)[0].tagName;
        
      while (container[0].tagName !== wrapTag) { container = container.children(':first'); };
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