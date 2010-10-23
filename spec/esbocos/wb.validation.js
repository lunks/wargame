/*
 * jQuery Form Validation Plugin for WYSIWYG Web Builder v7.0
 * Copyright Pablo Software solutions 2010
 * http://www.wysiwygwebbuilder.com/
 *
 */

(function($)
{
   $.fn.validate = function(options) 
   {
      return this.each(function() 
      {   
         $.validate(this, options);
      });
   };


   $.validate = function(obj, options) 
   {
      var settings = 
      {
         title_text: 'Please enter a value',
         error_text: 'The entered value is invalid',
         color: '#00FF00',
         color_error: '#FF0000',
         color_border: '#808080',
         effect: 'fade',
         match_text: 'Values must be identical',
         match_id: null,
         length_min: '',
         length_max: '',
         value_min: '',
         value_max: '',
         expr_min: '',
         expr_max: '',
         type: 'text',
         required: true,
         disallowfirstchoice: false,
         param: null
      };

      if (options)
         settings = $.extend(settings, options);
 
      settings.title_text = $(obj).attr("title");
      if (settings.title_text == '')
      {
         settings.title_text = 'Enter a value';
      }

      var id = $(obj).attr("id");
      var bubbleid = "#" + id + "_bubble";

      var bubbleHtml = "<div id=\""+id+"_bubble\" class=\"bubble\">";
      bubbleHtml = bubbleHtml + "<div class=\"bubbleContent\">"+settings.title_text+"</div>";
      bubbleHtml = bubbleHtml + "<div class=\"bubbleArrow\">";
      bubbleHtml = bubbleHtml + "<div class=\"line10\"><!-- --></div>";
      bubbleHtml = bubbleHtml + "<div class=\"line9\"><!-- --></div>";
      bubbleHtml = bubbleHtml + "<div class=\"line8\"><!-- --></div>";
      bubbleHtml = bubbleHtml + "<div class=\"line7\"><!-- --></div>";
      bubbleHtml = bubbleHtml + "<div class=\"line6\"><!-- --></div>";
      bubbleHtml = bubbleHtml + "<div class=\"line5\"><!-- --></div>";
      bubbleHtml = bubbleHtml + "<div class=\"line4\"><!-- --></div>";
      bubbleHtml = bubbleHtml + "<div class=\"line3\"><!-- --></div>";
      bubbleHtml = bubbleHtml + "<div class=\"line2\"><!-- --></div>";
      bubbleHtml = bubbleHtml + "<div class=\"line1\"><!-- --></div>";
      bubbleHtml = bubbleHtml + "</div>";
      bubbleHtml = bubbleHtml + "</div>";

      $("body").append(bubbleHtml);	

      $(obj).removeAttr("title");

      var nTop = $(obj).offset().top;
      var nLeft = $(obj).offset().left;

      var bubblePos = "topRight";
	
      if (bubblePos == "topRight")
      {
         nLeft +=  $(obj).width() - 30; 
         nTop -= $(bubbleid).height(); 
         nTop -= 10;
      }
      
      if (bubblePos == "topLeft")
      { 
         nTop += -$(bubbleid).height(); 
         nTop -= 10;
      }
		
      if (bubblePos == "centerRight")
      { 
         nLeft +=  $(obj).width() +13; 
      }

      $(bubbleid).css({	top: nTop, left: nLeft });
      setBubbleColor(bubbleid, settings.color);
      $(bubbleid).hide();

      $.data(obj, 'settings', settings); 
	
      $(obj).focus(function()
      {
         doFocus(obj, settings);
      }).blur(function()
      {
         doBlur(obj, settings);
      });
   }

   $.validate.form = function($obj)
   {
      return validateform($obj);
   }

   function validateform($obj) 
   {
      var isOk = true;
      $('input', $obj).each(function()
      {
	settings = $.data(this, 'settings');
        if (settings) 
        {
            if (doValidate(this, settings) == false)
            {
               isOk = false;
            }
	}
      });
      $('textarea', $obj).each(function()
      {
	settings = $.data(this, 'settings');
        if (settings) 
        {
            if (doValidate(this, settings) == false)
            {
               isOk = false;
            }
	}
      });
      return isOk;
   }

   function doFocus(obj, settings) 
   {
      var id = "#" + $(obj).attr("id")+"_bubble";

      if (settings.effect == 'slide')
      {
         $(id).show('drop', {direction: 'right' }, 500); 
      }
      else
      {
//         if (settings.type != 'radio' && settings.type != 'checkbox')
         {
            $(id).fadeIn(500); 
         }
      }
   }
			
   function doBlur(obj, settings) 
   {
      if (doValidate(obj, settings)) 
      {
         isOK(obj, settings);
      }
   }

   function setText(obj, text)
   {
      $(obj).find(".bubbleContent").html(text);
   }

   function setBubbleColor(obj, color)
   {
     $(obj).find(".bubbleContent").css("background-color", color);
     $(obj).find(".bubbleArrow div").css("background-color", color);
     $(obj).find(".bubbleArrow .line1").css("background-color", '#808080');
     $(obj).find(".bubbleArrow .line2").css("background-color", '#808080');
   }
			
   function reportError(obj, settings, text) 
   {
      var id = "#" + $(obj).attr("id")+"_bubble";
      setText(id, text);
      setBubbleColor(id, settings.color_error);

      if (settings.effect == 'slide')
      {
         $(id).show('slide', {direction: 'right' }, 500); 
      }
      else
      {
         $(id).fadeIn(500); 
      }
   }
			
   function isOK(obj, settings) 
   {
      var id = "#" + $(obj).attr("id")+"_bubble";

      if (settings.effect == 'slide')
      {
         $(id).hide('slide', {direction: 'right' }, 500); 
      }
      else
      {
         $(id).fadeOut(500, function() 
         {
            setText(id, settings.title_text);
            setBubbleColor(id, settings.color);
         }); 
      }
   } 	


   function doValidate(obj, settings) 
   {
      var mask = null;
      
      switch(settings.type) 
      {
         case "text": 	
            break;
   
         case "alphanumeric": 
            mask = /\w*/;
            break;		

         case "number": 		
            mask = /^[0-9-+]+$/; 			
            break;

         case "email": 		
            mask = /^([a-z0-9\+_\-]+)(\.[a-z0-9\+_\-]+)*@([a-z0-9\-]+\.)+[a-z]{2,6}$/i; 			
            break;

         case "custom":
            mask = settings.param;
            break;
      }

      if (settings.required == true) 
      {
         pointer = $(obj);

         var isValid = true;

         if (mask)
         {
            isValid = mask.test(pointer.val());
         }

         if (isValid)
         {
            if (settings.length_min != '')
            {
               if (pointer.val().length < parseInt(settings.length_min))
               {
                  isValid = false;
               }
            }
            if (isValid && settings.length_max != '')
            {
               if (pointer.val().length > parseInt(settings.length_max))
               {
                  isValid = false;
               }
            }
         } 
       
         if (isValid)
         {         
            if (settings.type == 'number')
            {
               if (settings.value_min != '')
               {
                  isValid = eval(pointer.val() + settings.expr_min + settings.value_min);
               }
               if (isValid && settings.value_max != '')
               {
                  isValid = eval(pointer.val() + settings.expr_max + settings.value_max);
               }
            }

            if (settings.type == 'checkbox')
            {
               isValid = $(obj).is(':checked');
            }

            if (settings.type == 'radio')
            {
               var name = $(obj).attr('name');
               if ($("input[name='"+name+"']:checked").val())
               {
               }
               else
               {
                  isValid = false;
               }
            }

            if (settings.type == 'select')
            {
               var index = $(obj).attr("selectedIndex");
               if (index == -1)   
                  isValid = false;
               if (index == 0 && settings.disallowfirstchoice == true)
                  isValid = false;
            }

            if (settings.type == 'ajax')
            {
               isValid = false;

               var data = 'value=' + $(obj).val();
               $.ajax( { type:"POST", async: false, url: settings.param, data: data, success: function (result) 
               {
                  if (result == "true")
                  {
                     isValid = true;
                  }
               }
               });
            }

            if (settings.match_id) 
            {
               matchobj = $("#"+settings.match_id);
               matchsettings = matchobj.data('settings');	

               if (matchobj.val() != '' && matchobj.val() != pointer.val()) 
               {
                  reportError(obj, settings, settings.match_text);
                  reportError(matchobj, matchsettings, matchsettings.match_text);
               }
               else 
               {
                  if (matchobj.val() != '') 
                  { 
                     isOK(matchobj, matchsettings);
                  }
                  return true;
               }
            }
            else 
            {
               if (isValid == false)
               {
                  reportError(obj, settings, settings.error_text);
               }
               return isValid;
            } 
         }
         else 
         { 
            reportError(obj, settings, settings.error_text);
            return false; 
         }
      } 
      else 
      {	
         return true;
      }
   }
 
})(jQuery);