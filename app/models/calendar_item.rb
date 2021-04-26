class CalendarItem < ApplicationRecord
  belongs_to :calendar
  belongs_to :item
  
end
