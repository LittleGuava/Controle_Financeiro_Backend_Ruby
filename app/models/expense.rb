class Expense < ApplicationRecord
    
    belongs_to :user
    
    validates_presence_of :description, :user_id

    def self.ransackable_attributes(_auth_object = nil)
        %w[id description value date user_id created_at updated_at]
    end

    def self.ransackable_associations(_auth_object = nil)
        []
    end
    
end
