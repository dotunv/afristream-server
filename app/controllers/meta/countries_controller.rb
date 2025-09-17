# frozen_string_literal: true

module Meta
  class CountriesController < ApplicationController
    protect_from_forgery with: :null_session

    # GET /meta/countries
    # Returns a curated list of African countries for the MVP demo.
    # Frontend can derive flag emoji from ISO2 code if desired.
    def index
      countries = [
        { code: 'NG', name: 'Nigeria' },
        { code: 'GH', name: 'Ghana' },
        { code: 'KE', name: 'Kenya' },
        { code: 'ZA', name: 'South Africa' },
        { code: 'EG', name: 'Egypt' },
        { code: 'TZ', name: 'Tanzania' },
        { code: 'UG', name: 'Uganda' },
        { code: 'CM', name: 'Cameroon' },
        { code: 'CI', name: 'Côte d’Ivoire' },
        { code: 'SN', name: 'Senegal' },
        { code: 'DZ', name: 'Algeria' },
        { code: 'MA', name: 'Morocco' },
        { code: 'ET', name: 'Ethiopia' },
        { code: 'RW', name: 'Rwanda' },
        { code: 'BF', name: 'Burkina Faso' }
      ]

      render json: { ok: true, countries: countries }
    end

    # GET /meta/countries_with_codes
    def with_codes
      list = calling_codes.map do |code, data|
        { code: code, name: data[:name], dial_code: data[:dial_code] }
      end
      render json: { ok: true, countries: list }
    end

    # GET /meta/phone_mask/:country
    # Returns a simple phone mask suggestion, e.g., "+234 ##########"
    def phone_mask
      country = params[:country].to_s.upcase
      data = calling_codes[country]
      if data
        render json: { ok: true, country: country, mask: data[:mask], dial_code: data[:dial_code] }
      else
        render json: { ok: true, country: country, mask: "+### ##########", dial_code: "+###" }
      end
    end

    private

    # Minimal curated calling codes and simple masks; adjust as needed.
    def calling_codes
      @calling_codes ||= {
        'NG' => { name: 'Nigeria',       dial_code: '+234', mask: '+234 ##########' },
        'GH' => { name: 'Ghana',         dial_code: '+233', mask: '+233 #########' },
        'KE' => { name: 'Kenya',         dial_code: '+254', mask: '+254 #########' },
        'ZA' => { name: 'South Africa',  dial_code: '+27',  mask: '+27 ##########' },
        'EG' => { name: 'Egypt',         dial_code: '+20',  mask: '+20 ##########' },
        'TZ' => { name: 'Tanzania',      dial_code: '+255', mask: '+255 #########' },
        'UG' => { name: 'Uganda',        dial_code: '+256', mask: '+256 #########' },
        'CM' => { name: 'Cameroon',      dial_code: '+237', mask: '+237 #########' },
        'CI' => { name: 'Côte d’Ivoire', dial_code: '+225', mask: '+225 ########' },
        'SN' => { name: 'Senegal',       dial_code: '+221', mask: '+221 ########' },
        'DZ' => { name: 'Algeria',       dial_code: '+213', mask: '+213 #########' },
        'MA' => { name: 'Morocco',       dial_code: '+212', mask: '+212 #########' },
        'ET' => { name: 'Ethiopia',      dial_code: '+251', mask: '+251 ########' },
        'RW' => { name: 'Rwanda',        dial_code: '+250', mask: '+250 #########' },
        'BF' => { name: 'Burkina Faso',  dial_code: '+226', mask: '+226 ########' }
      }
    end
  end
end

