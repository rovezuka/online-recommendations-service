class Patient < ApplicationRecord
  # Связь с запросами на консультацию
  has_many :consultation_requests, dependent: :destroy

  def validate_with_contract
    patient_data = {
      full_name: full_name,
      date_of_birth: date_of_birth,
      phone_number: phone_number,
      email: email
    }

    contract = PatientContract.new
    result = contract.call(patient_data)

    if result.success?
      true
    else
      result.errors.each do |error|
        errors.add(error[0], error[1].first)
      end
      false
    end
  end
end
