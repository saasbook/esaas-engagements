module AppsHelper

  def row_background_for(app)
    (app.development? ? 'success' : app.inactive? ? 'danger' : nil)
  end
end
