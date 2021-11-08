# frozen_string_literal: true

# base class for all models inside application, use with extreme caution
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
