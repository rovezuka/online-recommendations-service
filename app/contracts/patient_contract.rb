PatientContract = Dry::Validation.Params do
        required(:full_name).filled(:string)
        required(:date_of_birth).filled(:date)
        required(:phone_number).filled(:string)
        required(:email).filled(format?: URI::MailTo::EMAIL_REGEXP)
      end