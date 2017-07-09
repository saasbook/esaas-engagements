module AppsHelper

  def row_background_for(app)
    (app.development? ? 'success' : app.dead? ? 'danger' : nil)
  end
end
