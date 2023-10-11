class PatientsController < ApplicationController
  # Действие для создания нового пациента
  def create
    contract = PatientContract.new
    result = contract.call(patient_params)

    if result.success?
      patient = Patient.new(patient_params)
      if patient.save
        render json: patient, status: :created
      else
        render json: patient.errors, status: :unprocessable_entity
      end
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:full_name, :date_of_birth, :phone_number, :email)
  end
end
