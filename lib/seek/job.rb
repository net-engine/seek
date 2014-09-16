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
      stand_out_logo_id stand_out_bullet_1 stand_out_bullet_2 stand_out_bullet_3
    ]

    attr_accessor(*REQUIRED_ATTRIBUTES)
    attr_accessor(*NOT_REQUIRED_ATTRIBUTES)

    def initialize(attributes)
      [*REQUIRED_ATTRIBUTES + NOT_REQUIRED_ATTRIBUTES].each do |attribute|
        instance_variable_set("@#{attribute}", attributes.delete(attribute).to_s)
      end
    end

    def valid?
      !REQUIRED_ATTRIBUTES.any? do |attribute|
        instance_variable_get("@#{attribute}").blank?
      end
    end

    def to_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.send 'Job', 'Reference' => @reference, 'TemplateID' => @template_id, 'ScreenID' => @screen_id do
          xml.send 'Title',       @title
          xml.send 'SearchTitle', @search_title
          xml.send 'Description', @description

          xml.send 'AdDetails' do
            xml.cdata(@ad_details)
          end

          xml.send 'ApplicationEmail', @application_email
          xml.send 'ApplicationURL',   @application_url
          xml.send 'ResidentsOnly',    @residents_only

          xml.send 'Items' do
            xml.send 'Item', @item_job_title,        'Name' => 'Jobtitle'
            xml.send 'Item', @item_bullet1,          'Name' => 'Bullet1'
            xml.send 'Item', @item_bullet2,          'Name' => 'Bullet2'
            xml.send 'Item', @item_bullet3,          'Name' => 'Bullet3'
            xml.send 'Item', @item_contact_name,     'Name' => 'ContactName'
            xml.send 'Item', @item_phone_number,     'Name' => 'PhoneNo'
            xml.send 'Item', @item_fax_number,       'Name' => 'FaxNo'
            xml.send 'Item', @item_reference_number, 'Name' => 'RefNumber'
          end

          xml.send 'Listing', 'MarketSegments' => @listing_market_segments do
            xml.send 'Classification',  @listing_location,           'Name' => 'Location'
            xml.send 'Classification',  @listing_area,               'Name' => 'Area'
            xml.send 'Classification',  @listing_work_type,          'Name' => 'WorkType'
            xml.send 'Classification',  @listing_classification,     'Name' => 'Classification'
            xml.send 'Classification',  @listing_sub_classification, 'Name' => 'SubClassification'
          end

          xml.send 'Salary',
            'Type'           => @salary_type,
            'Min'            => @salary_min,
            'Max'            => @salary_max,
            'AdditionalText' => @salary_additional_text

          if @is_stand_out
            xml.send 'StandOut',
              'IsStandOut' => @is_stand_out,
              'LogoID'     => @stand_out_logo_id,
              'Bullet1'    => @stand_out_bullet_1,
              'Bullet2'    => @stand_out_bullet_2,
              'Bullet3'    => @stand_out_bullet_3
          end
        end
      end

      Nokogiri::XML(builder.to_xml).root.to_xml.strip
    end
  end
end
