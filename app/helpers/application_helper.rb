module ApplicationHelper
  require 'will_paginate/collection'
  Array.class_eval do
    def paginate(options = {})
      raise ArgumentError, "parameter hash expected (got #{options.inspect})" unless Hash === options

      WillPaginate::Collection.create(
          options[:page] || 1,
          options[:per_page] || 3,
          options[:total_pages] || self.length
      ) { |pager|
        pager.replace self[pager.offset, pager.per_page].to_a
      }
    end
  end
end
