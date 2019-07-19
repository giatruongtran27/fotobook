module InfiniteHelper
  def infinite_append(containerSelector, render_options)
    collection = render_options
    collection = render_options[:collection] unless render_options.is_a?(ActiveRecord::Relation)

    html = "$('" + containerSelector + "').append('"+ j(render render_options) + "');"
    
    if containerSelector.include? "photos"
      param_name = "photos_page"
      if collection.next_page
        html += "$('.photo-infinite-pagination').replaceWith('" + j(will_paginate(collection, :param_name => "#{param_name}", class: "photo-infinite-pagination d-none", renderer: WillPaginateInfinite::InfinitePagination)) + "');"
      else
        html += "$('.photo-infinite-pagination').fadeOut('slow');"
      end
  
      html.html_safe 
    else
      param_name = "albums_page"
      if collection.next_page
        html += "$('.album-infinite-pagination').replaceWith('" + j(will_paginate(collection, :param_name => "#{param_name}", class: "album-infinite-pagination d-none", renderer: WillPaginateInfinite::InfinitePagination)) + "');"
      else
        html += "$('.album-infinite-pagination').fadeOut('slow');"
      end
  
      html.html_safe  
    end
  end
end