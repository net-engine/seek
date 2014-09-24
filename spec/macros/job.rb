module Macros
  def create_valid_job(all_attributes: false)
    attributes  = Seek::Job::REQUIRED_ATTRIBUTES.clone
    attributes.push(*Seek::Job::NOT_REQUIRED_ATTRIBUTES) if all_attributes

    job_attributes = attributes.inject({}) do |hash, attribute|
      hash[attribute] = case attribute
        when :residents_only             then true
        when :is_stand_out               then false
        when :listing_location           then Seek::Enumerations.nations.first.states.first.locations.first.id
        when :listing_work_type          then Seek::Enumerations.work_types.first.id
        when :listing_classification     then Seek::Enumerations.classifications.first.id
        when :listing_sub_classification then Seek::Enumerations.classifications.first.sub_classifications.first.id

        when :salary_type                then Seek::Enumerations.salary_types.first.id
        when :salary_min                 then 50000
        when :salary_max                 then 69999

        else "#{attribute}_value"
      end

      hash
    end

    Seek::Job.new(job_attributes)
  end
end
