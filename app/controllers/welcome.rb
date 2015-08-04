Raspgram::App.controllers :welcome do
  get :index, :map => '/' do
    @admin_email = settings.admin_email
    render 'index'
  end
end
