module Seek
  class Job
    REQUIRED_ATTRIBUTES = %i[
      reference template_id screen_id title search_title description ad_details application_email application_url residents_only
      job_title bullet1 bullet2 bullet3 contact_name phone_number fax_number reference_number
      location area work_type classification sub_classification
      salary_type salary_min salary_max salary_additional_text
      is_stand_out stand_out_logo_id stand_out_bullet1
    ]

    NOT_REQUIRED_ATTRIBUTES = %i[stand_out_bullet2 stand_out_bullet3]

    attr_accessor(*REQUIRED_ATTRIBUTES)
    attr_accessor(*NOT_REQUIRED_ATTRIBUTES)

    def initialize(attributes)
      [*REQUIRED_ATTRIBUTES + NOT_REQUIRED_ATTRIBUTES].each do |attribute|
        instance_variable_set("@#{attribute}", attributes.delete(attribute))
      end
    end

    def valid?
      !REQUIRED_ATTRIBUTES.any? do |attribute|
        instance_variable_get("@#{attribute}").blank?
      end
    end
  end
end
