class Request < ApplicationRecord

  has_many :request_attachments, dependent: :destroy
  accepts_nested_attributes_for :request_attachments

  validates_with UsernameValidator
  validates :jobtitle, presence: true
  validates :pickup_date, presence: true
  validates :color_copy, presence: true
  validates :sides, presence: true
  validates :binding, presence: true
  validates :size, presence: true
  validates :weight, presence: true
  validates :folding, presence: true
  validates :costcenter, presence: true

  def self.admins
    return ['<REDACTED>']
  end 

  def self.to_csv
    attributes = %w{requester jobtitle created_at updated_at costcenter originals copies color size weight estimate other_estimate total special_info sides stock binding folding color_copy collate staple three_hole cut laminate pad black_back}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |r|
        csv << [r.requester,
                r.jobtitle.to_s.gsub(',',' '),
                r.created_at.to_s,
                r.updated_at.to_s,
                r.costcenter.to_s,
                r.originals.to_i.to_s,
                r.copies.to_i.to_s,
                r.color.to_s,
                r.size.to_s.gsub('"', "in"),
                r.weight.to_s,
                "$"+r.estimate.to_s,
                "$"+r.otherestimate.to_s,
                "$"+(r.estimate+r.otherestimate).to_s,
                r.special_info.to_s.gsub(/\n/," ").gsub(/\r/," ").gsub(","," "),
                r.sides.to_s,
                r.stock.to_s,
                r.binding.to_s,
                r.folding.to_s,
                r.color_copy.to_s,
                r.collate.to_s,
                r.staple.to_s,
                r.threehole.to_s,
                r.cut.to_s,
                r.laminate.to_s,
                r.pad.to_s,
                r.black_back.to_s]
        r.billed = true
        r.save
      end
    end
   
  end

end
