module ControllerMacros
  # :nocov:
  def mapping_user_scope
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end
  end
  # :nocov:
end