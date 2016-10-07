# PageParts

Enable page parts in your model

## Install

    gem 'page_parts'

ActiveRecord:

    require 'page_parts/orm/active_record'
    rake page_parts_engine:install:migrations

Mongoid:

    require 'page_parts/orm/mongoid'

## Usage

Setup fields at your model:

    class Category < ActiveRecord::Base
      include PageParts::Extension

      page_parts :content, :sidebar
    end

Use fields as normal attributes:

    @category = Category.new
    @category.content = "Some text"
    @category.sidebar = "Sidebar text"
    @category.save

Setup fields with suffixes:

    page_parts :sidebar, suffix: [:en, :uk]

    page_parts :content, suffix: I18n.available_locales

It generates attributes: sidebar_en, sidebar_uk

## Tests

    rake test

Copyright (c) 2012 Fodojo, released under the MIT license
