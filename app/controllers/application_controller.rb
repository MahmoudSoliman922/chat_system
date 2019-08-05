# frozen_string_literal: true

class ApplicationController < ActionController::API
  # render the response based on success

  def render_json(result)
    if result[:errors]&.length&.positive?
      render(json: { success: false, response: [], errors: result[:errors] },
             status: 405)
    else
      render(json: { success: true, response: result[:response], errors: [] })
    end
  end
end
