module Seek
  class Job
    REQUIRED_ATTRIBUTES = %i[
      reference title search_title description ad_details
      listing_market_segments listing_location listing_work_type listing_classification listing_sub_classification
      salary_type salary_min salary_max
      is_stand_out
    ]

    NOT_REQUIRED_ATTRIBUTES = %i[
      template_id screen_id application_email application_url residents_only
      item_job_title item_bullet1 item_bullet2 item_bullet3 item_contact_name item_phone_number item_fax_number item_reference_number
      listing_area
      salary_additional_text
      stand_out_logo_id stand_out_bullet1 stand_out_bullet2 stand_out_bullet3
    ]

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
