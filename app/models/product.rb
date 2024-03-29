class Product < ActiveRecord::Base
  
  has_many  :line_items
  before_destroy  :ensure_not_referenced_by_any_line_item
  
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: { 
    with: /\.(gif|jpg|png)\z/i,
    message: "must be a URL for GIF, PNG, or JPG image."
  }
  
  private
  
  def ensure_not_referenced_by_any_line_item
    if lines.empty?
      true
    else
      errors.add(:base, 'Line Items Present')
      false
    end
  end
  
  
end
