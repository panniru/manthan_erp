class FeeGradeBucketsDecorator < Draper::Decorator
  delegate_all
  delegate :current_page, :total_pages, :limit_value

  def grade_from_name
    GradeMaster.find(model.grade_from).grade_name
  end

  def grade_to_name
    GradeMaster.find(model.grade_to).grade_name
  end
    
  def docorated_hash
    JSON.parse(model.to_json).merge!(:grade_from_name => grade_from_name, :grade_to_name => grade_to_name)
  end
  
  def to_json(options = {})
    JSON.parse(model.to_json).merge!(:grade_from_name => grade_from_name, :grade_to_name => grade_to_name).to_json
  end
  

end
