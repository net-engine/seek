module Macros
  def create_valid_job(all_attributes: false)
    attributes  = Seek::Job::REQUIRED_ATTRIBUTES.clone
    attributes.push(*Seek::Job::NOT_REQUIRED_ATTRIBUTES) if all_attributes

    job_attributes = attributes.inject({}) do |hash, attribute|
      hash[attribute] = "#{attribute}_value"
      hash
    end

    Seek::Job.new(job_attributes)
  end
end
